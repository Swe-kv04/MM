import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(ImageGalleryApp());
}

class ImageGalleryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImagePickerScreen(),
    );
  }
}

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  Uint8List? _imageBytes;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (kIsWeb) {
        // For Web, use readAsBytes
        final bytes = await image.readAsBytes();
        setState(() {
          _imageBytes = bytes;
        });
      } else {
        // For Mobile, use File
        setState(() {
          _imageBytes = null; // Reset for mobile
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Picker")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageBytes != null
                ? Image.memory(_imageBytes!) // Works for Web
                : Text("No image selected"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImage,
              child: Text("Pick Image"),
            ),
          ],
        ),
      ),
    );
  }
}
