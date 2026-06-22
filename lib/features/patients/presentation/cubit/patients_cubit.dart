import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/patient_model.dart';
import '../../data/repos/patient_repo.dart';
import 'patients_state.dart';

class PatientsCubit extends Cubit<PatientsState> {
  final PatientRepo _repo;

  PatientsCubit(this._repo) : super(PatientsInitial());

  // Get All Patients
  void getPatients() {
    try {
      emit(PatientsLoading());
      final patients = _repo.getAllPatients();
      emit(PatientsLoaded(patients));
    } catch (e) {
      emit(PatientsError(e.toString()));
    }
  }

  // Add Patient
  void addPatient({
    required String name,
    required String phone,
    required int age,
    required String notes,
  }) {
    try {
      _repo.addPatient(name: name, phone: phone, age: age, notes: notes);
      getPatients();
    } catch (e) {
      emit(PatientsError(e.toString()));
    }
  }

  // Update Patient
  void updatePatient(PatientModel patient) {
    try {
      _repo.updatePatient(patient);
      getPatients();
    } catch (e) {
      emit(PatientsError(e.toString()));
    }
  }

  // Delete Patient
  void deletePatient(PatientModel patient) {
    try {
      _repo.deletePatient(patient);
      getPatients();
    } catch (e) {
      emit(PatientsError(e.toString()));
    }
  }
}
