import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nirnay/cropdiseaseprediction.dart';
import 'package:nirnay/croppredictionui.dart';
import 'package:nirnay/diseasediagnosis.dart';

class Designcards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 25.w, left: 25.w),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listTiles.length,
        itemBuilder: (context, index) {
          final element = listTiles[index];
          return Column(
            children: [
              Container(
                height: 57.h,
                child: Card(
                  child: ListTile(
                    title: Text(element.title),
                    trailing: IconButton(
                      onPressed: () {
                       
                        navigateToPage(context, element.title);
                      },
                      icon: Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }

 
  void navigateToPage(BuildContext context, String title) {
    if (title == 'Predict Best Crop Cultivation!') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CropPredictionScreen()),
      );
    } else if (title == 'Disease Diagnosis') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DiseaseSearchScreen()),
      );
    } else if (title == 'Predict Crop Disease!') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LeafDiseasePredictionScreen()),
      );
    }
  }
}

// Define your pages here
// class PredictCropPricePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Predict Best Crop Cultivation!')),
//       body: Center(child: Text('Crop Price Prediction Page')),
//     );
//   }
// }

// class PredictTemperaturePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Predict Temperature')),
//       body: Center(child: Text('Temperature Prediction Page')),
//     );
//   }
// }



class Listtiles {
  final String title;

  Listtiles({required this.title});
}

List<Listtiles> listTiles = [
  Listtiles(title: 'Predict Best Crop Cultivation!'),
  Listtiles(title: 'Disease Diagnosis'),
  Listtiles(title: 'Predict Crop Disease!'),
];
