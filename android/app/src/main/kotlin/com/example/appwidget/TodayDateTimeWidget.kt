package com.example.appwidget

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import es.antonborri.home_widget.HomeWidgetLaunchIntent

class TodayDateTimeWidget : HomeWidgetProvider() {
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

    private fun prayerLargeAppWidget(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int,
        widgetData: SharedPreferences
    ) {
        val currentPrayerName = widgetData.getString("current_prayer_name", null)
        val currentPrayerTime = widgetData.getString("current_prayer_time", null)
        val currentDate = widgetData.getString("Tcurrent_date", null)
        val hijriDate = widgetData.getString("hijri_date", null)
        val nextPrayerTimeFirst = widgetData.getString("next_prayer_time_first", null)
        val nextPrayerTimeSecond = widgetData.getString("next_prayer_time_second", null)
        val currentPrayerTimeFormat = widgetData.getString("current_prayer_time_format", null)
        val nextPrayerTimeFormatFirst = widgetData.getString("next_prayer_time_format_first", null)
        val nextPrayerTimeFormatSecond =
            widgetData.getString("next_prayer_time_format_second", null)
        val currentLocation = widgetData.getString("current_location", null)
        val views = RemoteViews(context.packageName, R.layout.today_date_time_widget)
        if (currentPrayerName != null) views.setTextViewText(
            R.id.tv_current_prayer_name, currentPrayerName
        )
        if (currentPrayerTimeFormat != null) views.setTextViewText(
            R.id.tv_current_prayer_time_format, currentPrayerTimeFormat
        )
        if (currentPrayerTime != null) views.setTextViewText(
            R.id.tv_current_prayer_time, currentPrayerTime
        )
        if (currentDate != null) views.setTextViewText(
            R.id.tv_current_date, currentDate
        )
        if (hijriDate != null) views.setTextViewText(
            R.id.tv_hijri_date, hijriDate
        )
        if (nextPrayerTimeFirst != null) views.setTextViewText(
            R.id.tv_next_prayer_time_first, nextPrayerTimeFirst
        )
        if (nextPrayerTimeSecond != null) views.setTextViewText(
            R.id.tv_next_prayer_time_second, nextPrayerTimeSecond
        )
        if (nextPrayerTimeFormatFirst != null) views.setTextViewText(
            R.id.tv_next_prayer_time_format_first, nextPrayerTimeFormatFirst
        )
        if (nextPrayerTimeFormatSecond != null) views.setTextViewText(
            R.id.tv_next_prayer_time_format_second, nextPrayerTimeFormatSecond
        )
        if (currentLocation != null) views.setTextViewText(
            R.id.tv_location, currentLocation
        )

        appWidgetManager.updateAppWidget(appWidgetId, views)
    }
}