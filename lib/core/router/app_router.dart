import 'package:dental_clinic_app/features/dashboard/presentation/dashboard_screen.dart';
import 'package:dental_clinic_app/features/patients/presentation/screens/appointments_screen.dart';
import 'package:dental_clinic_app/features/patients/presentation/screens/services_screen.dart';
import 'package:dental_clinic_app/features/splash/presentation/splash_screen.dart';
import 'package:go_router/go_router.dart';
import '../../features/patients/presentation/screens/patients_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(), // ← غيرنا البداية
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/patients',
        builder: (context, state) => const PatientsScreen(),
      ),
      GoRoute(
        path: '/appointments',
        builder: (context, state) => const AppointmentsScreen(),
      ),
      GoRoute(
        path: '/services',
        builder: (context, state) => const ServicesScreen(),
      ),
    ],
  );
}
