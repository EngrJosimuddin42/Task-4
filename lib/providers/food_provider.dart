import 'dart:io';
import 'package:flutter/material.dart';
import '../data/datasources/tflite_service.dart';
import '../domain/usecases/classify_food.dart';
import '../data/models/prediction_model.dart';

class FoodProvider extends ChangeNotifier {
  File? _image;
  PredictionModel? _prediction;
  bool _loading = false;

  File? get image => _image;
  PredictionModel? get prediction => _prediction;
  bool get loading => _loading;

  final TFLiteService _tfliteService = TFLiteService();
  late ClassifyFood _classifyFood;

  FoodProvider() {
    _classifyFood = ClassifyFood(_tfliteService);
    _tfliteService.loadModel();
  }

  Future<void> setImage(File img) async {
    _image = img;
    _loading = true;
    _prediction = null;
    notifyListeners();

    final result = await _classifyFood.execute(img);
    _prediction = result;
    _loading = false;
    notifyListeners();
  }
}
