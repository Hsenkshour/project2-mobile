import 'package:flutter/material.dart';
import '../login.dart';
import 'car_rental/car_rental_screen.dart';
import 'car_problems.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Helper App'),
        backgroundColor: Colors.yellow[600],
        elevation: 5,
        actions: [
          _buildLoginButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Background-4.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20,),
            _buildAnimatedSquareButton(
              context: context,
              text: 'Rental Cars',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CarRentalScreen()),
                );
              },
            ),

            SizedBox(height: 16),
            _buildAnimatedSquareButton(
              context: context,
              text: 'Common Car Problems',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => car_problems()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedSquareButton({
    required BuildContext context,
    required String text,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.yellow[600],
          //color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton({required VoidCallback onPressed}) {
    return IconButton(
      icon: Icon(Icons.login),
      onPressed: onPressed,
    );
  }
}
