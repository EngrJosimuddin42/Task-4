import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/food_provider.dart';
import '../widgets/prediction_result_widget.dart';
import '../../data/datasources/image_picker_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FoodProvider>(context);
    final ImagePickerService _imagePicker = ImagePickerService();

    Future<void> pickImage(bool fromCamera) async {
      final img = fromCamera
          ? await _imagePicker.pickImageFromCamera()
          : await _imagePicker.pickImageFromGallery();
      if (img != null) provider.setImage(img);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Food Classifier')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              provider.image != null
                  ? Image.file(provider.image!, height: 250)
                  : Container(
                height: 250,
                color: Colors.grey[300],
                child: const Center(child: Text('No image selected')),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                      onPressed: () => pickImage(true),
                      icon: const Icon(Icons.camera),
                      label: const Text('Camera')),
                  ElevatedButton.icon(
                      onPressed: () => pickImage(false),
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Gallery')),
                ],
              ),
              const SizedBox(height: 20),
              provider.loading
                  ? const CircularProgressIndicator()
                  : provider.prediction != null
                  ? PredictionResultWidget(prediction: provider.prediction!)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
