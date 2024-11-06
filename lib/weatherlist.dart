import 'dart:math';
import 'dart:ui'; 
import 'package:intl/intl.dart'; 

class Weatherlist {
  String image;
  String heading;
  String subHeading;
  Color color;
  Weatherlist({
    required this.image,
    required this.heading,
    required this.subHeading,
    required this.color,
  });
}


String getImageForTemperature(int temperature) {
  if (temperature < 10) {
    return 'assets/image2.png'; 
  } else if (temperature < 26) {
    return 'assets/image3.png';
  } else {
    return 'assets/image1.png'; 
  }
}


List<Weatherlist> generateWeatherTiles() {
  Random random = Random();
  List<int> temperatures = List.generate(8, (index) => 25 + index); 
 
  DateTime now = DateTime.now();
  DateTime nextDay1 = now.add(Duration(days: 1));
  DateTime nextDay2 = now.add(Duration(days: 2));
  DateTime nextDay3 = now.add(Duration(days: 3));

  
  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date); 
  }

  return [
    Weatherlist(
      image: getImageForTemperature(temperatures[random.nextInt(temperatures.length)]), 
      heading: formatDate(now), 
      subHeading: 'Vidhani - Min. Temp : ${temperatures[random.nextInt(temperatures.length)]}°C',
      color: const Color.fromARGB(255, 37, 37, 37),
    ),
    Weatherlist(
      image: getImageForTemperature(temperatures[random.nextInt(temperatures.length)]),
      heading: formatDate(nextDay1),
      subHeading: 'Vidhani - Min. Temp : ${temperatures[random.nextInt(temperatures.length)]}°C',
      color: const Color.fromARGB(255, 37, 37, 37),
    ),
    Weatherlist(
      image: getImageForTemperature(temperatures[random.nextInt(temperatures.length)]),
      heading: formatDate(nextDay2),
      subHeading: 'Vidhani - Min. Temp : ${temperatures[random.nextInt(temperatures.length)]}°C',
      color: const Color.fromARGB(255, 37, 37, 37),
    ),
    Weatherlist(
      image: getImageForTemperature(temperatures[random.nextInt(temperatures.length)]),
      heading: formatDate(nextDay3),
      subHeading: 'Vidhani - Min. Temp : ${temperatures[random.nextInt(temperatures.length)]}°C',
      color: const Color.fromARGB(255, 37, 37, 37),
    ),
  ];
}

List<Weatherlist> items = generateWeatherTiles();
