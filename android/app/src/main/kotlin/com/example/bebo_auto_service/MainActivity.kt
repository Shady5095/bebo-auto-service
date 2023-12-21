package com.example.bebo_auto_service

import android.app.NotificationManager
import android.content.Context
import io.flutter.embedding.android.FlutterActivity


class MainActivity: FlutterActivity() {

    override fun onResume() {
        super.onResume()
        closeAllNotifications();
    }

    private fun closeAllNotifications() {
        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        notificationManager.cancelAll()
    }

}
