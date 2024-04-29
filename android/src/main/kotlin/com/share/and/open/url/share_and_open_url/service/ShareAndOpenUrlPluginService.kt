package com.share.and.open.url.share_and_open_url.service

import android.content.Context
import android.content.Intent
import android.net.Uri

class ShareAndOpenUrlPluginService(private val context: Context) : IShareAndOpenUrlPlugin() {
    override fun shareText(text: String) {
        val intent: Intent =
            Intent(Intent.ACTION_SEND).apply {
                type = "text/plain"
                putExtra(Intent.EXTRA_TEXT, text)
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
            }
        val chooser: Intent =
            Intent.createChooser(intent, null).apply { addFlags(Intent.FLAG_ACTIVITY_NEW_TASK) }
        context.startActivity(chooser)
    }

    override fun openUrl(url: String) {
        val intent: Intent =
            Intent(Intent.ACTION_VIEW, Uri.parse(url)).apply { flags = Intent.FLAG_ACTIVITY_NEW_TASK }
        context.startActivity(intent)
    }
}