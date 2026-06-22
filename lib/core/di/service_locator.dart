import 'package:dental_clinic_app/features/appointments/presentation/cubit/appointments_cubit.dart';
import 'package:dental_clinic_app/features/patients/presentation/cubit/patients_cubit.dart';
import 'package:dental_clinic_app/features/services/presentation/cubit/services_cubit.dart';
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
  getIt.registerFactory<AppointmentsCubit>(
    () => AppointmentsCubit(getIt<AppointmentRepo>()),
  );
  getIt.registerFactory<ServicesCubit>(
    () => ServicesCubit(getIt<ServiceRepo>()),
  );
}
