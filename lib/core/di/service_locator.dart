import 'package:dental_clinic_app/features/patients/presentation/cubit/patients_cubit.dart';
import 'package:get_it/get_it.dart';
import '../../features/appointments/data/repos/appointment_repo.dart';
import '../../features/patients/data/repos/patient_repo.dart';
import '../../features/services/data/repos/service_repo.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Repositories
  getIt.registerLazySingleton<PatientRepo>(() => PatientRepo());
  getIt.registerLazySingleton<AppointmentRepo>(() => AppointmentRepo());
  getIt.registerLazySingleton<ServiceRepo>(() => ServiceRepo());
  getIt.registerFactory<PatientsCubit>(
    () => PatientsCubit(getIt<PatientRepo>()),
  );
}
