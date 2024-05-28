package com.example.myapplication

import okhttp3.OkHttpClient
import okhttp3.Request
import com.squareup.moshi.Moshi
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import android.util.Log

object WeatherApiClient {
    private val client = OkHttpClient()
    private val moshi = Moshi.Builder().build()

    suspend fun fetchWeatherData(city: String, apiKey: String): WeatherModel? {
        val url = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey"
        val request = Request.Builder().url(url).build()

        return withContext(Dispatchers.IO) {
            try {
                val response = client.newCall(request).execute()
                if (response.isSuccessful) {
                    val responseBody = response.body?.string()
                    Log.d("WeatherApi", "Response: $responseBody") // Log the response
                    val jsonAdapter = moshi.adapter(WeatherModel::class.java)
                    jsonAdapter.fromJson(responseBody)
                } else {
                    Log.e("WeatherApi", "Response not successful: ${response.code}") // Log the error code
                    null
                }
            } catch (e: Exception) {
                Log.e("WeatherApi", "Error fetching weather data", e) // Log the exception
                null
            }
        }
    }
}
