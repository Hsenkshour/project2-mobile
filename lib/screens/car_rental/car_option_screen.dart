
import 'package:flutter/material.dart';
import '../../models/car.dart';
import 'package:provider/provider.dart';
import 'package:project2/providers/car_provider.dart';

class CarOptionsScreen extends StatefulWidget {
  final Car selectedCar;

  CarOptionsScreen(this.selectedCar);

  @override
  _CarOptionsScreenState createState() => _CarOptionsScreenState();
}

class _CarOptionsScreenState extends State<CarOptionsScreen> {
  Map<String, String?> selectedOptions = {};
  double basePrice =0;
  int rentalDuration = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Options'),
        backgroundColor: Colors.yellow[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 16),
            _buildOptionsList(),
            SizedBox(height: 16),
            _buildRentalDurationCounter(),
            SizedBox(height: 16),
            ElevatedButton(

              onPressed: () {
                _reserveCar();
              },
              child: Text('Reserve Car'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected Car: ${widget.selectedCar.name}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(
          'Price: \$${basePrice.toStringAsFixed(2)} ',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 16),
        Text(
          'Selected Options: ${selectedOptions.entries.map((entry) => '${entry.key}: ${entry.value}').join(', ')}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 16),
        // Display counters for manual and automatic options
        Text(
          'Manual Counter: ${context.watch<CarProvider>().carCounters[widget.selectedCar.name]?['Manual'] ?? 0}',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          'Automatic Counter: ${context.watch<CarProvider>().carCounters[widget.selectedCar.name]?['Automatic'] ?? 0}',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildOptionsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: optionsList.length,
        itemBuilder: (context, index) {
          final option = optionsList[index];
          return _buildOptionCard(option);
        },
      ),
    );
  }

  Widget _buildOptionCard(Map<String, dynamic> option) {
    final String optionName = option['name'];
    final List<Map<String, dynamic>>? nestedOptions = option['options'];
    final bool hasNestedOptions = nestedOptions != null && nestedOptions.isNotEmpty;
    final String? selectedNestedOption = selectedOptions[optionName];

    return GestureDetector(
      onTap: () => _onOptionTap(optionName),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$optionName',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            if (hasNestedOptions) _buildDropdown(optionName, nestedOptions, selectedNestedOption),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String optionName, List<Map<String, dynamic>> options, String? selectedNestedOption) {
    return DropdownButton<String>(
      hint: Text('Select an option'),
      value: selectedNestedOption,
      items: _buildDropdownItems(options),
      onChanged: (value) {
        _updateSelectedOption(optionName, value);
      },
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems(List<Map<String, dynamic>> options) {
    return options
        .map((nestedOption) => DropdownMenuItem<String>(
      value: nestedOption['name'] as String,
      child: Text('${nestedOption['name']} (\$${nestedOption['price'].toStringAsFixed(2)})'),
    ))
        .toList();
  }

  void _updateSelectedOption(String optionName, String? selectedNestedOption) {
    setState(() {
      selectedOptions = Map.from(selectedOptions)..[optionName] = selectedNestedOption;
      _updateBasePrice();
    });
  }

  void _updateBasePrice() {
    double totalOptionsPrice = 0.0;
    optionsList.forEach((option) {
      final selectedOption = selectedOptions[option['name']];
      if (selectedOption != null) {
        final matchingOption = option['options'].firstWhere(
              (o) => o['name'] == selectedOption as String,
          orElse: () => {'name': '', 'price': 0}, // Default values if not found
        );
        totalOptionsPrice += (matchingOption['price'] as num).toDouble();
      }
    });

    final carBasePrice = widget.selectedCar.basePrice;
    setState(() {
      basePrice = carBasePrice + totalOptionsPrice;
      basePrice *= rentalDuration;
    });
  }



  void _onOptionTap(String optionName) {
    // Implement your desired transition or action here
    print('Tapped on $optionName');
  }

  Widget _buildRentalDurationCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Rental Duration:',
          style: TextStyle(fontSize: 18),
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                _updateRentalDuration(-1);
              },
            ),
            Text(
              '$rentalDuration days',
              style: TextStyle(fontSize: 18),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _updateRentalDuration(1);
              },
            ),
          ],
        ),
      ],
    );
  }

  void _updateRentalDuration(int change) {
    setState(() {
      rentalDuration = (rentalDuration + change).clamp(1, 30);
      _updateBasePrice();
    });
  }
// ...

// ...

  void _reserveCar() async {
    final carProvider = context.read<CarProvider>();
    final String? selectedOption = selectedOptions['Transmission']; // Change to 'Transmission'
    final bool reserved = carProvider.reserveCar(widget.selectedCar, selectedOption!, rentalDuration);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reservation Status'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                reserved
                    ? 'Car reserved successfully!'
                    : 'Car reservation failed. Not enough available cars or invalid option.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Thank you for choosing our service!',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Close the options page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[600], // Change the button color as needed
              ),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


}

List<Map<String, dynamic>> optionsList = [
  {
    'name': 'Color',
    'options': [
      {'name': 'Black', 'price': 0},
      {'name': 'Red', 'price': 0},
      {'name': 'Blue', 'price': 0},
      {'name': 'None', 'price': 0},
    ],
  },
  {
    'name': 'Model',
    'options': [
      {'name': 'Standard', 'price': 10},
      {'name': 'Premium', 'price': 15},
    ],
  },
  {
    'name': 'Transmission',
    'options': [
      {'name': 'Manual', 'price': 0},
      {'name': 'Automatic', 'price': 0},
    ],
  },
  // Add more options as needed
];

