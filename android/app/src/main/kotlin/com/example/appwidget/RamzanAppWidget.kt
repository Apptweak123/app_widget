package com.example.appwidget

import android.annotation.SuppressLint
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import es.antonborri.home_widget.HomeWidgetLaunchIntent

class RamzanAppWidget : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId, widgetData)
        }
    }

}

@SuppressLint("RemoteViewLayout")
internal fun updateAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int,
    widgetData: SharedPreferences
) {
  val sehriTime = widgetData.getString("modren_sehri_Time", null)
    val sehriTimeFormate = widgetData.getString("modren_sehritime_formate", null)
    val iftarTime = widgetData.getString("modren_iftar_time", null)
    val iftariTimeFormate = widgetData.getString("modren_iftaritime_formate", null)
    val views = RemoteViews(context.packageName, R.layout.ramzan_app_widget)
    if (sehriTime != null) views.setTextViewText(R.id.tv_sehri_time, sehriTime)   
     if (sehriTimeFormate != null) views.setTextViewText(R.id.tv_sehri_time_format, sehriTimeFormate)
    if (iftarTime != null) views.setTextViewText(R.id.tv_iftar_time, iftarTime)
    if (iftariTimeFormate != null) views.setTextViewText(
        R.id.tv_iftar_time_format, iftariTimeFormate
    )
    appWidgetManager.updateAppWidget(appWidgetId, views)
}