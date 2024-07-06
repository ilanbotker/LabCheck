import 'package:flutter/material.dart';
import 'package:lab_check/computer_check.dart';
import 'package:lab_check/database_service.dart';

class ComputerLabScreen extends StatefulWidget {
  @override
  _ComputerLabScreenState createState() => _ComputerLabScreenState();
}

class _ComputerLabScreenState extends State<ComputerLabScreen> {
  final _formKey = GlobalKey<FormState>();
  final _computerCheck = ComputerCheck();
  final _databaseService = DatabaseService();
  String? _selectedLab; // To store the selected lab number

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('בדיקת מעבדת מחשבים')),
      body: SingleChildScrollView( // Make content scrollable
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                _buildSectionHeader('מספר מעבדה'), // Section header for lab selection
                DropdownButtonFormField<String>(
                  value: _selectedLab,
                  decoration: InputDecoration(labelText: 'בחר מספר מעבדה'),
                  items: ['222', '223', '231'].map((String lab) {
                    return DropdownMenuItem<String>(
                      value: lab,
                      child: Text(lab),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'בחר מספר מעבדה';
                    }
                    return null;
                  },
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLab = newValue;
                      _computerCheck.labNumber = _selectedLab;
                    });
                  },
                ),

                _buildSectionHeader('ניקיון'),
                _buildCheckbox('מעבדה שטופה', _computerCheck.labWashed, (value) {
                  setState(() {
                    _computerCheck.labWashed = value!;
                  });
                }),
                _buildCheckbox('פח הוחלף', _computerCheck.binEmptied, (value) {
                  setState(() {
                    _computerCheck.binEmptied = value!;
                  });
                }),
                _buildCheckbox('לוח נקי', _computerCheck.whiteboardCleaned, (value) {
                  setState(() {
                    _computerCheck.whiteboardCleaned = value!;
                  });
                }),

                _buildSectionHeader('ציוד'),

                _buildCheckbox('פח', _computerCheck.hasGarbageCan, (value) {
                  setState(() {
                    _computerCheck.hasGarbageCan = value!;
                  });
                }),
                _buildCheckbox('מטאטא', _computerCheck.hasBroom, (value) {
                  setState(() {
                    _computerCheck.hasBroom = value!;
                  });
                }),
                _buildCheckbox('יעה', _computerCheck.hasWiper, (value) {
                  setState(() {
                    _computerCheck.hasWiper = value!;
                  });
                }),
                _buildCheckbox('מגב', _computerCheck.hasMop, (value) {
                  setState(() {
                    _computerCheck.hasMop = value!;
                  });
                }),
                _buildCheckbox('דלי', _computerCheck.hasBucket, (value) {
                  setState(() {
                    _computerCheck.hasBucket = value!;
                  });
                }),
                _buildCheckbox('מחק לוח', _computerCheck.hasWhiteboardEraser, (value) {
                  setState(() {
                    _computerCheck.hasWhiteboardEraser = value!;
                  });
                }),



                _buildSectionHeader('מחשבים'),
                for (int i = 0; i < _computerCheck.computers.length; i++)
                  _buildComputerCheckGroup(i),

                SizedBox(height: 20),
                _buildSectionHeader('שם הבודק'),
                TextFormField(
                  decoration: InputDecoration(labelText: 'שם מלא'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'הכנס שם מלא';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _computerCheck.checkerName = value;
                  },
                ),

                SizedBox(height: 30),
                Center( // Center the Submit button
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        try {
                          await _databaseService.saveComputerCheck(_computerCheck);
                          // Show success message (e.g., using a SnackBar)
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('בדיקה נשלחה בהצלחה!'))
                          );
                          // Optionally navigate back to the previous screen
                          Navigator.pop(context);
                        } catch (e) {
                          print("שגיאה בשליחת הבדיקה: $e");
                          // Show error message to the user
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('שגיאה בשליחת הבדיקה, נסה שנית'))
                          );
                        }
                      }
                    },
                    child: Text('שלח בדיקה'),
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
            Text('עמדה ${computerIndex + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
            _buildCheckbox('כונן', _computerCheck.computers[computerIndex]['drive']!, (value) {
              setState(() {
                _computerCheck.computers[computerIndex]['drive'] = value!;
              });
            }),
            _buildCheckbox('מסך', _computerCheck.computers[computerIndex]['screen']!, (value) {
              setState(() {
                _computerCheck.computers[computerIndex]['screen'] = value!;
              });
            }),
            _buildCheckbox('מקלדת', _computerCheck.computers[computerIndex]['keyboard']!, (value) {
              setState(() {
                _computerCheck.computers[computerIndex]['keyboard'] = value!;
              });
            }),
            _buildCheckbox('עכבר', _computerCheck.computers[computerIndex]['mouse']!, (value) {
              setState(() {
                _computerCheck.computers[computerIndex]['mouse'] = value!;
              });
            }),
            _buildCheckbox('מערכת הפעלה', _computerCheck.computers[computerIndex]['startup']!, (value) {
              setState(() {
                _computerCheck.computers[computerIndex]['startup'] = value!;
              });
            }),
            _buildCheckbox('אינטרנט', _computerCheck.computers[computerIndex]['internet']!, (value) {
              setState(() {
                _computerCheck.computers[computerIndex]['internet'] = value!;
              });
            }),

          ],
        ),
      ),
    );
  }
}