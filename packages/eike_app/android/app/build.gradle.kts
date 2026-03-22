import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")

if (keystorePropertiesFile.exists()) {
  keystorePropertiesFile.inputStream().use { input ->
    keystoreProperties.load(input)
  }
}

// CI builds release without custom signing unless key.properties is present.
fun prop(name: String): String? = keystoreProperties.getProperty(name)
val hasSigning = listOf("keyAlias", "keyPassword", "storeFile", "storePassword").all { prop(it) != null }

android {
    namespace = "de.dfpsnv.eike"
    compileSdk = flutter.compileSdkVersion
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
        // minSdk = flutter.minSdkVersion
        // targetSdk = flutter.targetSdkVersion
        minSdk = 24
        targetSdk = 36
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
                signingConfigs.getByName("debug")
            }
        }
    }
}

flutter {
    source = "../.."
}
