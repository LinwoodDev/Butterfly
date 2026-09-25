package dev.linwood.butterfly;

import android.content.Intent;
import android.app.Activity;
import android.appwidget.AppWidgetManager;
import android.content.pm.ShortcutInfo;
import android.content.pm.ShortcutManager;
import android.graphics.drawable.Icon;
import android.net.Uri;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.json.JSONObject;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "linwood.dev/butterfly";
    private static final String WIDGET_CHANNEL = "linwood.dev/butterfly/widgets";
    private String intentType = null;
    private byte[] intentData = null;

    @Override
    @Nullable
    public String getInitialRoute() {
        if (this instanceof CreateShortcutActivity) return "/shortcut/configure";
        if (this instanceof WidgetConfigurationActivity) return widgetConfigurationRoute();
        if (handleIntent(getIntent())) {
            return "/intent";
        }
        return super.getInitialRoute();
    }

    private String widgetConfigurationRoute() {
        int id = getIntent().getIntExtra(AppWidgetManager.EXTRA_APPWIDGET_ID,
                AppWidgetManager.INVALID_APPWIDGET_ID);
        String kind = ((WidgetConfigurationActivity) this).getKind();
        return "/widget/configure?id=" + id + "&kind=" + kind;
    }

    @Override
    protected void onNewIntent(@NonNull Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        if (ButterflyWidgetProvider.OPEN_ACTION.equals(intent.getAction())) {
            if (getFlutterEngine() != null) {
                new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), WIDGET_CHANNEL)
                        .invokeMethod("open", intent.getStringExtra(ButterflyWidgetProvider.ROUTE_EXTRA));
            }
            return;
        }
        if (handleIntent(intent) && getFlutterEngine() != null) {
            getFlutterEngine().getNavigationChannel().pushRoute("/intent");
        }
    }

    private boolean handleIntent(Intent intent) {
        String action = intent.getAction();
        String type = intent.getType();

        if (Intent.ACTION_VIEW.equals(action) || Intent.ACTION_EDIT.equals(action) || Intent.ACTION_SEND.equals(action)) {
            Uri uri = intent.getData();
            if (uri == null) {
                uri = getParcelableExtraStream(intent);
            }
            if (uri == null && intent.getClipData() != null && intent.getClipData().getItemCount() > 0) {
                uri = intent.getClipData().getItemAt(0).getUri();
            }
            if (uri != null) {
                if (type == null) {
                    type = getContentResolver().getType(uri);
                }
                if (type == null) {
                    type = "application/octet-stream";
                }
                intentType = type;
                try {
                    InputStream inputStream = getContentResolver().openInputStream(uri);
                    if (inputStream != null) {
                        intentData = getBytes(inputStream);
                        inputStream.close();
                        return true;
                    }
                } catch (IOException e) {
                    //noinspection CallToPrintStackTrace
                    e.printStackTrace();
                    intentData = null;
                    intentType = null;
                }
            } else if (Intent.ACTION_SEND.equals(action) && intent.hasExtra(Intent.EXTRA_TEXT)) {
                String text = intent.getStringExtra(Intent.EXTRA_TEXT);
                if (text != null) {
                    intentType = type != null ? type : "text/plain";
                    intentData = text.getBytes(StandardCharsets.UTF_8);
                    return true;
                }
            }
        }
        return false;
    }

    @Nullable
    @SuppressWarnings("deprecation")
    private Uri getParcelableExtraStream(Intent intent) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            return intent.getParcelableExtra(Intent.EXTRA_STREAM, Uri.class);
        }
        return intent.getParcelableExtra(Intent.EXTRA_STREAM);
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

    @Override
    public void configureFlutterEngine(@NonNull io.flutter.embedding.engine.FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), WIDGET_CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("getRoute")) {
                        Intent intent = getIntent();
                        result.success(this instanceof CreateShortcutActivity
                                ? "/shortcut/configure"
                                : this instanceof WidgetConfigurationActivity
                                    ? widgetConfigurationRoute()
                                    : ButterflyWidgetProvider.OPEN_ACTION.equals(intent.getAction())
                                        ? intent.getStringExtra(ButterflyWidgetProvider.ROUTE_EXTRA) : null);
                    } else if (call.method.equals("update")) {
                        getSharedPreferences(ButterflyWidgetProvider.PREFS, MODE_PRIVATE).edit()
                                .putString(ButterflyWidgetProvider.DATA, (String) call.arguments).apply();
                        ButterflyWidgetProvider.refresh(this);
                        result.success(null);
                    } else if (call.method.equals("getConfigs")) {
                        ArrayList<Map<String, Object>> configs = new ArrayList<>();
                        AppWidgetManager manager = AppWidgetManager.getInstance(this);
                        int[] ids = manager.getAppWidgetIds(new android.content.ComponentName(this, PreviewWidgetProvider.class));
                        for (int id : ids) {
                            try {
                                String raw = getSharedPreferences(ButterflyWidgetProvider.PREFS, MODE_PRIVATE)
                                        .getString(ButterflyWidgetProvider.configKey(id), "{}");
                                JSONObject config = new JSONObject(raw);
                                if (!"preview".equals(config.optString("kind"))) continue;
                                Map<String, Object> entry = new HashMap<>();
                                entry.put("id", id);
                                entry.put("kind", "preview");
                                entry.put("remote", config.optString("remote"));
                                entry.put("path", config.optString("path"));
                                configs.add(entry);
                            } catch (Exception ignored) { }
                        }
                        result.success(configs);
                    } else if (call.method.equals("getConfig")) {
                        Integer id = (Integer) call.arguments;
                        result.success(getSharedPreferences(ButterflyWidgetProvider.PREFS, MODE_PRIVATE)
                                .getString(ButterflyWidgetProvider.configKey(id), null));
                    } else if (call.method.equals("createShortcut")) {
                        if (!(this instanceof CreateShortcutActivity)
                                || !Intent.ACTION_CREATE_SHORTCUT.equals(getIntent().getAction())) {
                            result.error("not_shortcut_creation", "Shortcut creation is not active", null);
                            return;
                        }
                        String config = (String) call.arguments;
                        String route = new Uri.Builder().path("/shortcut/create")
                                .appendQueryParameter("config", config).build().toString();
                        Intent launch = new Intent(this, MainActivity.class);
                        launch.setAction(ButterflyWidgetProvider.OPEN_ACTION);
                        launch.putExtra(ButterflyWidgetProvider.ROUTE_EXTRA, route);
                        launch.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_SINGLE_TOP);
                        String label = getString(R.string.shortcut_create_name);
                        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
                            Intent response = new Intent()
                                    .putExtra(Intent.EXTRA_SHORTCUT_INTENT, launch)
                                    .putExtra(Intent.EXTRA_SHORTCUT_NAME, label)
                                    .putExtra(Intent.EXTRA_SHORTCUT_ICON_RESOURCE,
                                            Intent.ShortcutIconResource.fromContext(this, R.mipmap.ic_launcher));
                            setResult(Activity.RESULT_OK, response);
                            result.success(null);
                            finish();
                            return;
                        }
                        String shortcutId = "create-note-" + UUID.nameUUIDFromBytes(
                                config.getBytes(StandardCharsets.UTF_8));
                        ShortcutInfo shortcut = new ShortcutInfo.Builder(this, shortcutId)
                                .setShortLabel(label)
                                .setIcon(Icon.createWithResource(this, R.drawable.ic_shortcut_create))
                                .setIntent(launch)
                                .build();
                        ShortcutManager shortcuts = getSystemService(ShortcutManager.class);
                        new Thread(() -> {
                            try {
                                Intent response = shortcuts.createShortcutResultIntent(shortcut);
                                runOnUiThread(() -> {
                                    if (response == null) {
                                        result.error("unsupported_launcher", "Launcher cannot create shortcuts", null);
                                        return;
                                    }
                                    setResult(Activity.RESULT_OK, response);
                                    result.success(null);
                                    finish();
                                });
                            } catch (Exception error) {
                                runOnUiThread(() -> result.error("shortcut_failed", error.getMessage(), null));
                            }
                        }).start();
                    } else if (call.method.equals("saveConfig")) {
                        if (!(this instanceof WidgetConfigurationActivity)) {
                            result.error("not_configuration", "Widget setup is not active", null);
                            return;
                        }
                        Map<?, ?> args = (Map<?, ?>) call.arguments;
                        int id = (Integer) args.get("id");
                        int actualId = getIntent().getIntExtra(AppWidgetManager.EXTRA_APPWIDGET_ID,
                                AppWidgetManager.INVALID_APPWIDGET_ID);
                        if (id != actualId || id == AppWidgetManager.INVALID_APPWIDGET_ID) {
                            result.error("invalid_widget", "Invalid widget ID", null);
                            return;
                        }
                        String config = (String) args.get("config");
                        getSharedPreferences(ButterflyWidgetProvider.PREFS, MODE_PRIVATE).edit()
                                .putString(ButterflyWidgetProvider.configKey(id), config).apply();
                        ButterflyWidgetProvider.refresh(this);
                        Intent response = new Intent().putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, id);
                        setResult(Activity.RESULT_OK, response);
                        result.success(null);
                        finish();
                    } else {
                        result.notImplemented();
                    }
                });
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
