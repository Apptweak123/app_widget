package com.example.appwidget

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews

/**
 * Implementation of App Widget functionality.
 */
class ThirdPrayerWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            thirdPrayerWidgetUpdate(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}

internal fun thirdPrayerWidgetUpdate(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int
) {
  //  val widgetText = context.getString(R.string.appwidget_text)
    // Construct the RemoteViews object
  //  val views = RemoteViews(context.packageName, R.layout.third_prayer_widget)
  // views.setTextViewText(R.id.appwidget_text, widgetText)

    // Instruct the widget manager to update the widget
  //  appWidgetManager.updateAppWidget(appWidgetId, views)
}