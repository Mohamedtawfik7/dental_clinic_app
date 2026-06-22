import 'package:hive/hive.dart';

part 'appointment_model.g.dart';

@HiveType(typeId: 1)
class AppointmentModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String patientId;

  @HiveField(2)
  late String patientName;

  @HiveField(3)
  late DateTime dateTime;

  @HiveField(4)
  late String serviceType;

  @HiveField(5)
  late String notes;

  @HiveField(6)
  late bool isDone;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.dateTime,
    required this.serviceType,
    required this.notes,
    required this.isDone,
  });
}
