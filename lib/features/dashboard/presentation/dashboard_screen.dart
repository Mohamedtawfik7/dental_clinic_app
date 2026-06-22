import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('عيادة الأسنان')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/patients'),
              child: const Text('المرضى'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/appointments'),
              child: const Text('المواعيد'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/services'),
              child: const Text('الخدمات'),
            ),
          ],
        ),
      ),
    );
  }
}
