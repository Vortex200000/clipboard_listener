package com.example.clippoard_listener_plus

import android.content.ClipboardManager
import android.content.Context
import android.os.Handler
import android.os.Looper
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import androidx.annotation.NonNull
import androidx.annotation.Keep
import java.util.*

@Keep
class ClippoardListenerPlusPlugin : FlutterPlugin, EventChannel.StreamHandler {
  private lateinit var clipboardManager: ClipboardManager
  private var eventSink: EventChannel.EventSink? = null
  private var clipboardPollingTimer: Timer? = null
  private var lastClipboardText: String? = null

  override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    val channel = EventChannel(binding.binaryMessenger, "clipboard_listener/events")
    channel.setStreamHandler(this)

    clipboardManager = binding.applicationContext.getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    stopClipboardPolling()
  }

  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    eventSink = events
    startClipboardPolling()
  }

  override fun onCancel(arguments: Any?) {
    stopClipboardPolling()
  }

  private fun startClipboardPolling() {
    clipboardPollingTimer = Timer()
    clipboardPollingTimer?.scheduleAtFixedRate(object : TimerTask() {
      override fun run() {
        val clip = clipboardManager.primaryClip
        val item = clip?.getItemAt(0)?.text?.toString()

        if (item != null && item != lastClipboardText) {
          lastClipboardText = item
          Handler(Looper.getMainLooper()).post {
            eventSink?.success(item)
          }
        }
      }
    }, 0, 1000)
  }

  private fun stopClipboardPolling() {
    clipboardPollingTimer?.cancel()
    clipboardPollingTimer = null
    lastClipboardText = null
    eventSink = null
  }
}
