import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_check/computer_check.dart';
import 'package:lab_check/electronics_check.dart';
import 'package:lab_check/electrical_check.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Computer Lab Check
  Future<void> saveComputerCheck(ComputerCheck check) async {
    try {
      await _firestore.collection('computerLabChecks').add(check.toJson());
      print('Computer Lab Check saved successfully!');
    } catch (e) {
      print('Error saving Computer Lab Check: $e');
      // Handle errors (e.g., show a user-friendly error message)
    }
  }

  // Electronics Lab Check
  Future<void> saveElectronicsCheck(ElectronicsCheck check) async {
    try {
      await _firestore.collection('electronicsLabChecks').add(check.toJson());
      print('Electronics Lab Check saved successfully!');
    } catch (e) {
      print('Error saving Electronics Lab Check: $e');
      // Handle errors
    }
  }

  // Electrical Lab Check
  Future<void> saveElectricalCheck(ElectricalCheck check) async {
    try {
      await _firestore.collection('electricalLabChecks').add(check.toJson());
      print('Electrical Lab Check saved successfully!');
    } catch (e) {
      print('Error saving Electrical Lab Check: $e');
      // Handle errors
    }
  }
}