import 'package:dental_clinic_app/core/di/service_locator.dart';
import 'package:dental_clinic_app/features/patients/presentation/cubit/patients_cubit.dart';
import 'package:dental_clinic_app/features/patients/presentation/cubit/patients_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PatientsCubit>()..getPatients(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Patients')),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () => _showAddPatientDialog(context),
            child: const Icon(Icons.add),
          ),
        ),
        body: BlocBuilder<PatientsCubit, PatientsState>(
          builder: (context, state) {
            if (state is PatientsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PatientsError) {
              return Center(child: Text(state.message));
            }

            if (state is PatientsLoaded) {
              if (state.patients.isEmpty) {
                return const Center(child: Text('No patients found'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.patients.length,
                itemBuilder: (context, index) {
                  final patient = state.patients[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(patient.name),
                      subtitle: Text('${patient.phone} • ${patient.age} years'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context.read<PatientsCubit>().deletePatient(patient);
                        },
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  void _showAddPatientDialog(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final ageController = TextEditingController();
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Patient'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: notesController,
                decoration: const InputDecoration(labelText: 'Notes'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<PatientsCubit>().addPatient(
                name: nameController.text,
                phone: phoneController.text,
                age: int.tryParse(ageController.text) ?? 0,
                notes: notesController.text,
              );
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
