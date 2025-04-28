plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

import java.io.FileInputStream
import java.util.Properties
import java.io.File 

android {
    namespace = "com.muonroi.tudy"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "29.0.13113456"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.muonroi.tudy"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            val properties = Properties()
            val propertiesFile = File(rootDir, "key.properties")
            if (propertiesFile.exists()) {
                properties.load(FileInputStream(propertiesFile))

                storeFile = File(properties.getProperty("storeFile") as String)
                storePassword = properties.getProperty("storePassword") as String
                keyAlias = properties.getProperty("keyAlias") as String
                keyPassword = properties.getProperty("keyPassword") as String

            } else {
                 val envStorePassword = System.getenv("KEYSTORE_PASSWORD") ?: ""
                 val envKeyAlias = System.getenv("KEY_ALIAS") ?: ""
                 val envKeyPassword = System.getenv("KEY_PASSWORD") ?: ""
                 val envStoreFilePath = System.getenv("STORE_FILE") ?: "" 
                 if (envStorePassword.isEmpty() || envKeyAlias.isEmpty() || envKeyPassword.isEmpty() || envStoreFilePath.isEmpty()) {
                      throw GradleException("""
                      ${propertiesFile.absolutePath} file not found and environment variables are not set. 
                      """.trimIndent())
                 } else {
                      storeFile = File(envStoreFilePath) 
                      storePassword = envStorePassword
                      keyAlias = envKeyAlias
                      keyPassword = envKeyPassword
                 }
            }
        }
    }


    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
        debug {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}