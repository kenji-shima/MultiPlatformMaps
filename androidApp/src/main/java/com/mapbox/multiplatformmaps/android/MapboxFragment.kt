package com.mapbox.multiplatformmaps.android

import android.content.Context
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import androidx.annotation.DrawableRes
import androidx.appcompat.content.res.AppCompatResources
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.viewinterop.AndroidView
import com.mapbox.geojson.Point
import com.mapbox.maps.CameraOptions
import com.mapbox.maps.MapView
import com.mapbox.maps.Style
import com.mapbox.maps.extension.localization.localizeLabels
import com.mapbox.maps.extension.style.style
import com.mapbox.maps.plugin.annotation.AnnotationConfig
import com.mapbox.maps.plugin.annotation.AnnotationSourceOptions
import com.mapbox.maps.plugin.annotation.annotations
import com.mapbox.maps.plugin.annotation.generated.PointAnnotationManager
import com.mapbox.maps.plugin.annotation.generated.PointAnnotationOptions
import com.mapbox.maps.plugin.annotation.generated.createPointAnnotationManager
import com.mapbox.maps.plugin.gestures.addOnMapLongClickListener
import com.mapbox.multiplatformmaps.Utils
import java.util.Locale

class MapboxFragment {

    companion object {
        private lateinit var mapView: MapView
        private lateinit var pointAnnotationManager: PointAnnotationManager
        private var marker: Bitmap? = null

        private lateinit var weatherViewModel: WeatherViewModel

        @Composable
        fun CreateMap(weatherViewModel: WeatherViewModel) {
            this.weatherViewModel = weatherViewModel
            val context = LocalContext.current

            this.mapView = remember {
                MapView(context).apply {
                    mapboxMap.loadStyle(
                        styleExtension = style(Style.MAPBOX_STREETS) {},
                        onStyleLoaded = { style ->
                            style.localizeLabels(Locale.JAPANESE)
                            marker = bitmapFromDrawableRes(context, R.drawable.red_marker)
                            pointAnnotationManager =
                                mapView.annotations.createPointAnnotationManager(
                                    AnnotationConfig(
                                        annotationSourceOptions = AnnotationSourceOptions(
                                            maxZoom = 16
                                        )
                                    )
                                )
                            addAnnotationToMap(
                                longitude = Utils.longitude,
                                latitude = Utils.latitude
                            )
                        }
                    )
                    mapboxMap.setCamera(
                        CameraOptions.Builder()
                            .center(Point.fromLngLat(Utils.longitude, Utils.latitude))
                            .zoom(Utils.initZoom)
                            .build()
                    )
                    mapboxMap.addOnMapLongClickListener { point ->
                        handleOnLongClick(point = point)
                        true
                    }
                }
            }

            Column {
                AndroidView(
                    factory = { mapView },
                    modifier = Modifier
                        .fillMaxWidth()
                        .weight(1f),
                    update = {}
                )

                WeatherFragment.ShowForecast(weatherViewModel)
            }
        }

        private fun handleOnLongClick(point: Point) {
            addAnnotationToMap(point.longitude(), point.latitude())
        }

        private fun addAnnotationToMap(longitude: Double, latitude: Double) {
            pointAnnotationManager.deleteAll()
            val pointAnnotationOptions: PointAnnotationOptions = PointAnnotationOptions()
                .withPoint(Point.fromLngLat(longitude, latitude))
                .withIconImage(marker!!)
            pointAnnotationManager.create(pointAnnotationOptions)
            this.weatherViewModel.getForecast(longitude = longitude, latitude = latitude)
        }

        private fun bitmapFromDrawableRes(context: Context, @DrawableRes resourceId: Int) =
            convertDrawableToBitmap(AppCompatResources.getDrawable(context, resourceId))

        private fun convertDrawableToBitmap(sourceDrawable: Drawable?): Bitmap? {
            if (sourceDrawable == null) {
                return null
            }
            return if (sourceDrawable is BitmapDrawable) {
                sourceDrawable.bitmap
            } else {
                val constantState = sourceDrawable.constantState ?: return null
                val drawable = constantState.newDrawable().mutate()
                val bitmap: Bitmap = Bitmap.createBitmap(
                    drawable.intrinsicWidth, drawable.intrinsicHeight,
                    Bitmap.Config.ARGB_8888
                )
                val canvas = Canvas(bitmap)
                drawable.setBounds(0, 0, canvas.width, canvas.height)
                drawable.draw(canvas)
                bitmap
            }
        }
    }
}