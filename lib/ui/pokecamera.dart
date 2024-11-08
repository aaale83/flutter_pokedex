import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/other/global_variables.dart';
import 'package:flutter_pokedex/widgets/custom_loader_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class PokeCamera extends StatefulWidget {
  const PokeCamera({super.key});

  @override
  State<PokeCamera> createState() => _PokeCameraState();
}

class _PokeCameraState extends State<PokeCamera> {

  CameraController? _cameraController;

  Future<void> _initializeCamera() async {

    // Get the list of available cameras
    final cameras = await availableCameras();

    // Select the first camera (usually the rear camera)
    final firstCamera = cameras.first;

    // Initialize the controller with the selected camera
    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    // Initialize the controller
    await _cameraController!.initialize();

    if (mounted) {
      setState(() {});
    }
  }

  Future _takePhoto() async {

    try {
      final XFile photo = await _cameraController!.takePicture();

      final Directory tempDir = await getTemporaryDirectory();
      final String filePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

      await photo.saveTo(filePath);

      final originalImage = File(filePath).readAsBytesSync();
      img.Image? image = img.decodeImage(originalImage);

      img.Image rotatedImage = img.copyRotate(image!, angle: 0);

      img.Image resizedImage = img.copyResize(rotatedImage, width: 600, height: 800);

      List<int> rotatedImageBytes = img.encodeJpg(resizedImage);

      final File file = File(filePath);
      await file.writeAsBytes(rotatedImageBytes);

      if (mounted) Navigator.of(context).pop(filePath);
    } catch (e) {
      ScaffoldMessenger.of(originalContext!).showSnackBar(
        const SnackBar(content: Text('Error capturing photo')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _cameraController == null ? const CustomLoaderIndicator(color: Colors.white) : CameraPreview(_cameraController!),
          Image.asset("assets/images/camera_overlay.png"),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
            child: ElevatedButton(
              onPressed: ()  async {
                await _takePhoto();
              },
              child: const Text("Take a photo")
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_cameraController != null) {
      _cameraController!.dispose();
    }
  }

}