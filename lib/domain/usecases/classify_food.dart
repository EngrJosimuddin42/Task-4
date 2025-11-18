import 'dart:io';
import '../../data/datasources/tflite_service.dart';
import '../../data/models/prediction_model.dart';

class ClassifyFood {
  final TFLiteService _service;

  ClassifyFood(this._service);

  Future<PredictionModel?> execute(File image) async {
    final result = await _service.classifyImage(image);
    if (result != null) {
      return PredictionModel(
        label: result['label'],
        confidence: result['confidence'],
      );
    }
    return null;
  }
}
