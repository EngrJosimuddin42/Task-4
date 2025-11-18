import 'dart:io';
import 'package:tflite/tflite.dart';

class TFLiteService {
  bool _modelLoaded = false;

  Future<void> loadModel() async {
    if (!_modelLoaded) {
      await Tflite.loadModel(
        model: "assets/food_101_model.tflite",
        labels: "assets/food_101_labels.txt",
      );
      _modelLoaded = true;
    }
  }

  Future<Map<String, dynamic>?> classifyImage(File image) async {
    await loadModel();

    final recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 1,
      threshold: 0.1,
    );

    if (recognitions != null && recognitions.isNotEmpty) {
      final result = recognitions.first;
      return {
        'label': result['label'],
        'confidence': (result['confidence'] as double),
      };
    }

    return null;
  }

  Future<void> disposeModel() async {
    await Tflite.close();
    _modelLoaded = false;
  }
}
