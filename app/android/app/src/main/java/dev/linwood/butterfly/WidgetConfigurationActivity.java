package dev.linwood.butterfly;

import android.app.Activity;
import android.appwidget.AppWidgetManager;
import android.content.Intent;
import android.os.Bundle;

public class WidgetConfigurationActivity extends MainActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        int id = getIntent().getIntExtra(AppWidgetManager.EXTRA_APPWIDGET_ID,
                AppWidgetManager.INVALID_APPWIDGET_ID);
        setResult(Activity.RESULT_CANCELED,
                new Intent().putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, id));
    }

    String getKind() { return "preview"; }
}
