import 'package:flutter/material.dart';
import 'manage_news_screen.dart';
import 'manage_programs_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Pengurus'),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(24),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _adminCard(
            context,
            'Kelola Berita',
            Icons.newspaper,
            Colors.blue,
            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageNewsScreen())),
          ),
          _adminCard(
            context,
            'Kelola Program',
            Icons.volunteer_activism,
            Colors.green,
            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageProgramsScreen())),
          ),
          _adminCard(
            context,
            'Data Santri',
            Icons.school,
            Colors.orange,
            () {},
          ),
          _adminCard(
            context,
            'Laporan Keuangan',
            Icons.payments,
            Colors.purple,
            () {},
          ),
        ],
      ),
    );
  }

  Widget _adminCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: color.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
