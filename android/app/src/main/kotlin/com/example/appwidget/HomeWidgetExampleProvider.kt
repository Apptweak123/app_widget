package com.example.appwidget
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.view.View
import android.widget.RemoteViews
import androidx.core.content.ContextCompat
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class HomeWidgetExampleProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
       //     updateAppWidget(context, appWidgetManager, widgetId, widgetData)
        }
    }
}





  //internal fun updateAppWidget(
 //   context: Context,
  //  appWidgetManager: AppWidgetManager,
//appWidgetId: Int,
 //   widgetData: SharedPreferences,
//) {
   // val views = RemoteViews(context.packageName, R.layout.example_layout)

   // val pendingIntent =
     //   HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java)
   // views.setOnClickPendingIntent(R.id.widget_container, pendingIntent)

   // val prayerList = getPrayerList()
//setPrayerListHorizontalShape(prayerList, views, context)
   //     views.setViewVisibility(R.id.prayer_container, View.VISIBLE)
  //  val title = widgetData.getString("title", "No Title Set") ?: "No Title Set"
   // views.setTextViewText(R.id.widget_title, title)
   // val titleClickIntent = HomeWidgetBackgroundIntent.getBroadcast(context, Uri.parse("homeWidgetExample://titleClicked"))
//views.setOnClickPendingIntent(R.id.widget_title, titleClickIntent)
  //  val message = widgetData.getString("message", "No Message Set") ?: "No Message Set"
   // views.setTextViewText(R.id.widget_message, message)
   // val combinedUri = Uri.parse("homeWidgetExample://message?message=$message&title=$title")
   // val pendingIntentWithData = HomeWidgetLaunchIntent.getActivity(
     //   context,
    //    MainActivity::class.java,
    //    combinedUri
 //   );
   // appWidgetManager.updateAppWidget(appWidgetId, views)
  //  views.setOnClickPendingIntent(R.id.widget_message, pendingIntentWithData)
//views.setOnClickPendingIntent(R.id.prayer_container, pendingIntentWithData)
//}

fun getPrayerList(): List<PrayerModel> {
    return listOf(
        PrayerModel(R.drawable.fajar, "Fajr", "05:00"),
        PrayerModel(R.drawable.dhuhricon, "Dhuhr", "12:30"),
        PrayerModel(R.drawable.asaricon, "Asr", "03:45"),
        PrayerModel(R.drawable.magrib, "Maghrib", "05:50"),
        PrayerModel(R.drawable.isha, "Isha", "07:10")
    )
}

fun setPrayerListHorizontalShape(prayerList: List<PrayerModel>, views: RemoteViews, context: Context) {
    views.removeAllViews(R.id.prayer_container)
    prayerList.forEachIndexed() {index, prayer ->
        val prayerView = RemoteViews(context.packageName, R.layout.prayer_item)
        prayerView.setImageViewResource(R.id.widget_image, prayer.prayerIcon)
        prayerView.setTextViewText(R.id.widget_prayerName, prayer.prayerName)
        prayerView.setTextViewText(R.id.widget_prayerTime, prayer.prayerTime)

        if (prayer.prayerName == "Fajr") {
            prayerView.setInt(R.id.item_background, "setBackgroundColor", ContextCompat.getColor(context, R.color.highlight_color))
        } else {
            prayerView.setInt(R.id.item_background, "setBackgroundColor", ContextCompat.getColor(context, R.color.default_color))
        }



        views.addView(R.id.prayer_container, prayerView)
    }
}

