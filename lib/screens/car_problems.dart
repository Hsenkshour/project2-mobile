import 'package:flutter/material.dart';

class car_problems extends StatelessWidget {
  final Map<String, String> problemImages = {
    'Flat Tire': 'assets/flattire.png',
    'Engine Overheating': 'assets/EngineOverheating.png',
    'Battery Failure': 'assets/batteryfailure.jpg',
    'Brake Issues': 'assets/Brake.jpeg',
    'Transmission Problems': 'assets/Transmission.jpg',

  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Problems'),
        backgroundColor: Colors.yellow[600],
      ),
      body: ListView.builder(
        itemCount: problemImages.length,
        itemBuilder: (context, index) {
          var problem = problemImages.keys.elementAt(index);
          return Card(
            elevation: 3.0,
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: ListTile(
              title: Text(
                problem,
                style: TextStyle(color: Colors.black45),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProblemDetails(
                      problem: problem,
                      imageAsset: problemImages[problem]!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ProblemDetails extends StatelessWidget {
  final String problem;
  final String imageAsset;

  ProblemDetails({required this.problem, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    String instructions = '';

    switch (problem) {
      case 'Flat Tire':
        instructions = '1. Find a safe location to pull over.\n'
            '2. Turn on hazard lights.\n'
            '3. Locate spare tire, jack, and lug wrench.\n'
            '4. Loosen lug nuts.\n'
            '5. Use jack to lift the car.\n'
            '6. Remove the lug nuts and the flat tire.\n'
            '7. Put on the spare tire and tighten lug nuts.\n'
            '8. Lower the car with the jack.\n'
            '9. Tighten lug nuts further.\n'
            '10. Check tire pressure.';
        break;

      case 'Engine Overheating':
        instructions = '1. Turn off the engine.\n'
            '2. Allow the engine to cool down.\n'
            '3. Check coolant levels.\n'
            '4. Add coolant if levels are low.\n'
            '5. Check for leaks.\n'
            '6. Restart the engine.\n'
            '7. If the problem persists, seek professional help.';
        break;

      case 'Battery Failure':
        instructions = '1. Attempt to jump-start the car using jumper cables.\n'
            '2. Connect the positive (+) and negative (-) terminals correctly.\n'
            '3. Ask for help from another vehicle.\n'
            '4. If jump-starting doesn\'t work, replace the battery.';
        break;

      case 'Brake Issues':
        instructions = '1. Pay attention to any unusual sounds when braking.\n'
            '2. Check brake fluid levels.\n'
            '3. Inspect brake pads and rotors for wear.\n'
            '4. Replace worn-out brake components.\n'
            '5. If issues persist, consult a mechanic.';
        break;

      case 'Transmission Problems':
        instructions = '1. Check transmission fluid levels.\n'
            '2. Look for signs of fluid leaks under the vehicle.\n'
            '3. Test the transmission in different gears.\n'
            '4. If there are issues, consult a professional mechanic for diagnosis and repair.';
        break;

      default:
        instructions = 'No instructions available.';
        break;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(problem),
          backgroundColor: Colors.yellow[600],
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Image.asset(
                  imageAsset,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 16.0),
                Text(
                  'Instructions for $problem:',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                ),
                SizedBox(height: 8.0),
                Text(
                  instructions,
                  style: TextStyle(color: Colors.black45),
                ),

              ],
            ),
        ),
        );
    }
}