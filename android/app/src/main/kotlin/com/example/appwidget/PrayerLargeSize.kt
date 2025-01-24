package com.example.appwidget

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.view.View
import android.widget.RemoteViews
import androidx.core.content.ContextCompat
import es.antonborri.home_widget.HomeWidgetProvider
import es.antonborri.home_widget.HomeWidgetLaunchIntent

class PrayerLargeSize : HomeWidgetProvider() {
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
}

internal fun prayerLargeAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int,
    widgetData: SharedPreferences
) {
    val hijriDate = widgetData.getString("hijri_date", null)
    val currentDateTime = widgetData.getString("current_date", null)
    val views = RemoteViews(context.packageName, R.layout.prayer_large_size)
    if (hijriDate != null) views.setTextViewText(R.id.vertical_hijriDate, hijriDate)
    if (currentDateTime != null) views.setTextViewText(
        R.id.vertical_currentDateTime, currentDateTime
    )

    val prayerList = verticalFromPrayerList(widgetData)
    setPrayerVerticalList(prayerList, views, context)
    views.setViewVisibility(R.id.prayer_verticalContainer, View.VISIBLE)
    appWidgetManager.updateAppWidget(appWidgetId, views)
}

fun verticalFromPrayerList(widgetData: SharedPreferences): List<PrayerModel> {
    val fajarPrayerName = widgetData.getString("fajar_prayer_name", null)
    val fajarPrayerTime = widgetData.getString("fajar_prayer_time", null)
    val dhuhrPrayerName = widgetData.getString("dhuhr_prayer_name", null)
    val dhuhrPrayerTime = widgetData.getString("dhuhr_prayer_time", null)
    val asarPrayerName = widgetData.getString("asar_prayer_name", null)
    val asarPrayerTime = widgetData.getString("asar_prayer_time", null)
    val maghribPrayerName = widgetData.getString("maghrib_prayer_name", null)
    val maghribPrayerTime = widgetData.getString("maghrib_prayer_time", null)
    val ishaPrayerName = widgetData.getString("isha_prayer_name", null)
    val ishaPrayerTime = widgetData.getString("isha_prayer_time", null)

    return listOf(
        PrayerModel(R.drawable.fajar, fajarPrayerName!!, fajarPrayerTime!!),
        PrayerModel(R.drawable.dhuhricon, dhuhrPrayerName!!, dhuhrPrayerTime!!),
        PrayerModel(R.drawable.asaricon, asarPrayerName!!, asarPrayerTime!!),
        PrayerModel(R.drawable.magrib, maghribPrayerName!!, maghribPrayerTime!!),
        PrayerModel(R.drawable.isha, ishaPrayerName!!, ishaPrayerTime!!)
    )
}

fun setPrayerVerticalList(prayerList: List<PrayerModel>, views: RemoteViews, context: Context) {
    views.removeAllViews(R.id.prayer_verticalContainer)
    prayerList.forEachIndexed { index, prayer ->
        val prayerView = RemoteViews(context.packageName, R.layout.prayer_item_vertical)
        prayerView.setTextViewText(R.id.vertical_prayerItemName, prayer.prayerName)
        prayerView.setTextViewText(R.id.vertical_prayerItemTime, prayer.prayerTime)

        if (prayer.prayerName == "Fajr") {
            prayerView.setInt(
                R.id.prayer_verticalItem,
                "setBackgroundColor",
                ContextCompat.getColor(context, R.color.highlight_color)
            )
        } else {
            prayerView.setInt(
                R.id.prayer_verticalItem,
                "setBackgroundColor",
                ContextCompat.getColor(context, R.color.default_color)
            )
        }



        views.addView(R.id.prayer_verticalContainer, prayerView)
    }
}