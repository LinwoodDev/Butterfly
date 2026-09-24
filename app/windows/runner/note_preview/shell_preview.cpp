#include <windows.h>
#include <objbase.h>
#include <shobjidl.h>
#include <thumbcache.h>
#include <wincodec.h>

#include <algorithm>
#include <array>
#include <cstdint>
#include <new>
#include <string>
#include <vector>

namespace {

#ifdef BUTTERFLY_NIGHTLY
// Nightly and production can be installed side by side.
constexpr CLSID kThumbnailClsid = {0x59fb241d, 0xffa6, 0x4c01,
                                  {0x8a, 0x66, 0x2b, 0xba, 0x71, 0x38, 0x4a, 0x55}};
constexpr CLSID kPreviewClsid = {0xaf658105, 0xf78a, 0x4eb4,
                                {0xa1, 0xb4, 0xaf, 0x96, 0x40, 0x45, 0x83, 0x8f}};
#else
constexpr CLSID kThumbnailClsid = {0x1d0ed140, 0xd9fb, 0x4212,
                                  {0xb0, 0x5f, 0x95, 0xd0, 0x81, 0x6d, 0xe3, 0xcc}};
constexpr CLSID kPreviewClsid = {0xd8380bd5, 0x6f06, 0x421e,
                                {0x93, 0xd3, 0x47, 0x4d, 0x24, 0x6c, 0x50, 0x41}};
#endif

HINSTANCE g_module = nullptr;
long g_objects = 0;
long g_locks = 0;
constexpr wchar_t kPreviewWindowClass[] = L"ButterflyNotePreviewWindow";

class NotePreview final : public IThumbnailProvider,
                          public IInitializeWithStream,
                          public IPreviewHandler {
 public:
  NotePreview() { InterlockedIncrement(&g_objects); }
  ~NotePreview() {
    Unload();
    if (stream_) stream_->Release();
    InterlockedDecrement(&g_objects);
  }

  IFACEMETHODIMP QueryInterface(REFIID iid, void** object) override {
    if (!object) return E_POINTER;
    *object = nullptr;
    if (IsEqualIID(iid, IID_IUnknown) ||
        IsEqualIID(iid, IID_IThumbnailProvider))
      *object = static_cast<IThumbnailProvider*>(this);
    else if (IsEqualIID(iid, IID_IInitializeWithStream))
      *object = static_cast<IInitializeWithStream*>(this);
    else if (IsEqualIID(iid, IID_IPreviewHandler))
      *object = static_cast<IPreviewHandler*>(this);
    else
      return E_NOINTERFACE;
    AddRef();
    return S_OK;
  }

  IFACEMETHODIMP_(ULONG) AddRef() override { return InterlockedIncrement(&refs_); }
  IFACEMETHODIMP_(ULONG) Release() override {
    const ULONG refs = InterlockedDecrement(&refs_);
    if (!refs) delete this;
    return refs;
  }

  IFACEMETHODIMP Initialize(IStream* stream, DWORD) override {
    if (!stream) return E_INVALIDARG;
    if (stream_) return HRESULT_FROM_WIN32(ERROR_ALREADY_INITIALIZED);
    stream_ = stream;
    stream_->AddRef();
    return S_OK;
  }

  IFACEMETHODIMP GetThumbnail(UINT cx, HBITMAP* bitmap,
                              WTS_ALPHATYPE* alpha) override {
    if (!bitmap || !alpha) return E_POINTER;
    *bitmap = nullptr;
    *alpha = WTSAT_UNKNOWN;
    if (!stream_ || !cx) return E_FAIL;
    std::vector<uint8_t> png;
    if (!ReadThumbnail(&png, std::min(cx, 2048u))) return E_FAIL;
    const HRESULT result = DecodeBitmap(png, std::min(cx, 2048u), bitmap);
    if (SUCCEEDED(result)) *alpha = WTSAT_ARGB;
    return result;
  }

  IFACEMETHODIMP SetWindow(HWND parent, const RECT* rect) override {
    if (!parent || !rect) return E_INVALIDARG;
    if (window_) {
      DestroyWindow(window_);
      window_ = nullptr;
    }
    parent_ = parent;
    rect_ = *rect;
    return S_OK;
  }

  IFACEMETHODIMP SetRect(const RECT* rect) override {
    if (!rect) return E_POINTER;
    rect_ = *rect;
    if (window_) MoveWindow(window_, rect_.left, rect_.top,
                            rect_.right - rect_.left, rect_.bottom - rect_.top,
                            TRUE);
    return S_OK;
  }

  IFACEMETHODIMP DoPreview() override {
    if (!parent_ || !stream_) return E_FAIL;
    if (window_) return S_OK;
    WNDCLASSW window_class{};
    window_class.lpfnWndProc = WindowProc;
    window_class.hInstance = g_module;
    window_class.lpszClassName = kPreviewWindowClass;
    window_class.hCursor = LoadCursor(nullptr, IDC_ARROW);
    RegisterClassW(&window_class);
    window_ = CreateWindowExW(0, kPreviewWindowClass, L"", WS_CHILD | WS_VISIBLE,
                              rect_.left, rect_.top, rect_.right - rect_.left,
                              rect_.bottom - rect_.top, parent_, nullptr,
                              g_module, this);
    if (!window_) return HRESULT_FROM_WIN32(GetLastError());
    std::vector<uint8_t> png;
    if (ReadThumbnail(&png, 2048)) DecodeBitmap(png, 2048, &preview_bitmap_);
    InvalidateRect(window_, nullptr, TRUE);
    return S_OK;
  }

  IFACEMETHODIMP Unload() override {
    if (window_) {
      DestroyWindow(window_);
      window_ = nullptr;
    }
    if (preview_bitmap_) {
      DeleteObject(preview_bitmap_);
      preview_bitmap_ = nullptr;
    }
    parent_ = nullptr;
    return S_OK;
  }

  IFACEMETHODIMP SetFocus() override {
    if (!window_) return E_FAIL;
    ::SetFocus(window_);
    return S_OK;
  }

  IFACEMETHODIMP QueryFocus(HWND* focus) override {
    if (!focus) return E_POINTER;
    *focus = ::GetFocus();
    return S_OK;
  }

  IFACEMETHODIMP TranslateAccelerator(MSG*) override { return S_FALSE; }

 private:
  bool ReadThumbnail(std::vector<uint8_t>* png, UINT max_size) {
    STATSTG stat{};
    if (FAILED(stream_->Stat(&stat, STATFLAG_NONAME)) ||
        stat.cbSize.QuadPart > 512ull * 1024 * 1024) return false;
    wchar_t module_path[MAX_PATH]{};
    const DWORD path_length = GetModuleFileNameW(g_module, module_path, MAX_PATH);
    if (!path_length || path_length >= MAX_PATH) return false;
    std::wstring helper(module_path);
    const size_t slash = helper.find_last_of(L"\\/");
    if (slash == std::wstring::npos) return false;
    helper.resize(slash + 1);
    helper += L"butterfly-thumbnailer.exe";

    // Preview handlers run at low integrity. Anonymous pipes avoid writing to
    // a temp directory that the preview host may not be allowed to modify.
    SECURITY_ATTRIBUTES attributes{sizeof(SECURITY_ATTRIBUTES), nullptr, TRUE};
    HANDLE child_input = nullptr, parent_input = nullptr;
    HANDLE parent_output = nullptr, child_output = nullptr;
    if (!CreatePipe(&child_input, &parent_input, &attributes, 0)) return false;
    if (!CreatePipe(&parent_output, &child_output, &attributes, 0)) {
      CloseHandle(child_input);
      CloseHandle(parent_input);
      return false;
    }
    if (!SetHandleInformation(parent_input, HANDLE_FLAG_INHERIT, 0) ||
        !SetHandleInformation(parent_output, HANDLE_FLAG_INHERIT, 0)) {
      CloseHandle(child_input); CloseHandle(parent_input);
      CloseHandle(child_output); CloseHandle(parent_output);
      return false;
    }
    HANDLE null_output = CreateFileW(L"NUL", GENERIC_WRITE, FILE_SHARE_WRITE,
                                     &attributes, OPEN_EXISTING,
                                     FILE_ATTRIBUTE_NORMAL, nullptr);
    if (null_output == INVALID_HANDLE_VALUE) {
      CloseHandle(child_input); CloseHandle(parent_input);
      CloseHandle(child_output); CloseHandle(parent_output);
      return false;
    }
    std::wstring command = L"\"" + helper + L"\" - - " +
                           std::to_wstring(max_size);
    STARTUPINFOW startup{};
    startup.cb = sizeof(startup);
    startup.dwFlags = STARTF_USESTDHANDLES;
    startup.hStdInput = child_input;
    startup.hStdOutput = child_output;
    startup.hStdError = null_output;
    PROCESS_INFORMATION process{};
    bool ok = CreateProcessW(helper.c_str(), command.data(), nullptr, nullptr,
                             TRUE, CREATE_NO_WINDOW, nullptr, nullptr,
                             &startup, &process) != FALSE;
    CloseHandle(child_input);
    CloseHandle(child_output);
    CloseHandle(null_output);
    if (!ok) {
      CloseHandle(parent_input); CloseHandle(parent_output);
      return false;
    }

    LARGE_INTEGER start{};
    ok = SUCCEEDED(stream_->Seek(start, STREAM_SEEK_SET, nullptr));
    std::array<uint8_t, 65536> chunk{};
    uint64_t remaining = stat.cbSize.QuadPart;
    while (ok && remaining) {
      ULONG got = 0;
      const ULONG wanted = static_cast<ULONG>(
          std::min<uint64_t>(remaining, chunk.size()));
      ok = SUCCEEDED(stream_->Read(chunk.data(), wanted, &got)) && got > 0;
      DWORD written = 0;
      if (ok) ok = WriteFile(parent_input, chunk.data(), got, &written, nullptr) &&
                   written == got;
      remaining -= got;
    }
    CloseHandle(parent_input);

    const ULONGLONG deadline = GetTickCount64() + 20000;
    while (ok && GetTickCount64() < deadline) {
      DWORD available = 0;
      if (!PeekNamedPipe(parent_output, nullptr, 0, nullptr, &available,
                         nullptr)) break;
      if (available) {
        DWORD got = 0;
        const DWORD wanted = std::min(available, static_cast<DWORD>(chunk.size()));
        ok = ReadFile(parent_output, chunk.data(), wanted, &got, nullptr) &&
             got > 0 && png->size() + got <= 16 * 1024 * 1024;
        if (ok) png->insert(png->end(), chunk.begin(), chunk.begin() + got);
      } else if (WaitForSingleObject(process.hProcess, 20) == WAIT_OBJECT_0) {
        break;
      }
    }
    CloseHandle(parent_output);
    const DWORD wait = WaitForSingleObject(process.hProcess, 0);
    if (wait != WAIT_OBJECT_0) {
      TerminateProcess(process.hProcess, 1);
      WaitForSingleObject(process.hProcess, 5000);
      ok = false;
    }
    DWORD code = 1;
    ok = ok && GetExitCodeProcess(process.hProcess, &code) && code == 0 &&
         png->size() >= 8;
    CloseHandle(process.hThread);
    CloseHandle(process.hProcess);
    return ok;
  }

  static HRESULT DecodeBitmap(const std::vector<uint8_t>& png, UINT max_size,
                              HBITMAP* bitmap) {
    IWICImagingFactory* factory = nullptr;
    IWICStream* stream = nullptr;
    IWICBitmapDecoder* decoder = nullptr;
    IWICBitmapFrameDecode* frame = nullptr;
    IWICBitmapScaler* scaler = nullptr;
    IWICFormatConverter* converter = nullptr;
    HRESULT result = CoCreateInstance(CLSID_WICImagingFactory, nullptr,
                                      CLSCTX_INPROC_SERVER, IID_PPV_ARGS(&factory));
    if (SUCCEEDED(result)) result = factory->CreateStream(&stream);
    if (SUCCEEDED(result)) result = stream->InitializeFromMemory(
        const_cast<BYTE*>(png.data()), static_cast<DWORD>(png.size()));
    if (SUCCEEDED(result)) result = factory->CreateDecoderFromStream(
        stream, nullptr, WICDecodeMetadataCacheOnLoad, &decoder);
    if (SUCCEEDED(result)) result = decoder->GetFrame(0, &frame);
    UINT width = 0, height = 0;
    if (SUCCEEDED(result)) result = frame->GetSize(&width, &height);
    if (SUCCEEDED(result) && (!width || !height)) result = E_FAIL;
    if (SUCCEEDED(result)) {
      const double scale = std::min(1.0, static_cast<double>(max_size) /
                                           std::max(width, height));
      width = std::max(1u, static_cast<UINT>(width * scale));
      height = std::max(1u, static_cast<UINT>(height * scale));
      result = factory->CreateBitmapScaler(&scaler);
    }
    if (SUCCEEDED(result)) result = scaler->Initialize(
        frame, width, height, WICBitmapInterpolationModeFant);
    if (SUCCEEDED(result)) result = factory->CreateFormatConverter(&converter);
    if (SUCCEEDED(result)) result = converter->Initialize(
        scaler, GUID_WICPixelFormat32bppPBGRA, WICBitmapDitherTypeNone,
        nullptr, 0, WICBitmapPaletteTypeCustom);
    if (SUCCEEDED(result)) {
      BITMAPINFO info{};
      info.bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
      info.bmiHeader.biWidth = static_cast<LONG>(width);
      info.bmiHeader.biHeight = -static_cast<LONG>(height);
      info.bmiHeader.biPlanes = 1;
      info.bmiHeader.biBitCount = 32;
      info.bmiHeader.biCompression = BI_RGB;
      void* pixels = nullptr;
      *bitmap = CreateDIBSection(nullptr, &info, DIB_RGB_COLORS, &pixels,
                                 nullptr, 0);
      if (!*bitmap) result = HRESULT_FROM_WIN32(GetLastError());
      if (SUCCEEDED(result)) {
        result = converter->CopyPixels(nullptr, width * 4,
                                       width * height * 4,
                                       static_cast<BYTE*>(pixels));
        if (FAILED(result)) {
          DeleteObject(*bitmap);
          *bitmap = nullptr;
        }
      }
    }
    if (converter) converter->Release();
    if (scaler) scaler->Release();
    if (frame) frame->Release();
    if (decoder) decoder->Release();
    if (stream) stream->Release();
    if (factory) factory->Release();
    return result;
  }

  static LRESULT CALLBACK WindowProc(HWND window, UINT message, WPARAM wparam,
                                     LPARAM lparam) {
    if (message == WM_NCCREATE) {
      auto* create = reinterpret_cast<CREATESTRUCTW*>(lparam);
      SetWindowLongPtrW(window, GWLP_USERDATA,
                        reinterpret_cast<LONG_PTR>(create->lpCreateParams));
    }
    auto* self = reinterpret_cast<NotePreview*>(
        GetWindowLongPtrW(window, GWLP_USERDATA));
    if (message == WM_PAINT) {
      PAINTSTRUCT paint{};
      HDC target = BeginPaint(window, &paint);
      RECT bounds{};
      GetClientRect(window, &bounds);
      FillRect(target, &bounds, reinterpret_cast<HBRUSH>(COLOR_WINDOW + 1));
      if (self && self->preview_bitmap_ &&
          bounds.right > bounds.left && bounds.bottom > bounds.top) {
        BITMAP bitmap{};
        GetObjectW(self->preview_bitmap_, sizeof(bitmap), &bitmap);
        const int box_width = bounds.right - bounds.left;
        const int box_height = bounds.bottom - bounds.top;
        const double scale = std::min(
            static_cast<double>(box_width) / bitmap.bmWidth,
            static_cast<double>(box_height) / bitmap.bmHeight);
        const int width = static_cast<int>(bitmap.bmWidth * scale);
        const int height = static_cast<int>(bitmap.bmHeight * scale);
        HDC source = CreateCompatibleDC(target);
        HGDIOBJ old = SelectObject(source, self->preview_bitmap_);
        SetStretchBltMode(target, HALFTONE);
        StretchBlt(target, (box_width - width) / 2, (box_height - height) / 2,
                   width, height, source, 0, 0, bitmap.bmWidth, bitmap.bmHeight,
                   SRCCOPY);
        SelectObject(source, old);
        DeleteDC(source);
      }
      EndPaint(window, &paint);
      return 0;
    }
    return DefWindowProcW(window, message, wparam, lparam);
  }

  long refs_ = 1;
  IStream* stream_ = nullptr;
  HWND parent_ = nullptr;
  HWND window_ = nullptr;
  RECT rect_{};
  HBITMAP preview_bitmap_ = nullptr;
};

class PreviewClassFactory final : public IClassFactory {
 public:
  PreviewClassFactory() { InterlockedIncrement(&g_objects); }
  ~PreviewClassFactory() { InterlockedDecrement(&g_objects); }
  IFACEMETHODIMP QueryInterface(REFIID iid, void** object) override {
    if (!object) return E_POINTER;
    *object = nullptr;
    if (!IsEqualIID(iid, IID_IUnknown) &&
        !IsEqualIID(iid, IID_IClassFactory)) return E_NOINTERFACE;
    *object = static_cast<IClassFactory*>(this);
    AddRef();
    return S_OK;
  }
  IFACEMETHODIMP_(ULONG) AddRef() override { return InterlockedIncrement(&refs_); }
  IFACEMETHODIMP_(ULONG) Release() override {
    ULONG refs = InterlockedDecrement(&refs_);
    if (!refs) delete this;
    return refs;
  }
  IFACEMETHODIMP CreateInstance(IUnknown* outer, REFIID iid,
                                void** object) override {
    if (outer) return CLASS_E_NOAGGREGATION;
    auto* preview = new (std::nothrow) NotePreview();
    if (!preview) return E_OUTOFMEMORY;
    HRESULT result = preview->QueryInterface(iid, object);
    preview->Release();
    return result;
  }
  IFACEMETHODIMP LockServer(BOOL lock) override {
    if (lock) InterlockedIncrement(&g_locks);
    else InterlockedDecrement(&g_locks);
    return S_OK;
  }

 private:
  long refs_ = 1;
};

}  // namespace

BOOL WINAPI DllMain(HINSTANCE module, DWORD reason, LPVOID) {
  if (reason == DLL_PROCESS_ATTACH) {
    g_module = module;
    DisableThreadLibraryCalls(module);
  }
  return TRUE;
}

STDAPI DllGetClassObject(REFCLSID clsid, REFIID iid, void** object) {
  if (!IsEqualCLSID(clsid, kThumbnailClsid) &&
      !IsEqualCLSID(clsid, kPreviewClsid))
    return CLASS_E_CLASSNOTAVAILABLE;
  auto* factory = new (std::nothrow) PreviewClassFactory();
  if (!factory) return E_OUTOFMEMORY;
  HRESULT result = factory->QueryInterface(iid, object);
  factory->Release();
  return result;
}

STDAPI DllCanUnloadNow() {
  return g_objects == 0 && g_locks == 0 ? S_OK : S_FALSE;
}
