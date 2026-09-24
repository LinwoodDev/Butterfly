package dev.linwood.butterfly;

import android.app.PendingIntent;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Build;
import android.util.Base64;
import android.view.View;
import android.widget.RemoteViews;

import org.json.JSONException;
import org.json.JSONObject;

class ButterflyWidgetProvider extends AppWidgetProvider {
    static final String PREFS = "butterfly_home_widgets";
    static final String DATA = "data";
    static final String OPEN_ACTION = "dev.linwood.butterfly.OPEN_WIDGET_NOTE";
    static final String ROUTE_EXTRA = "route";

    enum Kind { PREVIEW, RECENTS }
    private final Kind kind;

    ButterflyWidgetProvider(Kind kind) {
        this.kind = kind;
    }

    static String configKey(int id) { return "config_" + id; }

    static void refresh(Context context) {
        AppWidgetManager manager = AppWidgetManager.getInstance(context);
        for (Class<?> provider : new Class<?>[]{PreviewWidgetProvider.class, NotesWidgetProvider.class}) {
            ComponentName name = new ComponentName(context, provider);
            int[] ids = manager.getAppWidgetIds(name);
            if (provider == PreviewWidgetProvider.class) {
                new PreviewWidgetProvider().onUpdate(context, manager, ids);
            } else {
                new NotesWidgetProvider().onUpdate(context, manager, ids);
            }
        }
    }

    @Override
    public void onUpdate(Context context, AppWidgetManager manager, int[] ids) {
        JSONObject data;
        try {
            data = new JSONObject(context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
                    .getString(DATA, "{}"));
        } catch (JSONException error) {
            data = new JSONObject();
        }
        for (int id : ids) {
            JSONObject config;
            try {
                config = new JSONObject(context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
                        .getString(configKey(id), "{}"));
            } catch (JSONException error) {
                config = new JSONObject();
            }
            RemoteViews views = kind == Kind.PREVIEW ? previewViews(context, data, config, id)
                    : notesViews(context, data, config, id);
            manager.updateAppWidget(id, views);
            if (kind == Kind.RECENTS) manager.notifyAppWidgetViewDataChanged(id, R.id.widget_notes_list);
        }
    }

    @Override
    public void onDeleted(Context context, int[] ids) {
        SharedPreferences.Editor editor = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).edit();
        for (int id : ids) editor.remove(configKey(id));
        editor.apply();
    }

    private static PendingIntent open(Context context, String route, int widgetId, int row) {
        Intent intent = new Intent(context, MainActivity.class);
        intent.setAction(OPEN_ACTION);
        intent.putExtra(ROUTE_EXTRA, route);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
        int flags = PendingIntent.FLAG_UPDATE_CURRENT;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) flags |= PendingIntent.FLAG_IMMUTABLE;
        return PendingIntent.getActivity(context, widgetId * 10 + row, intent, flags);
    }

    private static PendingIntent openRecentTemplate(Context context, int widgetId) {
        Intent intent = new Intent(context, MainActivity.class);
        intent.setAction(OPEN_ACTION);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
        int flags = PendingIntent.FLAG_UPDATE_CURRENT;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            flags |= PendingIntent.FLAG_MUTABLE;
        }
        return PendingIntent.getActivity(context, widgetId * 10 + 8, intent, flags);
    }

    private static RemoteViews previewViews(Context context, JSONObject data, JSONObject config, int id) {
        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.widget_preview);
        JSONObject note = data.optJSONObject("previews") == null ? null
                : data.optJSONObject("previews").optJSONObject(Integer.toString(id));
        if (note == null && "preview".equals(config.optString("kind"))) note = config;
        if (note == null) {
            views.setTextViewText(R.id.widget_preview_title, context.getString(R.string.widget_choose_preview));
            views.setOnClickPendingIntent(R.id.widget_preview_root, open(context, "/", id, 0));
            return views;
        }
        views.setTextViewText(R.id.widget_preview_title, note.optString("title", "Butterfly"));
        views.setOnClickPendingIntent(R.id.widget_preview_root,
                open(context, note.optString("route", "/"), id, 0));
        String encoded = note.optString("thumbnail", "");
        if (!encoded.isEmpty()) {
            try {
                byte[] bytes = Base64.decode(encoded, Base64.DEFAULT);
                Bitmap bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.length);
                if (bitmap != null) {
                    int width = Math.min(bitmap.getWidth(), 480);
                    int height = Math.max(1, bitmap.getHeight() * width / bitmap.getWidth());
                    views.setImageViewBitmap(R.id.widget_preview_image,
                            Bitmap.createScaledBitmap(bitmap, width, height, true));
                    views.setViewVisibility(R.id.widget_preview_image, View.VISIBLE);
                }
            } catch (IllegalArgumentException ignored) {
                // A corrupt or obsolete thumbnail leaves the note title usable.
            }
        }
        return views;
    }

    private static RemoteViews notesViews(Context context, JSONObject data, JSONObject config, int id) {
        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.widget_notes);
        Intent adapter = new Intent(context, RecentFilesWidgetService.class);
        adapter.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, id);
        adapter.setData(android.net.Uri.parse("butterfly-widget://recents/" + id));
        views.setRemoteAdapter(R.id.widget_notes_list, adapter);
        views.setPendingIntentTemplate(R.id.widget_notes_list, openRecentTemplate(context, id));
        views.setOnClickPendingIntent(R.id.widget_notes_header, open(context, "/", id, 0));
        views.setOnClickPendingIntent(R.id.widget_notes_new, open(context, "/widget/create?id=" + id, id, 9));
        return views;
    }

}
