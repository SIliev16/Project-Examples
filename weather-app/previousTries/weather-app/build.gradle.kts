// Top-level build file where you can add configuration options common to all sub-projects/modules.
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:7.0.4") // Your version might be different
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.5.31") // Your Kotlin version
        classpath("com.google.devtools.ksp:com.google.devtools.ksp.gradle.plugin:1.6.10-1.0.4") // KSP version
        // Note: Do not apply kapt here, just ensure its classpath is included
    }
}

plugins {
    kotlin("jvm") version "1.5.31" // Apply Kotlin plugin at the project level
    // ... other plugins if necessary ...
}

tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}