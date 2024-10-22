import 'package:flutter/material.dart';
import 'package:lab_check/electrical_check.dart';
import 'package:lab_check/database_service.dart';

class ElectricalLabScreen extends StatefulWidget {
  @override
  _ElectricalLabScreenState createState() => _ElectricalLabScreenState();
}

class _ElectricalLabScreenState extends State<ElectricalLabScreen> {
  final _formKey = GlobalKey<FormState>();
  final _electricalCheck = ElectricalCheck();
  final _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Electrical Lab Check')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Cleanliness'),
                _buildCheckbox('Lab Washed?', _electricalCheck.labWashed, (value) {
                  setState(() {
                    _electricalCheck.labWashed = value!;
                  });
                }),
                // ... Add checkboxes for other cleaning items

                _buildSectionHeader('Computing'),
                for (int i = 0; i < _electricalCheck.computers.length; i++)
                  _buildComputerCheckGroup(i),

                _buildSectionHeader('Electrical Equipment'),
                // (You might have specific checks here - add if needed)

                _buildSectionHeader('Non-Functional Equipment'),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Describe any non-functional equipment',
                    hintText: 'E.g., Power outlet #3 not working',
                  ),
                  maxLines: 3, // Allow multiple lines for input
                  onSaved: (value) {
                    _electricalCheck.nonFunctionalEquipment = value;
                  },
                ),

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
                    _electricalCheck.checkerName = value;
                  },
                ),

                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        try {
                          await _databaseService.saveElectricalCheck(_electricalCheck);
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
            _buildCheckbox('Drive', _electricalCheck.computers[computerIndex]['drive']!, (value) {
              setState(() {
                _electricalCheck.computers[computerIndex]['drive'] = value!;
              });
            }),
            _buildCheckbox('Screen', _electricalCheck.computers[computerIndex]['screen']!, (value) {
              setState(() {
                _electricalCheck.computers[computerIndex]['screen'] = value!;
              });
            }),
            // ... Add checkboxes for Mouse, Keyboard, Startup, Internet
          ],
        ),
      ),
    );
  }
}