package dev.linwood.butterfly;

import android.content.Context;
import android.content.Intent;
import android.widget.RemoteViews;
import android.widget.RemoteViewsService;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class RecentFilesWidgetService extends RemoteViewsService {
    @Override
    public RemoteViewsFactory onGetViewFactory(Intent intent) {
        return new RecentFilesFactory(getApplicationContext());
    }

    private static class RecentFilesFactory implements RemoteViewsFactory {
        private final Context context;
        private JSONArray files = new JSONArray();

        RecentFilesFactory(Context context) {
            this.context = context;
        }

        @Override
        public void onCreate() { onDataSetChanged(); }

        @Override
        public void onDataSetChanged() {
            try {
                String raw = context.getSharedPreferences(ButterflyWidgetProvider.PREFS, Context.MODE_PRIVATE)
                        .getString(ButterflyWidgetProvider.DATA, "{}");
                JSONArray updated = new JSONObject(raw).optJSONArray("recents");
                files = updated == null ? new JSONArray() : updated;
            } catch (JSONException error) {
                files = new JSONArray();
            }
        }

        @Override
        public void onDestroy() { }

        @Override
        public int getCount() {
            return Math.max(1, files.length());
        }

        @Override
        public RemoteViews getViewAt(int position) {
            RemoteViews row = new RemoteViews(context.getPackageName(), R.layout.widget_note_row);
            JSONObject file = files.optJSONObject(position);
            String route = file == null ? "/" : file.optString("route", "/");
            row.setTextViewText(R.id.widget_note_title, file == null
                    ? context.getString(R.string.widget_no_recent_files)
                    : file.optString("title", "Butterfly"));
            Intent fillIn = new Intent();
            fillIn.putExtra(ButterflyWidgetProvider.ROUTE_EXTRA, route);
            row.setOnClickFillInIntent(R.id.widget_note_title, fillIn);
            return row;
        }

        @Override
        public RemoteViews getLoadingView() { return null; }

        @Override
        public int getViewTypeCount() { return 1; }

        @Override
        public long getItemId(int position) { return position; }

        @Override
        public boolean hasStableIds() { return false; }
    }
}
