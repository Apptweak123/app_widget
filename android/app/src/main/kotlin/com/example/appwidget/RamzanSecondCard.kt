package com.example.appwidget

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import es.antonborri.home_widget.HomeWidgetLaunchIntent

class RamzanSecondCard : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        for (appWidgetId in appWidgetIds) {
            updateRamzanSecondAppWidget(context, appWidgetManager, appWidgetId, widgetData)
        }
    }
}

internal fun updateRamzanSecondAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int,
    widgetData: SharedPreferences
) {
     val currentDate = widgetData.getString("current_date", null)
    val sehriTime = widgetData.getString("sehri_Time", null)
    val sehriTimeFormate = widgetData.getString("sehritime_formate", null)
    val iftarTime = widgetData.getString("iftar_time", null)
    val iftariTimeFormate = widgetData.getString("iftaritime_formate", null)
    val views = RemoteViews(context.packageName, R.layout.ramzan_second_card)
   // if (currentDate != null) views.setTextViewText(R.id.tv_current_date, currentDate)
    if (sehriTime != null) views.setTextViewText(R.id.tv_sehri_time, sehriTime)
    if (sehriTimeFormate != null) views.setTextViewText(R.id.tv_sehri_time_format, sehriTimeFormate)
    if (iftarTime != null) views.setTextViewText(R.id.tv_iftar_time, iftarTime)
    if (iftariTimeFormate != null) views.setTextViewText(
        R.id.tv_iftar_time_format, iftariTimeFormate
    )
    appWidgetManager.updateAppWidget(appWidgetId, views)
}