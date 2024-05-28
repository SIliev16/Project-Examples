package com.example.weatherapp

import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import kotlinx.coroutines.*
import okhttp3.OkHttpClient
import okhttp3.Request
import org.json.JSONObject
import java.text.SimpleDateFormat
import java.util.*

class MainActivity : AppCompatActivity() {
    private lateinit var tvTime: TextView
    private lateinit var tvWeatherInfoVarna: TextView
    private lateinit var tvWeatherInfoLondon: TextView
    private lateinit var tvWeatherInfoEindhoven: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        tvTime = findViewById(R.id.tvTime)
        tvWeatherInfoVarna = findViewById(R.id.tvWeatherInfoVarna)
        tvWeatherInfoLondon = findViewById(R.id.tvWeatherInfoLondon)
        tvWeatherInfoEindhoven = findViewById(R.id.tvWeatherInfoEindhoven)

        updateTime()
        fetchWeatherData("Varna", tvWeatherInfoVarna)
        fetchWeatherData("London", tvWeatherInfoLondon)
        fetchWeatherData("Eindhoven", tvWeatherInfoEindhoven)
    }

    private fun updateTime() {
        val currentTime = SimpleDateFormat("HH:mm", Locale.getDefault()).format(Date())
        tvTime.text = currentTime
    }

    private fun fetchWeatherData(city: String, weatherInfoTextView: TextView) {
        CoroutineScope(Dispatchers.IO).launch {
            val weatherData = WeatherApiClient.fetchWeatherData(city, "GZDmF5TVzqA97F8Vjwl+8w==C8dCyU4PW0UHP6ZR")
            withContext(Dispatchers.Main) {
                weatherData?.let { weatherInfoTextView.text = it }
            }
        }
    }

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
                val weatherCondition = jsonData.optString("cloud_pct", "N/A")

                return "Temperature: $temperature°C, Cloudiness: $weatherCondition%"
            }
        }
    }
}
