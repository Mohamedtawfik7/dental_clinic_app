import 'package:hive/hive.dart';
part 'patient_model.g.dart';

@HiveType(typeId: 0)
class PatientModel extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;

  @HiveField(2)
  late String phone;

  @HiveField(3)
  late int age;

  @HiveField(4)
  late String notes;

  PatientModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.age,
    required this.notes,
  });
}
