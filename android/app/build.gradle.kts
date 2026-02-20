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

// CI builds release without custom signing unless key.properties is present.
fun prop(name: String): String? = keystoreProperties.getProperty(name)
val hasSigning = listOf("keyAlias", "keyPassword", "storeFile", "storePassword").all { prop(it) != null }

android {
    namespace = "de.dfpsnv.eike"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "de.dfpsnv.eike"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 24
        targetSdk = 36
        // Increase with every new Android store release
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (hasSigning) {
            create("release") {
                keyAlias = prop("keyAlias")!!
                keyPassword = prop("keyPassword")!!
                storeFile = file(prop("storeFile")!!)
                storePassword = prop("storePassword")!!
            }
        }
    }

    buildTypes {
        release {
           signingConfig = if (hasSigning) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug") // macht die Release-APK installierbar
            }
        }
    }
}

flutter {
    source = "../.."
}
