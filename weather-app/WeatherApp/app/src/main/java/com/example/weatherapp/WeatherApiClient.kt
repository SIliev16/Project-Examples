package com.example.weatherapp

import okhttp3.OkHttpClient
import okhttp3.Request
import org.json.JSONObject

object WeatherApiClient {
    private val client = OkHttpClient()

    fun fetchWeatherData(city: String, apiKey: String): String? {
        val request = Request.Builder()
            .url("https://api.api-ninjas.com/v1/weather?city=$city")
            .addHeader("X-Api-Key", apiKey)
            .build()

        client.newCall(request).execute().use { response ->
            if (!response.isSuccessful) return null

            val jsonData = JSONObject(response.body?.string())

            val temperature = jsonData.optString("temp", "N/A")
            val weatherCondition =
                jsonData.optString("cloud_pct", "N/A") // For example, cloud percentage
            // Add other fields as needed

            return "Temperature: $temperature°C, Cloudiness: $weatherCondition%"
        }
    }
}