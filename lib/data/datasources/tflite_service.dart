import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show rootBundle;

class TFLiteService {
  late Interpreter _interpreter;
  late List<String> _labels;
  bool _isLoaded = false;

  Future<void> loadModel() async {
    if (_isLoaded) return;

    _interpreter = await Interpreter.fromAsset('food_101_model.tflite');

    final labelsData = await rootBundle.loadString('assets/food_101_labels.txt');
    _labels = labelsData.split('\n').where((e) => e.trim().isNotEmpty).toList();

    _isLoaded = true;
  }

  Future<Map<String, dynamic>?> classifyImage(File imageFile) async {
    await loadModel();

    final rawBytes = await imageFile.readAsBytes();
    final decoded = img.decodeImage(rawBytes);
    if (decoded == null) return null;

    final resized = img.copyResize(decoded, width: 224, height: 224);

    // Input shape: [1, 224, 224, 3]
    final input = List.generate(
      1,
          (_) => List.generate(
        224,
            (_) => List.generate(
          224,
              (_) => List<double>.filled(3, 0.0),
        ),
      ),
    );

    for (int y = 0; y < 224; y++) {
      for (int x = 0; x < 224; x++) {
        final pixel = resized.getPixel(x, y); // Pixel object

        final r = pixel.r;
        final g = pixel.g;
        final b = pixel.b;

        input[0][y][x][0] = r / 255.0;
        input[0][y][x][1] = g / 255.0;
        input[0][y][x][2] = b / 255.0;
      }
    }

    final output = List.filled(_labels.length, 0.0).reshape([1, _labels.length]);

    _interpreter.run(input, output);

    double maxProb = -1;
    int maxIndex = 0;

    for (int i = 0; i < _labels.length; i++) {
      if (output[0][i] > maxProb) {
        maxProb = output[0][i];
        maxIndex = i;
      }
    }

    return {
      'label': _labels[maxIndex],
      'confidence': maxProb,
    };
  }

  Future<void> disposeModel() async {
    _interpreter.close();
    _isLoaded = false;
  }
}
