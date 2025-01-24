package com.example.appwidget

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.view.View
import android.widget.RemoteViews
import androidx.core.content.ContextCompat
import es.antonborri.home_widget.HomeWidgetProvider
import es.antonborri.home_widget.HomeWidgetLaunchIntent

class CurrentPrayerTime : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        for (appWidgetId in appWidgetIds) {
            prayerLargeAppWidget(context, appWidgetManager, appWidgetId, widgetData)
        }
    }

internal fun prayerLargeAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int,
    widgetData: SharedPreferences
) {
val currentPrayerName = widgetData.getString("current_prayer_name", null)
        val currentPrayerTimeFormat = widgetData.getString("current_prayer_time_format", null)
        val currentPrayerTime = widgetData.getString("current_prayer_time", null)
        val views = RemoteViews(context.packageName, R.layout.current_prayer_time)
        if (currentPrayerName != null) views.setTextViewText(
            R.id.tv_prayer_name, currentPrayerName
        )
        if (currentPrayerTime != null) views.setTextViewText(
            R.id.tv_prayer_time, currentPrayerTime
        )
        if (currentPrayerTimeFormat != null) views.setTextViewText(
            R.id.tv_prayer_time_format, currentPrayerTimeFormat
        )
        appWidgetManager.updateAppWidget(appWidgetId, views)
}
    
}