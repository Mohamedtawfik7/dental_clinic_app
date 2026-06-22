import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/appointment_model.dart';

class AppointmentRepo {
  final Box<AppointmentModel> _box = Hive.box<AppointmentModel>('appointments');

  // Get All Appointments
  List<AppointmentModel> getAllAppointments() {
    return _box.values.toList();
  }

  // Get Today's Appointments
  List<AppointmentModel> getTodayAppointments() {
    final today = DateTime.now();
    return _box.values.where((a) {
      return a.dateTime.year == today.year &&
          a.dateTime.month == today.month &&
          a.dateTime.day == today.day;
    }).toList();
  }

  // Add Appointment
  void addAppointment({
    required String patientId,
    required String patientName,
    required DateTime dateTime,
    required String serviceType,
    required String notes,
  }) {
    final appointment = AppointmentModel(
      id: const Uuid().v4(),
      patientId: patientId,
      patientName: patientName,
      dateTime: dateTime,
      serviceType: serviceType,
      notes: notes,
      isDone: false,
    );
    _box.put(appointment.id, appointment);
  }

  // Mark as Done
  void markAsDone(AppointmentModel appointment) {
    appointment.isDone = true;
    appointment.save();
  }

  // Delete Appointment
  void deleteAppointment(AppointmentModel appointment) {
    appointment.delete();
  }
}
