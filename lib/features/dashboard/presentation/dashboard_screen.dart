import 'package:dental_clinic_app/core/di/service_locator.dart';
import 'package:dental_clinic_app/features/appointments/presentation/cubit/appointments_cubit.dart';
import 'package:dental_clinic_app/features/appointments/presentation/cubit/appointments_state.dart';
import 'package:dental_clinic_app/features/patients/presentation/cubit/patients_cubit.dart';
import 'package:dental_clinic_app/features/patients/presentation/cubit/patients_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<PatientsCubit>()..getPatients()),
        BlocProvider(
          create: (_) => getIt<AppointmentsCubit>()..getTodayAppointments(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dental Clinic 🦷 '),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Center(
                child: Text(
                  ' 👋 !Good Morning, Doctor ',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF689F38),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Stats Row
              Row(
                children: [
                  // Total Patients
                  Expanded(
                    child: BlocBuilder<PatientsCubit, PatientsState>(
                      builder: (context, state) {
                        final count = state is PatientsLoaded
                            ? state.patients.length
                            : 0;
                        return _StatCard(
                          title: 'Total Patients',
                          count: count,
                          icon: Icons.people,
                          color: Colors.blue,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Today's Appointments
                  Expanded(
                    child: BlocBuilder<AppointmentsCubit, AppointmentsState>(
                      builder: (context, state) {
                        final count = state is AppointmentsLoaded
                            ? state.appointments.length
                            : 0;
                        return _StatCard(
                          title: "Today's",
                          count: count,
                          icon: Icons.calendar_today,
                          color: Colors.green,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Navigation Cards
              const Text(
                'Quick Access',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              _NavCard(
                title: 'Patients',
                subtitle: 'Manage your patients',
                icon: Icons.people,
                color: Colors.blue,
                onTap: () => context.push('/patients'),
              ),
              const SizedBox(height: 12),

              _NavCard(
                title: 'Appointments',
                subtitle: 'View and manage appointments',
                icon: Icons.calendar_month,
                color: Colors.green,
                onTap: () => context.push('/appointments'),
              ),
              const SizedBox(height: 12),

              _NavCard(
                title: 'Services',
                subtitle: 'Manage clinic services',
                icon: Icons.medical_services,
                color: Colors.orange,
                onTap: () => context.push('/services'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 13, color: color.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
}

class _NavCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _NavCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
