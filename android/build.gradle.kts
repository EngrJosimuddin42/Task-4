// Top-level build file where you can add configuration options common to all sub-projects/modules.

// buildscript{} ব্লকটি KTS এ এইভাবে লেখা হয় না। এর পরিবর্তে plugins{} ব্লক ব্যবহার করা হয়
// তবে আপনি যদি পুরোনো ভার্সনে থাকেন, তাহলে buildscript ব্লকটিকে ঠিক এভাবে লিখতে হবে:

buildscript {
    // KTS সিনট্যাক্স ফিক্স: Groovy এর 'ext.' সিনট্যাক্স পরিবর্তন করে KTS-compatible 'val' ব্যবহার করা হলো।
    // val kotlin_version = "1.8.0" // এই লাইনটি buildscript ব্লকের ভেতরে প্রয়োজন নেই

    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        // Groovy এর 'classpath '...' এর বদলে KTS এর classpath(...) ফাংশন ব্যবহার করা হলো।
        classpath("com.android.tools.build:gradle:8.1.0") // <-- AGP আপডেট
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.22") // <-- KGP আপডেট
    }
}

// বিল্ডস্ক্রিপ্ট ব্লকের বাইরে থাকা kotlin_version কে ext ব্লকে এইভাবে রাখা হয়:
// android/build.gradle.kts
val kotlin_version by extra { "1.9.22" } // 1.8.10 এর চেয়ে বেশি (যেমন 1.9.22) ব্যবহার করুন

// -------------------------------------------------------------------------------------------------

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// -------------------------------------------------------------------------------------------------

// KTS সিনট্যাক্স ফিক্স: Groovy এর পরিবর্তে Kotlin DSL এ 'clean' টাস্ক রেজিস্টার করা হলো।
tasks.register("clean", org.gradle.api.tasks.Delete::class) {
    delete(rootProject.buildDir)
}