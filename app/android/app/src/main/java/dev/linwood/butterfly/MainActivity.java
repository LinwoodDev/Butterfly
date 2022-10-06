package dev.linwood.butterfly;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.ParcelFileDescriptor;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "linwood.dev/butterfly";
    private String intentType = null;
    private byte[] intentData = null;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Intent intent = getIntent();
        String action = intent.getAction();
        String type = intent.getType();

        if (Intent.ACTION_SEND.equals(action) && type != null) {
            System.out.println("Intent type: " + type);
            intentType = type;
            String text = intent.getStringExtra(Intent.EXTRA_TEXT);
            if (text != null) {
                intentData = text.getBytes(StandardCharsets.UTF_8);
            } else {
                System.out.println(intent.getParcelableExtra(Intent.EXTRA_STREAM).toString());
                System.out.println(intent.getData());
                Uri uri = (Uri) intent.getParcelableExtra(Intent.EXTRA_STREAM);
                if (uri != null) {
                    try {
                        intentData = readUriAsBytes(uri);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    private String getPathFromUri(Uri uri) throws IOException {
        ParcelFileDescriptor parcelFileDescriptor =
                getContentResolver().openFileDescriptor(uri, "r");
        if (parcelFileDescriptor == null)
            return null;
        return parcelFileDescriptor
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
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }
}
