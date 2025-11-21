# Task 4: Food Classification Using Camera and TFLite

A Flutter mobile app for real-time food classification using the device camera and a TFLite model.

## Objective

This project assesses your ability to integrate a TFLite model, use the camera, and provide real-time predictions in a clean and user-friendly Flutter app.

## Features

- Capture food images using the device camera or select from gallery.
- Run inference using the provided `food-101.tflite` model.
- Display the top-1 predicted class with confidence score.
- Clean architecture: separation of layers (data, domain, presentation).
- Error handling and offline-first logic (retry when back online).

## Getting Started

### Prerequisites

- Flutter SDK >= 3.10
- A device or emulator with camera support

###  run command
flutter run --use-application-binary "android/app/build/outputs/apk/debug/app-debug.apk"