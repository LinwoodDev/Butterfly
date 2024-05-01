package dev.linwood.butterfly;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;


public class MainActivity extends FlutterActivity {
    private static final int SAVE_REQUEST_CODE = 77777;
    private static final String CHANNEL = "linwood.dev/butterfly";
    private String intentType = null;
    private byte[] intentData = null;
    private byte[] saveData = null;
    private MethodChannel.Result saveResult = null;

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
                            switch (call.method) {
                                case "getIntentType":
                                    result.success(intentType);
                                    break;
                                case "getIntentData":
                                    result.success(intentData);
                                    intentType = null;
                                    intentData = null;
                                    break;
                                case "saveFile":
                                    saveResult = result;
                                    saveData = call.argument("data");
                                    saveFile(call.argument("mime"), call.argument("name"));
                                    break;
                                default:
                                    result.notImplemented();
                                    break;
                            }
                        }
                );
    }


    private void saveFile(String mime, String fileName) {
        // when you create document, you need to add Intent.ACTION_CREATE_DOCUMENT
        Intent intent = new Intent(Intent.ACTION_CREATE_DOCUMENT);

        // filter to only show openable items.
        intent.addCategory(Intent.CATEGORY_OPENABLE);

        // Create a file with the requested Mime type
        intent.setType(mime);
        intent.putExtra(Intent.EXTRA_TITLE, fileName);

        startActivityForResult(intent, SAVE_REQUEST_CODE);
    }


    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == SAVE_REQUEST_CODE) {
            switch (resultCode) {
                case Activity.RESULT_OK:
                    if (data != null && data.getData() != null) {
                        //now write the data
                        saveInFile(data.getData()); //data.getData() is Uri
                    }
                    break;
                case Activity.RESULT_CANCELED:
                    saveResult.success(false);
                    break;
            }
        }
    }

    private void saveInFile(Uri uri) {
        OutputStream outputStream;
        try {
            outputStream = getContentResolver().openOutputStream(uri);
            if (outputStream == null) {
                saveResult.success(false);
                return;
            }
            outputStream.write(saveData);
            outputStream.flush();
            outputStream.close();
            saveResult.success(true);
        } catch (IOException e) {
            saveResult.error("ERROR", "Unable to write", null);
        }
    }
}
