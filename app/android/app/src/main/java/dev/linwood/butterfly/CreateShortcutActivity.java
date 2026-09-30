package dev.linwood.butterfly;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

public class CreateShortcutActivity extends MainActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setResult(Activity.RESULT_CANCELED, new Intent());
    }
}
