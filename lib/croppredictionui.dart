import 'package:flutter/material.dart';
import 'package:nirnay/services.dart';

class CropPredictionScreen extends StatefulWidget {
  @override
  _CropPredictionScreenState createState() => _CropPredictionScreenState();
}

class _CropPredictionScreenState extends State<CropPredictionScreen> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();

 
  Map<String, dynamic> formData = {
    'nitrogen': 0.0,
    'phosphorus': 0.0,
    'potassium': 0.0,
    'temp': 0.0,
    'humidity': 0.0,
    'ph': 0.0,
    'rainfall': 0.0,
  };

  
  String? prediction;

  
  void _predictCrop() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); 
      try {
        final result = await apiService.predictCrop(formData); 
        setState(() {
          prediction = result;  
        });
      } catch (e) {
        print('Error: $e');  
      }
    }
  }

 
  Widget _buildInputField({
    required String label,
    required String key,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      onSaved: (value) {
        formData[key] = double.parse(value!); 
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;  
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crop Prediction')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                
                _buildInputField(label: 'Nitrogen', key: 'nitrogen'),
                _buildInputField(label: 'Phosphorus', key: 'phosphorus'),
                _buildInputField(label: 'Potassium', key: 'potassium'),
                _buildInputField(label: 'Temperature', key: 'temp'),
                _buildInputField(label: 'Humidity', key: 'humidity'),
                _buildInputField(label: 'pH', key: 'ph'),
                _buildInputField(label: 'Rainfall', key: 'rainfall'),

                SizedBox(height: 20),

               
                ElevatedButton(
                  onPressed: _predictCrop,
                  child: Text('Predict Crop'),
                ),

                SizedBox(height: 20),

                
                if (prediction != null)
                  Text(
                    'Predicted Crop: $prediction',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
