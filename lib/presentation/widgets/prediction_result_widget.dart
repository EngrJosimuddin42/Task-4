import 'package:flutter/material.dart';
import '../../data/models/prediction_model.dart';

class PredictionResultWidget extends StatelessWidget {
  final PredictionModel prediction;

  const PredictionResultWidget({super.key, required this.prediction});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Prediction: ${prediction.label}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          'Confidence: ${(prediction.confidence * 100).toStringAsFixed(2)}%',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
