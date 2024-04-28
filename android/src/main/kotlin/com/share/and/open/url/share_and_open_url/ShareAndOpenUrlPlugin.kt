package com.share.and.open.url.share_and_open_url

import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** ShareAndOpenUrlPlugin */
class ShareAndOpenUrlPlugin : FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding

  override fun onAttachedToEngine(
      @NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding
  ) {
    this.flutterPluginBinding = flutterPluginBinding
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "share_and_open_url")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "shareText" -> {
        val text = call.argument<String>("text")
        if (text != null) {
          shareText(text)
          result.success(null)
        } else {
          result.error("INVALID_ARGUMENT", "Text argument is missing or invalid", null)
        }
      }
      "openUrl" -> {
        val url = call.argument<String>("url")
        if (url != null) {
          openUrl(url)
          result.success(null)
        } else {
          result.error("INVALID_ARGUMENT", "URL argument is missing or invalid", null)
        }
      }
      else -> result.notImplemented()
    }
  }

  private fun shareText(text: String) {
    val intent = Intent(Intent.ACTION_SEND)
    intent.type = "text/plain"
    intent.putExtra(Intent.EXTRA_TEXT, text)
    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
    val chooser = Intent.createChooser(intent, null)
    chooser.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    val context = flutterPluginBinding.applicationContext
    context.startActivity(chooser)
  }

  private fun openUrl(url: String) {
    val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
    val context = flutterPluginBinding.applicationContext
    context.startActivity(intent)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
