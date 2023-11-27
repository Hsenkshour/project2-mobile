import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project2/providers/car_provider.dart';
import 'car_option_screen.dart';
import '../../widgets/car_card.dart';

class CarRentalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Rental Cars'),
        centerTitle: true,
        backgroundColor: Colors.yellow[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(

          children: [
            Text(
              'Choose Your Car',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(

                itemCount: carProvider.cars.length,
                itemBuilder: (context, index) {
                  final car = carProvider.cars[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarOptionsScreen(car),
                        ),
                      );
                    },
                    child: CarCard(
                      car: car,
                      onCarSelected: (selectedCar) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CarOptionsScreen(selectedCar),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
