package dev.linwood.butterfly;

import android.content.ContentResolver;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "linwood.dev/butterfly";
    private Map<String, Object> importIntent;

    @Override
    @Nullable
    public String getInitialRoute() {
        if (handleIntent(getIntent())) {
            return "/intent";
        }
        return super.getInitialRoute();
    }

    @Override
    protected void onNewIntent(@NonNull Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        if (handleIntent(intent) && getFlutterEngine() != null) {
            getFlutterEngine().getNavigationChannel().pushRoute("/intent");
        }
    }

    private boolean handleIntent(Intent intent) {
        String action = intent.getAction();
        String type = intent.getType();

        if (!Intent.ACTION_VIEW.equals(action)
                && !Intent.ACTION_EDIT.equals(action)
                && !Intent.ACTION_SEND.equals(action)) {
            return false;
        }
        Uri uri = intent.getData();
        if (uri == null) {
            uri = getParcelableExtraStream(intent);
        }
        if (uri == null && intent.getClipData() != null && intent.getClipData().getItemCount() > 0) {
            uri = intent.getClipData().getItemAt(0).getUri();
        }
        if (uri != null) {
            String scheme = uri.getScheme();
            if (!ContentResolver.SCHEME_CONTENT.equals(scheme)
                    && !ContentResolver.SCHEME_FILE.equals(scheme)
                    && !ContentResolver.SCHEME_ANDROID_RESOURCE.equals(scheme)) {
                return false;
            }
            if (type == null) {
                type = getContentResolver().getType(uri);
            }
            setImportIntent(type != null ? type : "application/octet-stream", uri.toString());
            return true;
        }
        if (Intent.ACTION_SEND.equals(action)) {
            String text = intent.getStringExtra(Intent.EXTRA_TEXT);
            if (text != null) {
                setImportIntent(type != null ? type : "text/plain", text.getBytes(StandardCharsets.UTF_8));
                return true;
            }
        }
        return false;
    }

    private void setImportIntent(String type, Object source) {
        Map<String, Object> payload = new HashMap<>();
        payload.put("type", type);
        payload.put("source", source);
        importIntent = payload;
    }

    @Nullable
    @SuppressWarnings("deprecation")
    private Uri getParcelableExtraStream(Intent intent) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            return intent.getParcelableExtra(Intent.EXTRA_STREAM, Uri.class);
        }
        return intent.getParcelableExtra(Intent.EXTRA_STREAM);
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("getImportIntent")) {
                        result.success(importIntent);
                    } else {
                        result.notImplemented();
                    }
                });
    }
}
