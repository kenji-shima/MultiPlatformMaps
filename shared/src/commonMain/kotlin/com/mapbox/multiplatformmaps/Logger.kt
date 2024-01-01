package com.mapbox.multiplatformmaps

expect object Logger {

    fun debug(tag: String, message: String)
    fun error(tag: String, message: String)
}