import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/services_model.dart';

class ServiceRepo {
  final Box<ClinicServiceModel> _box = Hive.box<ClinicServiceModel>('services');

  // Get All Services
  List<ClinicServiceModel> getAllServices() {
    return _box.values.toList();
  }

  // Add Service
  void addService({
    required String name,
    required String description,
    required double price,
    required String durationMinutes,
  }) {
    final service = ClinicServiceModel(
      id: const Uuid().v4(),
      name: name,
      description: description,
      price: price,
      durationMinutes: durationMinutes,
    );
    _box.put(service.id, service);
  }

  // Update Service
  void updateService(ClinicServiceModel service) {
    service.save();
  }

  // Delete Service
  void deleteService(ClinicServiceModel service) {
    service.delete();
  }
}
