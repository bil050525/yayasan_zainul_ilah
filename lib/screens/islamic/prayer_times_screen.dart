import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateString = DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(now);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Sholat'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.8),
              Theme.of(context).primaryColor.withOpacity(0.4),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            _buildNextPrayerHeader(context),
            const SizedBox(height: 20),
            Text(
              dateString,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: ListView(
                  children: [
                    _prayerRow('Imsak', '04:32', Icons.wb_twilight),
                    _prayerRow('Subuh', '04:42', Icons.wb_sunny_outlined),
                    _prayerRow('Terbit', '05:58', Icons.wb_sunny),
                    _prayerRow('Dzuhur', '11:58', Icons.sunny),
                    _prayerRow('Ashar', '15:18', Icons.cloud_outlined),
                    _prayerRow('Maghrib', '17:54', Icons.nights_stay_outlined),
                    _prayerRow('Isya', '19:05', Icons.nights_stay),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextPrayerHeader(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Mendekati Waktu Dzuhur',
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
        SizedBox(height: 8),
        Text(
          '-01:24:32',
          style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold),
        ),
        Text(
          'Menuju Sholat Berikutnya',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }

  Widget _prayerRow(String name, String time, IconData icon) {
    bool isNext = name == 'Dzuhur';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isNext ? Colors.green[50] : Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
        border: isNext ? Border.all(color: Colors.green[200]!) : null,
      ),
      child: Row(
        children: [
          Icon(icon, color: isNext ? Colors.green : Colors.grey[600]),
          const SizedBox(width: 20),
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
              color: isNext ? Colors.green[800] : Colors.black87,
            ),
          ),
          const Spacer(),
          Text(
            time,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isNext ? Colors.green[800] : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
