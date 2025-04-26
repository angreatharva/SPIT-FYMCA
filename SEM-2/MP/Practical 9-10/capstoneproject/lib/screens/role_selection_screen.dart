import 'package:flutter/material.dart';

import '../widgets/custom_bottom_nav.dart';
import 'join_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  final String selfCallerId;

  const RoleSelectionScreen({super.key, required this.selfCallerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Role'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _roleButton(
              context,
              title: 'Doctor',
              color: Colors.blue,
              isDoctor: true,
              calleeId: 'patient123',
            ),
            const SizedBox(height: 30),
            _roleButton(
              context,
              title: 'Patient',
              color: Colors.green,
              isDoctor: false,
              calleeId: 'doctor123',
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }

  Widget _roleButton(
      BuildContext context, {
        required String title,
        required Color color,
        required bool isDoctor,
        required String calleeId,
      }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        textStyle: const TextStyle(fontSize: 18),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => JoinScreen(selfCallerId: selfCallerId,role: isDoctor,)
          ),
        );
      },
      child: Text('Join as $title'),
    );
  }
}
