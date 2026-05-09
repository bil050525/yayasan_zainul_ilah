import 'package:flutter/material.dart';

class TransparencyDashboard extends StatelessWidget {
  const TransparencyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Transparansi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatGrid(),
            const SizedBox(height: 24),
            _buildSectionTitle('Penyaluran Dana'),
            const SizedBox(height: 16),
            _buildDistributionChart(),
            const SizedBox(height: 24),
            _buildSectionTitle('Aktivitas Terbaru'),
            const SizedBox(height: 16),
            _buildRecentActivities(),
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

  Widget _buildStatGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        _statCard('Total Dana', 'Rp 1.2M', Icons.account_balance_wallet, Colors.blue),
        _statCard('Program', '12 Aktif', Icons.assignment, Colors.orange),
        _statCard('Donatur', '4.5k+', Icons.people, Colors.purple),
        _statCard('Tersalurkan', '85%', Icons.check_circle, Colors.green),
      ],
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildDistributionChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _chartRow('Pendidikan', 0.45, Colors.blue),
            _chartRow('Sosial', 0.30, Colors.green),
            _chartRow('Dakwah', 0.15, Colors.orange),
            _chartRow('Operasional', 0.10, Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _chartRow(String label, double percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text('${(percentage * 100).toInt()}%'),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: color.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            borderRadius: BorderRadius.circular(4),
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        final activities = [
          {'title': 'Penyaluran Sembako', 'time': '2 jam yang lalu', 'desc': '50 paket sembako untuk lansia.'},
          {'title': 'Beasiswa Pendidikan', 'time': '1 hari yang lalu', 'desc': 'Pencairan beasiswa untuk 10 santri.'},
          {'title': 'Bantuan Bencana', 'time': '3 hari yang lalu', 'desc': 'Pengiriman logistik ke lokasi banjir.'},
        ];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.notifications_active, size: 20)),
            title: Text(activities[index]['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(activities[index]['desc']!),
            trailing: Text(activities[index]['time']!, style: const TextStyle(fontSize: 10)),
          ),
        );
      },
    );
  }
}
