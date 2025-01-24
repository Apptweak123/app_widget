package com.example.appwidget

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.view.View
import android.widget.RemoteViews
import androidx.core.content.ContextCompat
import es.antonborri.home_widget.HomeWidgetProvider
import es.antonborri.home_widget.HomeWidgetLaunchIntent

class ModernFastingTimeWidget : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        for (appWidgetId in appWidgetIds) {
            modernFastingTimeWidget(context, appWidgetManager, appWidgetId, widgetData)
        }
    }

    internal fun modernFastingTimeWidget(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int,
        widgetData: SharedPreferences
    ) {
        val sehriTime = widgetData.getString("sehri_time", null)
        val sehriTimeFormat = widgetData.getString("sehri_time_format", null)
        val views = RemoteViews(context.packageName, R.layout.modern_fasting_time_widget)
        if (sehriTime != null) views.setTextViewText(
            R.id.tv_sehri_time, sehriTime
        )
        if (sehriTimeFormat != null) views.setTextViewText(
            R.id.tv_sehri_time_format, sehriTimeFormat
        )
        appWidgetManager.updateAppWidget(appWidgetId, views)
    }
}