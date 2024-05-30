package dev.linwood.butterfly;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;

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

        if ((Intent.ACTION_VIEW.equals(action) || Intent.ACTION_EDIT.equals(action)) && type != null) {
            intentType = type;
            Uri uri = intent.getData();
            if (uri != null) {
                try {
                    // Open an InputStream to read data from the URI
                    InputStream inputStream = getContentResolver().openInputStream(uri);

                    // Read data from the InputStream into a byte array
                    intentData = new byte[inputStream.available()];
                    inputStream.read(intentData);

                    // Now, you have the data as a byte array in 'byteArray'
                    // You can use it as needed, e.g., display an image or process the data.

                    // Don't forget to close the input stream
                    inputStream.close();
                } catch (IOException e) {
                    intentData = null;
                    intentType = null;
                }

            }
        }
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
                                intentType = null;
                                intentData = null;
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }
}
