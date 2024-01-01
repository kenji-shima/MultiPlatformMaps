package com.mapbox.multiplatformmaps

actual object Logger {
    actual fun debug(tag: String, message: String) {
        println("DEBUG: [$tag] $message")
    }

    actual fun error(tag: String, message: String) {
        println("ERROR: [$tag] $message")
    }
}