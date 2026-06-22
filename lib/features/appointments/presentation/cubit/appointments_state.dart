import 'package:equatable/equatable.dart';
import '../../data/models/appointment_model.dart';

abstract class AppointmentsState extends Equatable {
  @override
  List<Object> get props => [];
}

class AppointmentsInitial extends AppointmentsState {}

class AppointmentsLoading extends AppointmentsState {}

class AppointmentsLoaded extends AppointmentsState {
  final List<AppointmentModel> appointments;

  AppointmentsLoaded(this.appointments);

  @override
  List<Object> get props => [appointments];
}

class AppointmentsError extends AppointmentsState {
  final String message;

  AppointmentsError(this.message);

  @override
  List<Object> get props => [message];
}
