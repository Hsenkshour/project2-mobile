// car_provider.dart

import 'package:flutter/material.dart';
import '../models/car.dart';

class CarProvider with ChangeNotifier {
  // Map to store the availability of each option for every car model
  Map<String, Map<String, int>> _carCounters = {
    'Toyota Camry': {'Manual': 5, 'Automatic': 5},
    'Honda Accord': {'Manual': 2, 'Automatic': 6},
    'Mercedes GLE 400': {'Manual': 0, 'Automatic': 2},
    'BMW X5': {'Manual': 0, 'Automatic': 2},
    'Aston Martin Vanquish': {'Manual': 0, 'Automatic': 1},
    'Mazda CX-5': {'Manual': 0, 'Automatic': 3},
    'Audi A8': {'Manual': 0, 'Automatic': 4},

    // Add more cars and options as needed
  };

  List<Car> _cars = [
    Car(
      name: 'Toyota Camry',
      imageUrl: 'assets/download.jpg',
      basePrice: 30,

    ),
    Car(
      name: 'Honda Accord',
      imageUrl: 'assets/Honda Accord Hybrid Wards winner - resized.jpg',
      basePrice: 15,

    ),
    Car(
      name: 'Mercedes GLE 400',
      imageUrl: 'assets/download.jpeg',
      basePrice: 110,

    ),
    Car(
      name: 'BMW X5',
      imageUrl: 'assets/download-1.jpeg',
      basePrice: 70,

    ),
    Car(
      name: 'Aston Martin Vanquish',
      imageUrl: 'assets/download-2.jpeg',
      basePrice: 180,

    ),
    Car(
      name: 'Mazda CX-5',
      imageUrl: 'assets/download-3.jpeg',
      basePrice: 50,

    ),
    Car(
      name: 'Audi A8',
      imageUrl: 'assets/download-4.jpeg',
      basePrice: 75,

    ),

    // Add more cars as needed
  ];

  List<Car> get cars => [..._cars];


  Map<String, Map<String, int>> get carCounters => {..._carCounters};


  bool reserveCar(Car car, String option, int rentalDuration) {
    if (_carCounters.containsKey(car.name) &&
        _carCounters[car.name]!.containsKey(option) &&
        _carCounters[car.name]![option]! > 0) {
      // Reserve the car
      _carCounters[car.name]![option] = (_carCounters[car.name]![option] ?? 0) - 1;


      notifyListeners();


      return true;
    } else {
      return false;
    }
  }



}
