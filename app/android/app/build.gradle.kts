import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "dev.linwood.butterfly"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    // Flutter-friendly toggles:
    // - Env: USE_LEGACY_PACKAGING=true
    val useLegacy = (System.getenv("USE_LEGACY_PACKAGING") ?: "false").toBoolean()

    packaging {
        jniLibs {
            useLegacyPackaging = useLegacy
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    flavorDimensions += "default"
    productFlavors {
        create("production") {
            dimension = "default"
            applicationIdSuffix = ""
            manifestPlaceholders["appName"] = "Butterfly"
        }
        create("development") {
            dimension = "default"
            applicationIdSuffix = ""
            manifestPlaceholders["appName"] = "Butterfly Nightly"
        }
        create("nightly") {
            dimension = "default"
            applicationIdSuffix = ".nightly"
            manifestPlaceholders["appName"] = "Butterfly Nightly"
        }
    }

    defaultConfig {
        applicationId = "dev.linwood.butterfly"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 24
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String?
        }
    }

    buildTypes {
        release {
            // Use your release keystore if available, fall back to debug key
            signingConfig = if (keystorePropertiesFile.exists()) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }
    dependenciesInfo {
        // Disables dependency metadata when building APKs.
        includeInApk = false
        // Disables dependency metadata when building Android App Bundles.
        includeInBundle = false
    }
}

kotlin {
    compilerOptions {
        jvmTarget = JvmTarget.fromTarget("11")
    }
}

flutter {
    source = "../.."
}
