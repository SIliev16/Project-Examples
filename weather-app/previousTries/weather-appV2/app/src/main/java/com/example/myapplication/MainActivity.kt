package com.example.myapplication

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.TextView
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import android.util.Log
import android.widget.Toast

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
            try {
                val weatherData =
                    WeatherApiClient.fetchWeatherData("Varna","ec39c53ccb2a001034b8021c889bfefc")
                if (weatherData != null) {
                    val temperature = weatherData.main.temp - 273.15 // Convert to Celsius
                    val description = weatherData.weather.firstOrNull()?.description.orEmpty()

                    updateWeatherInfo("Temperature: ${"%.1f".format(temperature)}°C, Condition: $description")
                } else {
                    handleWeatherError()
                }
            } catch (e: Exception) {
                handleWeatherError()
            }
        }
    }

    private fun updateWeatherInfo(weatherInfo: String) {
        runOnUiThread {
            tvWeatherInfo.text = weatherInfo
        }
    }

    private fun handleWeatherError() {
        runOnUiThread {
            // Handle the error here, e.g., show a Toast with an error message
            Toast.makeText(this, "Failed to fetch weather data", Toast.LENGTH_SHORT).show()
        }
    }
}
