import 'package:dental_clinic_app/features/appointments/presentation/cubit/appointments_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/appointment_model.dart';
import '../../data/repos/appointment_repo.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  final AppointmentRepo _repo;

  AppointmentsCubit(this._repo) : super(AppointmentsInitial());

  void getAppointments() {
    try {
      emit(AppointmentsLoading());
      final appointments = _repo.getAllAppointments();
      emit(AppointmentsLoaded(appointments));
    } catch (e) {
      emit(AppointmentsError(e.toString()));
    }
  }

  void getTodayAppointments() {
    try {
      emit(AppointmentsLoading());
      final appointments = _repo.getTodayAppointments();
      emit(AppointmentsLoaded(appointments));
    } catch (e) {
      emit(AppointmentsError(e.toString()));
    }
  }

  void addAppointment({
    required String patientId,
    required String patientName,
    required DateTime dateTime,
    required String serviceType,
    required String notes,
  }) {
    try {
      _repo.addAppointment(
        patientId: patientId,
        patientName: patientName,
        dateTime: dateTime,
        serviceType: serviceType,
        notes: notes,
      );
      getAppointments();
    } catch (e) {
      emit(AppointmentsError(e.toString()));
    }
  }

  void markAsDone(AppointmentModel appointment) {
    try {
      _repo.markAsDone(appointment);
      getAppointments();
    } catch (e) {
      emit(AppointmentsError(e.toString()));
    }
  }

  void deleteAppointment(AppointmentModel appointment) {
    try {
      _repo.deleteAppointment(appointment);
      getAppointments();
    } catch (e) {
      emit(AppointmentsError(e.toString()));
    }
  }
}
