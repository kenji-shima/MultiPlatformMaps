package com.mapbox.multiplatformmaps

object Utils {

    const val longitude = 139.62722
    const val latitude = 35.45305
    const val initZoom = 4.0

    fun formatDateString(inputDateString: String?): String {
        if (inputDateString!!.length == 10) {
            val month = inputDateString.substring(5, 7).trimStart('0')
            val day = inputDateString.substring(8, 10).trimStart('0')
            return "$month/$day"
        } else {
            return "Invalid date"
        }
    }

}