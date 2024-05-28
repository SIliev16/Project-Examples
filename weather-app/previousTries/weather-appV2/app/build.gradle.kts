plugins {
    id("com.android.application")
    kotlin("android")
}

android {
    compileSdkVersion(33) // Use the desired SDK version
    defaultConfig {
        applicationId = "com.example.weatherapp" // Change to your application ID
        minSdkVersion(16) // Change to your minimum supported SDK version
        targetSdkVersion(33) // Use the desired target SDK version
        versionCode = 1 // Change versionCode as needed
        versionName = "1.0" // Change versionName as needed
    }

    buildTypes {
        release {
            minifyEnabled(false) // Change minifyEnabled and proguardFiles if needed for release builds
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}

dependencies {
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.5.2") // Add Kotlin Coroutine dependency
    implementation("androidx.lifecycle:lifecycle-viewmodel-ktx:2.3.1") // Add ViewModel dependency
    implementation("androidx.lifecycle:lifecycle-livedata-ktx:2.3.1") // Add LiveData dependency

    // Add other dependencies as needed
}
