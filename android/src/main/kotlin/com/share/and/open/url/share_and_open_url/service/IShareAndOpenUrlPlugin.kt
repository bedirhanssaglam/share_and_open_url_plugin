package com.share.and.open.url.share_and_open_url.service

abstract class IShareAndOpenUrlPlugin {
   abstract fun shareText(text: String)
   abstract fun openUrl(url: String)
}