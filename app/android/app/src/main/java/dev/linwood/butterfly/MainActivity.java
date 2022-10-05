package dev.linwood.butterfly;

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "linwood.dev/butterfly";
    private String intentType = null;
    private String intentData = null;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        Intent intent = getIntent();
        String action = intent.getAction();
        String type = intent.getType();

        if (Intent.ACTION_SEND.equals(action) && type != null) {
            intentType = type;
            intentData = intent.getDataString();
        }

        super.onCreate(savedInstanceState);
    }

    @Override
    public void configureFlutterEngine(io.flutter.embedding.engine.FlutterEngine flutterEngine) {
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
