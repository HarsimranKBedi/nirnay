import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000';

  
  Future<String> predictCrop(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/predict-crop'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['prediction'];
    } else {
      throw Exception('Failed to predict crop');
    }
  }

  
  Future<List<dynamic>> getAllDiseases() async {
    final response = await http.get(Uri.parse('$baseUrl/diseases'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load diseases');
    }
  }

  
  Future<dynamic> getDiseaseByName(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/diseases/$name'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Disease not found');
    }
  }

  
  Future<List<dynamic>> searchDiseases({String? crop, String? symptom}) async {
    final uri = Uri.parse('$baseUrl/search')
        .replace(queryParameters: {'crop': crop, 'symptom': symptom});

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('No diseases found');
    }
  }

 
  Future<String> predictLeafDisease(http.MultipartFile file) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/predict-leaf-disease/'),
    );
    request.files.add(file);

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      return jsonDecode(responseData)['prediction'];
    } else {
      throw Exception('Failed to predict leaf disease');
    }
  }
}
