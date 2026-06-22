import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/services_model.dart';
import '../../data/repos/service_repo.dart';
import 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  final ServiceRepo _repo;

  ServicesCubit(this._repo) : super(ServicesInitial());

  void getServices() {
    try {
      emit(ServicesLoading());
      final services = _repo.getAllServices();
      emit(ServicesLoaded(services));
    } catch (e) {
      emit(ServicesError(e.toString()));
    }
  }

  void addService({
    required String name,
    required String description,
    required double price,
    required String durationMinutes,
  }) {
    try {
      _repo.addService(
        name: name,
        description: description,
        price: price,
        durationMinutes: durationMinutes,
      );
      getServices();
    } catch (e) {
      emit(ServicesError(e.toString()));
    }
  }

  void updateService(ClinicServiceModel service) {
    try {
      _repo.updateService(service);
      getServices();
    } catch (e) {
      emit(ServicesError(e.toString()));
    }
  }

  void deleteService(ClinicServiceModel service) {
    try {
      _repo.deleteService(service);
      getServices();
    } catch (e) {
      emit(ServicesError(e.toString()));
    }
  }
}
