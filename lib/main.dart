import 'package:dental_clinic_app/core/di/service_locator.dart';
import 'package:dental_clinic_app/core/router/app_router.dart';
import 'package:dental_clinic_app/features/appointments/data/models/appointment_model.dart';
import 'package:dental_clinic_app/features/patients/data/models/patient_model.dart';
import 'package:dental_clinic_app/features/services/data/models/services_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Register Adapters
  Hive.registerAdapter(PatientModelAdapter());
  Hive.registerAdapter(AppointmentModelAdapter());
  Hive.registerAdapter(ClinicServiceModelAdapter());
  // Open Boxes
  await Hive.openBox<PatientModel>('patients');
  await Hive.openBox<AppointmentModel>('appointments');
  await Hive.openBox<ClinicServiceModel>('services');
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Dental Clinic',
      routerConfig: AppRouter.router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A73E8)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF03589B),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 15, 71, 145),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
        ),
        useMaterial3: true,
      ),
    );
  }
}
