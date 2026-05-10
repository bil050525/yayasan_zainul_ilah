import 'package:flutter/material.dart';

class ParentDashboard extends StatelessWidget {
  const ParentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal Orang Tua'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStudentInfo(context),
            const SizedBox(height: 24),
            _buildSectionTitle('Ringkasan Harian Anak'),
            const SizedBox(height: 16),
            _buildDailySummary(),
            const SizedBox(height: 24),
            _buildSectionTitle('Layanan Akademik & Keuangan'),
            const SizedBox(height: 16),
            _buildServiceGrid(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildStudentInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(Icons.face, size: 40, color: Color(0xFF1B5E20)),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ahmad Zaidan',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Kelas 4A - Madrasah Ibtidaiyah',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                'NIS: 202400105',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDailySummary() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _summaryRow(Icons.check_circle, 'Status Kehadiran', 'HADIR', Colors.green),
            const Divider(),
            _summaryRow(Icons.book, 'Jadwal Besok', 'Fikih, B. Arab, Matematika', Colors.blue),
            const Divider(),
            _summaryRow(Icons.assignment, 'Tugas Baru', '2 Belum Selesai', Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(IconData icon, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildServiceGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.3,
      children: [
        _serviceCard(context, Icons.description, 'Rapor Digital', Colors.indigo),
        _serviceCard(context, Icons.payments, 'Tagihan SPP', Colors.teal),
        _serviceCard(context, Icons.shopping_bag, 'Seragam & Buku', Colors.brown),
        _serviceCard(context, Icons.chat, 'Konsultasi Guru', Colors.cyan),
      ],
    );
  }

  Widget _serviceCard(BuildContext context, IconData icon, String label, Color color) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
