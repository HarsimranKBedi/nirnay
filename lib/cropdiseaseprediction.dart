import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:nirnay/services.dart'; // Adjust with actual path

class LeafDiseasePredictionScreen extends StatefulWidget {
  @override
  _LeafDiseasePredictionScreenState createState() => _LeafDiseasePredictionScreenState();
}

class _LeafDiseasePredictionScreenState extends State<LeafDiseasePredictionScreen> {
  final ApiService apiService = ApiService();
  File? _imageFile;
  String? prediction;
  String errorMessage = '';

 
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        prediction = null; 
        errorMessage = '';  
      });
    } else {
      print('No image selected.');
    }
  }

  // Function to predict the leaf disease
  Future<void> _predictLeafDisease() async {
    if (_imageFile != null) {
      final file = await http.MultipartFile.fromPath('file', _imageFile!.path);
      try {
        final result = await apiService.predictLeafDisease(file);
        if (result != null && result.isNotEmpty) {
          setState(() {
            prediction = result;
          });
        } else {
          setState(() {
            errorMessage = 'Prediction failed or no disease detected.';
          });
        }
      } catch (e) {
        setState(() {
          errorMessage = 'Error: $e';
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please pick an image first!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaf Disease Prediction'),
        backgroundColor: const Color.fromARGB(255, 235, 229, 172),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            
            _imageFile != null
                ? Center(
                    child: Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                          image: FileImage(_imageFile!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      height: 200,
                      width: 300,
                      child: Center(
                        child: Icon(Icons.image, size: 100, color: Colors.grey), // Placeholder
                      ),
                    ),
                  ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: Text('Pick from Gallery'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.camera),
                  child: Text('Pick from Camera'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Spacer(),
            ElevatedButton(
              onPressed: _predictLeafDisease,
              child: Text('Predict Disease'),
            ),
            SizedBox(height: 20),
            if (prediction != null)
              Text(
                'Predicted Disease: $prediction',
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
