package com.example.myapplication

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.TextView
import java.text.SimpleDateFormat
import java.util.Locale
import java.util.Date
import kotlinx.coroutines.*
import com.squareup.moshi.Moshi

class MainActivity : AppCompatActivity() {

    // Define Views
    private lateinit var tvTitle: TextView
    private lateinit var tvTime: TextView
    private lateinit var tvWelcomeBack: TextView
    private lateinit var tvWeatherInfo: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Initialize Views
        tvTitle = findViewById(R.id.tvTitle)
        tvTime = findViewById(R.id.tvTime)
        tvWelcomeBack = findViewById(R.id.tvWelcomeBack)
        tvWeatherInfo = findViewById(R.id.tvWeatherInfo)

        // Update Time
        updateTime()

        // Fetch and display weather data
        fetchWeatherData()
    }

    private fun updateTime() {
        val currentTime = SimpleDateFormat("HH:mm", Locale.getDefault()).format(Date())
        tvTime.text = currentTime
    }

    private fun fetchWeatherData() {
        CoroutineScope(Dispatchers.Main).launch {
            val weatherData =
                WeatherApiClient.fetchWeatherData("London", "ec39c53ccb2a001034b8021c889bfefc")
            if (weatherData != null) {
                val temperature = weatherData.main.temp - 273.15 // Convert to Celsius
                val description = weatherData.weather.firstOrNull()?.description.orEmpty()

                runOnUiThread {
                    tvWeatherInfo.text =
                        "Temperature: ${"%.1f".format(temperature)}°C, Condition: $description"
                }
            } else {
                runOnUiThread {
                    // Handle error (e.g., show a Toast or a message in the UI)
                }
            }
        }
    }
}