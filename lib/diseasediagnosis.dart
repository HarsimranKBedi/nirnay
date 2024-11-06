import 'package:flutter/material.dart';
import 'package:nirnay/services.dart';
class DiseaseSearchScreen extends StatefulWidget {
  @override
  _DiseaseSearchScreenState createState() => _DiseaseSearchScreenState();
}

class _DiseaseSearchScreenState extends State<DiseaseSearchScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> diseases = [];
  String? searchTerm;
  String? searchType = 'crop';

  void _searchDiseases() async {
    try {
      final results = await apiService.searchDiseases(
        crop: searchType == 'crop' ? searchTerm : null,
        symptom: searchType == 'symptom' ? searchTerm : null,
      );
      setState(() {
        diseases = results;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Disease Search')),
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Search Term'),
            onChanged: (value) => searchTerm = value,
          ),
          DropdownButton<String>(
            value: searchType,
            items: [
              DropdownMenuItem(value: 'crop', child: Text('Crop')),
              DropdownMenuItem(value: 'symptom', child: Text('Symptom')),
            ],
            onChanged: (value) => setState(() => searchType = value),
          ),
          ElevatedButton(
            onPressed: _searchDiseases,
            child: Text('Search'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: diseases.length,
              itemBuilder: (context, index) {
                final disease = diseases[index];
                return ListTile(
                  title: Text(disease['disease_name']),
                  subtitle: Text('Affected Crops: ${disease['crop_affected']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
