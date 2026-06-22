import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/patient_model.dart';

class PatientRepo {
  final Box<PatientModel> _box = Hive.box<PatientModel>('patients');

  // Get All Patients
  List<PatientModel> getAllPatients() {
    return _box.values.toList();
  }

  // Add Patient
  void addPatient({
    required String name,
    required String phone,
    required int age,
    required String notes,
  }) {
    final patient = PatientModel(
      id: const Uuid().v4(),
      name: name,
      phone: phone,
      age: age,
      notes: notes,
    );
    _box.put(patient.id, patient);
  }

  // Update Patient
  void updatePatient(PatientModel patient) {
    patient.save();
  }

  // Delete Patient
  void deletePatient(PatientModel patient) {
    patient.delete();
  }
}
