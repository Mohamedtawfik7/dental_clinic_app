import 'package:hive/hive.dart';
part 'services_model.g.dart';

@HiveType(typeId: 2)
class ClinicServiceModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late double price;

  @HiveField(4)
  late String durationMinutes;

  ClinicServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationMinutes,
  });
}
