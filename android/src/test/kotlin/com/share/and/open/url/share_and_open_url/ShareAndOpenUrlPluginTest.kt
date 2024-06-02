package com.share.and.open.url.share_and_open_url

import com.share.and.open.url.share_and_open_url.constants.ShareAndOpenUrlConstants
import com.share.and.open.url.share_and_open_url.service.ShareAndOpenUrlPluginService
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlin.test.BeforeTest
import kotlin.test.Test
import org.mockito.Mockito.mock
import org.mockito.Mockito.verify

internal class ShareAndOpenUrlPluginTest {

  private lateinit var plugin: ShareAndOpenUrlPlugin
  private lateinit var mockContext: android.content.Context
  private lateinit var mockService: ShareAndOpenUrlPluginService
  private lateinit var mockResult: MethodChannel.Result

  @BeforeTest
  fun setUp() {
    plugin = ShareAndOpenUrlPlugin()
    mockContext = mock(android.content.Context::class.java)
    mockService = mock(ShareAndOpenUrlPluginService::class.java)
    mockResult = mock(MethodChannel.Result::class.java)
    plugin.shareAndOpenUrlPluginService = mockService
  }

  @Test
  fun onMethodCall_shareText_validText() {
    val text = "Test text"
    val call = MethodCall(ShareAndOpenUrlConstants.METHOD_SHARE_TEXT, mapOf("text" to text))

    plugin.onMethodCall(call, mockResult)

    verify(mockService).shareText(text)
    verify(mockResult).success(null)
  }

  @Test
  fun onMethodCall_shareText_missingText() {
    val call = MethodCall(ShareAndOpenUrlConstants.METHOD_SHARE_TEXT, mapOf("text" to null))

    plugin.onMethodCall(call, mockResult)

    verify(mockResult)
        .error(
            ShareAndOpenUrlConstants.ERROR_INVALID_ARGUMENT,
            "Text argument is missing or invalid",
            null
        )
  }

  @Test
  fun onMethodCall_openUrl_validUrl() {
    val url = "http://example.com"
    val call = MethodCall(ShareAndOpenUrlConstants.METHOD_OPEN_URL, mapOf("url" to url))

    plugin.onMethodCall(call, mockResult)

    verify(mockService).openUrl(url)
    verify(mockResult).success(null)
  }

  @Test
  fun onMethodCall_openUrl_missingUrl() {
    val call = MethodCall(ShareAndOpenUrlConstants.METHOD_OPEN_URL, mapOf("url" to null))

    plugin.onMethodCall(call, mockResult)

    verify(mockResult)
        .error(
            ShareAndOpenUrlConstants.ERROR_INVALID_ARGUMENT,
            "URL argument is missing or invalid",
            null
        )
  }

  @Test
  fun onMethodCall_notImplemented() {
    val call = MethodCall("unknownMethod", null)

    plugin.onMethodCall(call, mockResult)

    verify(mockResult).notImplemented()
  }
}
