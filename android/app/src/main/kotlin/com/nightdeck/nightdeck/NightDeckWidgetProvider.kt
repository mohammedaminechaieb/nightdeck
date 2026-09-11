package com.nightdeck.nightdeck

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

/**
 * Renders the current time_label / now_playing pair (pushed from Dart via
 * HomeWidgetService.pushState) into a home/lock-screen widget.
 * Requires the `home_widget` package's Android glue (HomeWidgetPlugin) —
 * already pulled in automatically once you add home_widget to pubspec.yaml
 * and run `flutter pub get`.
 */
class NightDeckWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        val data = HomeWidgetPlugin.getData(context)
        val timeLabel = data.getString("time_label", "--:--")
        val nowPlaying = data.getString("now_playing", "")

        for (widgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.nightdeck_widget).apply {
                setTextViewText(R.id.widget_time, timeLabel)
                setTextViewText(R.id.widget_now_playing, nowPlaying)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
