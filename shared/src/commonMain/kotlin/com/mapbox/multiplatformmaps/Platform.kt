package com.mapbox.multiplatformmaps

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform