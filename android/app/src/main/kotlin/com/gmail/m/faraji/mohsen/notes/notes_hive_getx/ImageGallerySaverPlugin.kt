package com.gmail.m.faraji.mohsen.notes.notes_hive_getx

import android.content.ContentValues
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Environment
import android.provider.MediaStore
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import java.io.File
import java.io.FileOutputStream
import java.io.IOException

class ImageGallerySaverPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "image_gallery_saver")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "saveImageToGallery" -> {
                val imageBytes = call.argument<ByteArray>("imageBytes")
                val bitmap = BitmapFactory.decodeByteArray(imageBytes, 0, imageBytes!!.size)
                val savedImagePath = saveImage(bitmap)
                result.success(savedImagePath)
            }
            else -> result.notImplemented()
        }
    }

    private fun saveImage(bitmap: Bitmap): String {
        val imageFileName = "Note_" + System.currentTimeMillis() + ".jpg"
        val storageDir = File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES).toString() + "/MyApp")
        var success = true
        if (!storageDir.exists()) {
            success = storageDir.mkdirs()
        }
        return if (success) {
            val imageFile = File(storageDir, imageFileName)
            try {
                val fOut = FileOutputStream(imageFile)
                bitmap.compress(Bitmap.CompressFormat.JPEG, 100, fOut)
                fOut.flush()
                fOut.close()
                val values = ContentValues()
                values.put(MediaStore.Images.Media.DATA, imageFile.absolutePath)
                context.contentResolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values)
                imageFile.absolutePath
            } catch (e: IOException) {
                e.printStackTrace()
                ""
            }
        } else {
            ""
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
