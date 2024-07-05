import 'package:flutter/material.dart';
import 'package:lab_check/electronics_check.dart';
import 'package:lab_check/database_service.dart';

class ElectronicsLabScreen extends StatefulWidget {
  @override
  _ElectronicsLabScreenState createState() => _ElectronicsLabScreenState();
}

class _ElectronicsLabScreenState extends State<ElectronicsLabScreen> {
  final _formKey = GlobalKey<FormState>();
  final _electronicsCheck = ElectronicsCheck();
  final _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Electronics Lab Check')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Cleanliness'),
                _buildCheckbox('Lab Washed?', _electronicsCheck.labWashed, (value) {
                  setState(() {
                    _electronicsCheck.labWashed = value!;
                  });
                }),
                // ... Add checkboxes for other cleaning items

                _buildSectionHeader('Computing'),
                for (int i = 0; i < _electronicsCheck.computers.length; i++)
                  _buildComputerCheckGroup(i),

                _buildSectionHeader('Electronics Equipment'),
                for (int i = 0; i < _electronicsCheck.equipmentStations.length; i++)
                  _buildEquipmentStationCheckGroup(i),

                SizedBox(height: 20),
                _buildSectionHeader('Checker Information'),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Your Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _electronicsCheck.checkerName = value;
                  },
                ),

                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        try {
                          await _databaseService.saveElectronicsCheck(_electronicsCheck);
                          // Show success message (e.g., using a SnackBar)
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Check submitted successfully!'))
                          );
                          // Optionally navigate back to the previous screen
                          Navigator.pop(context);
                        } catch (e) {
                          print("Error saving check: $e");
                          // Show error message to the user
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error submitting check. Please try again.'))
                          );
                        }
                      }
                    },
                    child: Text('Submit Check'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper functions (similar to computer_lab_screen.dart)
  // ...
  // (You can copy the _buildSectionHeader and _buildCheckbox functions
  // from the previous computer_lab_screen.dart example)

// Helper function to build section headers
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Helper function to build checkboxes
  Widget _buildCheckbox(String label, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(label),
      ],
    );
  }

  // Helper function to build a group of checkboxes for a single computer
  Widget _buildComputerCheckGroup(int computerIndex) {
    return Card( // Use a Card widget for better visual separation
      margin: EdgeInsets.symmetric(vertical: 8.0), // Add margin
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Computer ${computerIndex + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
            _buildCheckbox('Drive', _electronicsCheck.computers[computerIndex]['drive']!, (value) {
              setState(() {
                _electronicsCheck.computers[computerIndex]['drive'] = value!;
              });
            }),
            _buildCheckbox('Screen', _electronicsCheck.computers[computerIndex]['screen']!, (value) {
              setState(() {
                _electronicsCheck.computers[computerIndex]['screen'] = value!;
              });
            }),
            // ... Add checkboxes for Mouse, Keyboard, Startup, Internet
          ],
        ),
      ),
    );
  }

  // Helper function to build checkboxes for an equipment station
  Widget _buildEquipmentStationCheckGroup(int stationIndex) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Station ${stationIndex + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
            _buildCheckbox('Oscilloscope', _electronicsCheck.equipmentStations[stationIndex]['oscilloscope']!, (value) {
              setState(() {
                _electronicsCheck.equipmentStations[stationIndex]['oscilloscope'] = value!;
              });
            }),
            // ... Add checkboxes for Signal Generator, Dual Power Supply, Multimeter
          ],
        ),
      ),
    );
  }
}