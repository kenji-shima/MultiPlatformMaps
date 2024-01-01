package com.mapbox.multiplatformmaps.android

import android.app.Application
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Card
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import com.mapbox.multiplatformmaps.Forecast
import com.mapbox.multiplatformmaps.ForecastFormatted
import com.mapbox.multiplatformmaps.Geocoding
import com.mapbox.multiplatformmaps.Logger
import com.mapbox.multiplatformmaps.Utils
import com.mapbox.multiplatformmaps.WeatherForecast
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class WeatherFragment {

    companion object {

        @Composable
        fun ShowForecast(weatherViewModel: WeatherViewModel) {
            val forecastState by weatherViewModel.state.collectAsState()

            when (forecastState) {
                is WeatherForecastState.Idle -> {
                    //do nothing
                }

                is WeatherForecastState.Processing -> {
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .height(100.dp),
                        verticalAlignment = Alignment.CenterVertically,
                        horizontalArrangement = Arrangement.Center
                    ) {
                        CircularProgressIndicator() // Your loading indicator
                    }
                }

                is WeatherForecastState.Complete -> {
                    val forecast = weatherViewModel.forecastFormatted
                    Column(
                    ) {
                        Row(modifier = Modifier.background(Color.Black).fillMaxWidth()) {
                            Text(text = forecast?.place!!,
                                color = Color.White,
                                modifier = Modifier.padding(8.dp))
                        }
                        LazyRow(
                            modifier = Modifier
                                .fillMaxWidth()
                                .height(100.dp)
                                .background(Color.Black),
                            horizontalArrangement = Arrangement.SpaceBetween
                        ) {
                            items(6) { i->
                                Card(
                                    shape = RoundedCornerShape(8.dp),
                                    modifier = Modifier
                                        .padding(2.dp)
                                        .width(120.dp)
                                ) {
                                    Column(
                                        modifier = Modifier
                                            .fillMaxSize()
                                            .background(Color.White),
                                        horizontalAlignment = Alignment.Start,
                                        verticalArrangement = Arrangement.Center
                                    ) {
                                        RowWithIcon(image = R.drawable.calendar, text = forecast?.dateList?.get(i) ?: "")
                                        RowWithIcon(image = R.drawable.temperature_sensor, text = forecast?.temperatureList?.get(i) ?: "")
                                        RowWithIcon(image = R.drawable.drop, text = forecast?.precipitationList?.get(i) ?: "")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        @Composable
        fun RowWithIcon(image: Int, text: String){
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.Start,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Image(
                    painter = painterResource(id = image),
                    contentDescription = text,
                    modifier = Modifier.size(25.dp)
                )
                Spacer(modifier = Modifier.width(8.dp))
                Text(text)
            }
        }
    }
}

class WeatherViewModel(private val application: Application) : AndroidViewModel(application) {

    private val _state = MutableStateFlow<WeatherForecastState>(WeatherForecastState.Idle)
    val state = _state.asStateFlow()

    var forecastFormatted: ForecastFormatted? = null

    fun getForecast(longitude: Double, latitude: Double) {
        forecastFormatted = null
        _state.value = WeatherForecastState.Processing
        viewModelScope.launch {
            val forecast: Forecast = WeatherForecast.asyncGet(lat = latitude, lng = longitude)
            val geocode = Geocoding.asyncGet(
                lat = latitude,
                lng = longitude,
                application.getString(R.string.mapbox_access_token)
            )
            forecastFormatted = ForecastFormatted(forecast,geocode)
            _state.value = WeatherForecastState.Complete
        }
    }
}

sealed class WeatherForecastState {
    object Idle : WeatherForecastState()
    object Processing : WeatherForecastState()
    object Complete : WeatherForecastState()
}