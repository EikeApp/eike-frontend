import java.util.Properties

plugins {
    id("com.android.application")
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
    // flutter_secure_storage requires compileSdk 37; flutter.compileSdkVersion
    // currently resolves to 36, so it is overridden explicitly here.
    compileSdk = 37
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "de.dfpsnv.eike"
        // minSdk = flutter.minSdkVersion
        // targetSdk = flutter.targetSdkVersion
        minSdk = 24
        targetSdk = 37
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

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
