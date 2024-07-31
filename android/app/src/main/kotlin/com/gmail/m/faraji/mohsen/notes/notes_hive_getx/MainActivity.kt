package com.gmail.m.faraji.mohsen.notes.notes_hive_getx

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.plugins.add(ImageGallerySaverPlugin())
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}
