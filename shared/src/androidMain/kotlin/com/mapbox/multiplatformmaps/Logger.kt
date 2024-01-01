package com.mapbox.multiplatformmaps

actual object Logger {
    actual fun debug(tag: String, message: String) {
        android.util.Log.d(tag, message)
    }

    actual fun error(tag: String, message: String) {
        android.util.Log.e(tag, message)
    }

}