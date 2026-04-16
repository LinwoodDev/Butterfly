package dev.linwood.butterfly;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "linwood.dev/butterfly";
    private static final String TAG = "Butterfly";
    private String intentType = null;
    private String intentUri = null;
    private byte[] intentData = null;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        handleIntent(getIntent());
    }

    @Override
    protected void onNewIntent(@NonNull Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        handleIntent(intent);
    }

    private void handleIntent(Intent intent) {
        String action = intent.getAction();
        String type = intent.getType();

        if ((Intent.ACTION_VIEW.equals(action) || Intent.ACTION_EDIT.equals(action) || Intent.ACTION_SEND.equals(action)) && type != null) {
            Uri uri = intent.getData();
            if (uri == null && intent.getClipData() != null && intent.getClipData().getItemCount() > 0) {
                uri = intent.getClipData().getItemAt(0).getUri();
            }
            if (uri != null) {
                intentType = type;
                intentUri = uri.toString();
                final int grantedFlags = intent.getFlags() & (Intent.FLAG_GRANT_READ_URI_PERMISSION | Intent.FLAG_GRANT_WRITE_URI_PERMISSION);
                if ((intent.getFlags() & Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION) != 0) {
                    try {
                        getContentResolver().takePersistableUriPermission(uri, grantedFlags);
                    } catch (SecurityException ignored) {
                    }
                }
                try {
                    InputStream inputStream = getContentResolver().openInputStream(uri);
                    if (inputStream != null) {
                        intentData = getBytes(inputStream);
                        inputStream.close();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                    intentData = null;
                    intentType = null;
                    intentUri = null;
                }
            }
        } else {
            intentType = null;
            intentUri = null;
            intentData = null;
        }
    }

    private byte[] getBytes(InputStream inputStream) throws IOException {
        java.io.ByteArrayOutputStream byteBuffer = new java.io.ByteArrayOutputStream();
        int bufferSize = 1024;
        byte[] buffer = new byte[bufferSize];
        int len;
        while ((len = inputStream.read(buffer)) != -1) {
            byteBuffer.write(buffer, 0, len);
        }
        return byteBuffer.toByteArray();
    }

    private boolean writeContentUriData(String uriString, byte[] data) {
        if (uriString == null || data == null) {
            return false;
        }
        final Uri uri = Uri.parse(uriString);
        final String[] modes = new String[]{"rwt", "wt", "w"};
        for (String mode : modes) {
            try (OutputStream outputStream = getContentResolver().openOutputStream(uri, mode)) {
                if (outputStream == null) {
                    continue;
                }
                outputStream.write(data);
                outputStream.flush();
                return true;
            } catch (IOException | SecurityException e) {
                Log.e(TAG, "Failed to write content URI using mode " + mode + ": " + uriString, e);
            }
        }
        return false;
    }

    @Override
    public void configureFlutterEngine(@NonNull io.flutter.embedding.engine.FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("getIntentType")) {
                                result.success(intentType);
                            } else if (call.method.equals("getIntentData")) {
                                result.success(intentData);
                            } else if (call.method.equals("getIntentUri")) {
                                result.success(intentUri);
                            } else if (call.method.equals("writeContentUriData")) {
                                final String uri = call.argument("uri");
                                final byte[] data = call.argument("data");
                                result.success(writeContentUriData(uri, data));
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }
}
