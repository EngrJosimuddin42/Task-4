// android/app/build.gradle.kts

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.josim.task_4.task_4"
    compileSdk = 36 // নতুন Android ভার্সনের জন্য

    defaultConfig {
        applicationId = "com.josim.task_4.task_4"
        minSdk = 24
        targetSdk = 36
        versionCode = 1
        versionName = "1.0"
        
        // ⭐ ফিক্স: NDK এবং ABI FILTERS ব্লক মুছে ফেলা হলো ⭐
        // কারণ এটি বিল্ডের সময় `.apk` আউটপুট পাথে কনফ্লিক্ট তৈরি করছিল।
        
        // NDK কনফিগারেশন সরিয়ে দেওয়া হলো। (আপনার TFLite প্যাকেজ এখন ডিফল্ট ABI ব্যবহার করবে)
    }

    // ⭐ Fix: APK Spliting ব্লক সম্পূর্ণভাবে মুছে ফেলা হলো ⭐
    // যেহেতু ABI Filters নেই, এই ব্লকটি রাখলে অপ্রয়োজনীয় সমস্যা হতে পারে।
    // splits {
    //     abi {
    //         isEnable = false
    //     }
    // }

    buildTypes {
        getByName("debug") {
            isMinifyEnabled = false
            isShrinkResources = false
        }
        getByName("release") {
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    // ⭐⭐ চূড়ান্ত ফিক্স: kotlinOptions ব্লক সঠিক স্থানে আছে ⭐⭐
    kotlinOptions {
        jvmTarget = "17" 
    }
}

flutter {
    source = "../.."
}