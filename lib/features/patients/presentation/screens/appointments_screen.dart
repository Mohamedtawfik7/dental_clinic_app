import 'package:dental_clinic_app/core/di/service_locator.dart';
import 'package:dental_clinic_app/features/appointments/data/models/appointment_model.dart';
import 'package:dental_clinic_app/features/appointments/presentation/cubit/appointments_cubit.dart';
import 'package:dental_clinic_app/features/appointments/presentation/cubit/appointments_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AppointmentsCubit>()..getAppointments(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Appointments')),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () => _showAddAppointmentDialog(context),
            child: const Icon(Icons.add),
          ),
        ),
        body: BlocBuilder<AppointmentsCubit, AppointmentsState>(
          builder: (context, state) {
            if (state is AppointmentsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AppointmentsError) {
              return Center(child: Text(state.message));
            }

            if (state is AppointmentsLoaded) {
              if (state.appointments.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 80,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No appointments yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap + to add your first appointment',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.appointments.length,
                itemBuilder: (context, index) {
                  final appointment = state.appointments[index];
                  return _AppointmentCard(appointment: appointment);
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  void _showAddAppointmentDialog(BuildContext context) {
    final patientNameController = TextEditingController();
    final serviceController = TextEditingController();
    final notesController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add Appointment'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: patientNameController,
                decoration: const InputDecoration(labelText: 'Patient Name'),
              ),
              TextField(
                controller: serviceController,
                decoration: const InputDecoration(labelText: 'Service Type'),
              ),
              TextField(
                controller: notesController,
                decoration: const InputDecoration(labelText: 'Notes'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: dialogContext,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) selectedDate = picked;
                },
                child: const Text('Pick Date'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AppointmentsCubit>().addAppointment(
                patientId: '',
                patientName: patientNameController.text,
                dateTime: selectedDate,
                serviceType: serviceController.text,
                notes: notesController.text,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Appointment added successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(dialogContext);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;

  const _AppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: appointment.isDone ? Colors.green : Colors.blue,
          child: Icon(
            appointment.isDone ? Icons.check : Icons.access_time,
            color: Colors.white,
          ),
        ),
        title: Text(appointment.patientName),
        subtitle: Text(
          '${appointment.serviceType} • ${appointment.dateTime.day}/${appointment.dateTime.month}/${appointment.dateTime.year}',
        ),
        trailing: appointment.isDone
            ? const Chip(label: Text('Done'))
            : IconButton(
                icon: const Icon(Icons.check_circle_outline),
                onPressed: () {
                  context.read<AppointmentsCubit>().markAsDone(appointment);
                },
              ),
        onLongPress: () => _showDeleteDialog(context, appointment),
      ),
    );
  }
}

void _showDeleteDialog(BuildContext context, AppointmentModel appointment) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Delete Appointment'),
      content: Text(
        'Are you sure you want to delete ${appointment.patientName}?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            context.read<AppointmentsCubit>().deleteAppointment(appointment);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Appointment deleted'),
                backgroundColor: Colors.red,
              ),
            );
          },
          child: const Text('Delete', style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}
