package com.mapbox.multiplatformmaps

import io.ktor.client.HttpClient
import io.ktor.client.request.get
import io.ktor.client.statement.bodyAsText
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.serialization.InternalSerializationApi
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import kotlinx.serialization.serializer

abstract class NetworkService {

    companion object {
        val httpClient = HttpClient()
    }

    @OptIn(InternalSerializationApi::class)
    suspend inline fun <reified T : Any> asyncGetAbstract(url: String): T {
        val response = httpClient.get(url)
        val json = Json { ignoreUnknownKeys = true }
        return json.decodeFromString(T::class.serializer(), response.bodyAsText())
    }

    inline fun <reified T : Any> asyncGetWithHandlerAbstract(
        url: String,
        crossinline completionHandler: (T?, Exception?) -> Unit
    ) {
        CoroutineScope(Dispatchers.Main).launch {
            try {
                val result = asyncGetAbstract<T>(url)
                completionHandler(result, null)
            } catch (e: Exception) {
                completionHandler(null, e)
            }
        }
    }
}

object WeatherForecast : NetworkService() {

    const val baseUrl: String =
        "https://api.open-meteo.com/v1/forecast?daily=temperature_2m_max,temperature_2m_min,precipitation_probability_mean,precipitation_probability_min,precipitation_probability_max,wind_speed_10m_max,sunrise,sunset"

    suspend fun asyncGet(lat: Double, lng: Double): Forecast {
        return asyncGetAbstract("$baseUrl&latitude=$lat&longitude=$lng")
    }

    fun asyncGetWithHandler(
        lat: Double,
        lng: Double,
        completionHandler: (Forecast?, Exception?) -> Unit
    ) {
        return asyncGetWithHandlerAbstract(
            "$baseUrl&latitude=$lat&longitude=$lng",
            completionHandler
        )
    }

    fun asyncGetFormattedWithHandler(
        lat: Double,
        lng: Double,
        accessToken: String,
        completionHandler: (ForecastFormatted?, Exception?) -> Unit
    ) {
        var exceptionOccurred: Exception?

        asyncGetWithHandler(lat, lng) { weather, weatherEx ->
            if (weatherEx != null) {
                exceptionOccurred = weatherEx
                completionHandler(null, exceptionOccurred)
                return@asyncGetWithHandler
            }

            Geocoding.asyncGetWithHandler(lat, lng, accessToken) { geocode, geocodeEx ->
                if (geocodeEx != null) {
                    exceptionOccurred = geocodeEx
                    completionHandler(null, exceptionOccurred)
                    return@asyncGetWithHandler
                }

                if (weather != null && geocode != null) {
                    val forecastFormatted = ForecastFormatted(
                        forecast = weather,
                        geocode = geocode
                    )
                    completionHandler(forecastFormatted, null)
                } else {
                    completionHandler(null, RuntimeException("Failed to retrieve data"))
                }
            }
        }
    }

}

data class ForecastFormatted(
    val forecast: Forecast,
    val geocode: Geocode
) {
    lateinit var dateList: List<String>
    lateinit var temperatureList: List<String>
    lateinit var precipitationList: List<String>
    lateinit var place: String

    init {
        formatDates()
        formatTemperatures()
        formatPrecipitations()
        formatPlace()
    }

    private fun formatDates() {
        dateList = forecast.daily.time.map { time ->
            Utils.formatDateString(time)
        }
    }

    private fun formatTemperatures() {
        val mutableList = mutableListOf<String>()
        forecast.daily.temperature_2m_min.forEachIndexed { index, min ->
            mutableList.add("$min~${forecast.daily.temperature_2m_max[index]}")
        }
        temperatureList = mutableList.toList()
    }

    private fun formatPrecipitations() {
        precipitationList = forecast.daily.precipitation_probability_mean.map { mean ->
            "${mean.toInt()} ${forecast.daily_units.precipitation_probability_mean}"
        }
    }

    private fun formatPlace() {
        if (geocode.features.isNotEmpty()) {
            place = geocode.features[0].properties.place_name
        }
    }

}

@Serializable
data class Forecast(
    val latitude: Double,
    val longitude: Double,
    val generationtime_ms: Double,
    val utc_offset_seconds: Int,
    val timezone: String,
    val timezone_abbreviation: String,
    val elevation: Double,
    val daily_units: DailyUnits,
    val daily: Daily
)

@Serializable
data class DailyUnits(
    val time: String,
    val temperature_2m_max: String,
    val temperature_2m_min: String,
    val precipitation_probability_min: String,
    val precipitation_probability_max: String,
    val precipitation_probability_mean: String,
    val wind_speed_10m_max: String,
    val sunrise: String,
    val sunset: String
)

@Serializable
data class Daily(
    val time: List<String>,
    val temperature_2m_max: List<Double>,
    val temperature_2m_min: List<Double>,
    val precipitation_probability_min: List<Double>,
    val precipitation_probability_max: List<Double>,
    val precipitation_probability_mean: List<Double>,
    val wind_speed_10m_max: List<Double>,
    val sunrise: List<String>,
    val sunset: List<String>
)

object Geocoding : NetworkService() {

    const val baseUrl = "https://api.mapbox.com/search/v1/reverse/"

    suspend fun asyncGet(lat: Double, lng: Double, accessToken: String): Geocode {
        return asyncGetAbstract("$baseUrl$lng,$lat?types=city&language=ja&access_token=$accessToken")
    }

    fun asyncGetWithHandler(
        lat: Double,
        lng: Double,
        accessToken: String,
        completionHandler: (Geocode?, Exception?) -> Unit
    ) {
        return asyncGetWithHandlerAbstract(
            "$baseUrl$lng,$lat?types=city&language=ja&access_token=$accessToken",
            completionHandler
        )
    }
}

@Serializable
data class Geocode(
    val features: List<Feature>
)

@Serializable
data class Feature(
    val bbox: List<Double>,
    val geometry: Geometry,
    val properties: Properties
)

@Serializable
data class Geometry(
    val type: String,
    val coordinates: List<Double>
)

@Serializable
data class Properties(
    val feature_name: String,
    val matching_name: String,
    val highlighted_name: String,
    val description: String,
    val place_name: String,
    val id: String,
    val place_type: List<String>
)