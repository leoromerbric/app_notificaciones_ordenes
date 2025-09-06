pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        if (file("local.properties").exists()) {
            file("local.properties").inputStream().use { properties.load(it) }
        }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        if (flutterSdkPath != null && file("$flutterSdkPath/packages/flutter_tools/gradle").exists()) {
            flutterSdkPath
        } else {
            // Fallback to environment variable or default path
            System.getenv("FLUTTER_ROOT") ?: "/flutter"
        }
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.5.1" apply false
    id("org.jetbrains.kotlin.android") version "1.9.10" apply false
}

include(":app")
