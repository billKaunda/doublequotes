package com.marad.doublequotes

import android.app.WallpaperManager
import android.graphics.Bitmap
import android.graphics.drawable.BitmapDrawable
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream

class MainActivity: FlutterActivity() {
    // Update the company name in the channel as required
    private val CHANNEL = "com.marad.wallpaper/wallpaper"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Ensure binaryMessenger is non-null
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getWallpaper") {
                val wallpaperBytes = getWallpaperBytes()
                if (wallpaperBytes != null) {
                    result.success(wallpaperBytes)
                } else {
                    result.error("UNAVAILABLE", "Wallpaper not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getWallpaperBytes(): ByteArray? {
        val wallpaperManager = WallpaperManager.getInstance(this)
        val wallpaperDrawable = wallpaperManager.drawable
        if (wallpaperDrawable is BitmapDrawable) {
            val bitmap = wallpaperDrawable.bitmap
            val stream = ByteArrayOutputStream()
            bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream)
            return stream.toByteArray()
        }
        return null
    }
}
