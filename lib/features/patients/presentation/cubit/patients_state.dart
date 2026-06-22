import 'package:equatable/equatable.dart';
import '../../data/models/patient_model.dart';

abstract class PatientsState extends Equatable {
  @override
  List<Object> get props => [];
}

class PatientsInitial extends PatientsState {}

class PatientsLoading extends PatientsState {}

class PatientsLoaded extends PatientsState {
  final List<PatientModel> patients;

  PatientsLoaded(this.patients);

  @override
  List<Object> get props => [patients];
}

class PatientsError extends PatientsState {
  final String message;

  PatientsError(this.message);

  @override
  List<Object> get props => [message];
}
