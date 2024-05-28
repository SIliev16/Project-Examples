package com.example.myapplication

import com.squareup.moshi.Json
import com.squareup.moshi.JsonClass

@JsonClass(generateAdapter = true)
data class WeatherModel(
    val main: Main,
    val weather: List<Weather>
)

@JsonClass(generateAdapter = true)
data class Main(
    val temp: Double
)

@JsonClass(generateAdapter = true)
data class Weather(
    val description: String
)
