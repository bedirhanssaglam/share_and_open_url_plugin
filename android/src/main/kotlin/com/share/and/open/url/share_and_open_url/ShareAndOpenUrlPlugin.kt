package com.share.and.open.url.share_and_open_url

import androidx.annotation.NonNull
import com.share.and.open.url.share_and_open_url.constants.ShareAndOpenUrlConstants
import com.share.and.open.url.share_and_open_url.service.ShareAndOpenUrlPluginService

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class ShareAndOpenUrlPlugin : FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding
  private lateinit var shareAndOpenUrlPluginService: ShareAndOpenUrlPluginService

  override fun onAttachedToEngine(
      @NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding
  ) {
    this.flutterPluginBinding = flutterPluginBinding
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, ShareAndOpenUrlConstants.METHOD_CHANNEL_NAME)
    channel.setMethodCallHandler(this)
    val context = flutterPluginBinding.applicationContext
    shareAndOpenUrlPluginService = ShareAndOpenUrlPluginService(context)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      ShareAndOpenUrlConstants.METHOD_SHARE_TEXT -> {
        val text = call.argument<String>("text")
        if (text.isNullOrEmpty()) {
          result.error(
              ShareAndOpenUrlConstants.ERROR_INVALID_ARGUMENT,
              "Text argument is missing or invalid",
              null
          )
          return
        }
        shareAndOpenUrlPluginService.shareText(text!!)
        result.success(null)
      }
      ShareAndOpenUrlConstants.METHOD_OPEN_URL -> {
        val url = call.argument<String>("url")
        if (url.isNullOrEmpty()) {
          result.error(
              ShareAndOpenUrlConstants.ERROR_INVALID_ARGUMENT,
              "URL argument is missing or invalid",
              null
          )
          return
        }
        shareAndOpenUrlPluginService.openUrl(url!!)
        result.success(null)
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
