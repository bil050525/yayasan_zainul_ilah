import 'package:flutter/material.dart';
import 'student_grades_screen.dart';
import '../../core/app_theme.dart';

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({super.key});

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildMainHome(context),
          _buildChatPlaceholder(),
          _buildProfilePlaceholder(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF1B5E20),
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Pesan'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }

  Widget _buildMainHome(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDailyStatus(context),
                const SizedBox(height: 32),
                const Text('Navigasi Akademik', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildAcademicMenu(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatPlaceholder() {
    return const Center(child: Text('Halaman Pesan dengan Wali Kelas'));
  }

  Widget _buildProfilePlaceholder() {
    return const Center(child: Text('Pengaturan Profil Orang Tua'));
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 180,
          padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
          decoration: const BoxDecoration(
            color: Color(0xFF1B5E20),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Selamat Datang,', style: TextStyle(color: Colors.white70, fontSize: 14)),
              Text('Bapak/Ibu Ahmad', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Positioned(
          bottom: -60,
          left: 24,
          right: 24,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: AppTheme.premiumShadowDecoration(),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xFFE8F5E9),
                  child: Icon(Icons.person, size: 35, color: Color(0xFF1B5E20)),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ahmad Zaidan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('Kelas 4A - Madrasah Ibtidaiyah', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('NIS: 202400105', style: TextStyle(color: Colors.grey, fontSize: 11)),
                    ],
                  ),
                ),
                Icon(Icons.qr_code, color: Colors.grey[400]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDailyStatus(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Kehadiran Hari Ini', style: TextStyle(fontWeight: FontWeight.w500)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('HADIR', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 11)),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            children: [
              Icon(Icons.schedule, size: 18, color: Colors.amber[800]),
              const SizedBox(width: 8),
              const Text('Jadwal Terdekat:', style: TextStyle(fontSize: 13, color: Colors.grey)),
              const Spacer(),
              const Text('08:00 - 09:30: Matematika', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAcademicMenu(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: [
        _menuItem(context, Icons.assessment, 'Rapor & Nilai', Colors.blue, () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentGradesScreen()));
        }),
        _menuItem(context, Icons.calendar_month, 'Jadwal Pelajaran', Colors.orange, () {}),
        _menuItem(context, Icons.payments, 'Tagihan & SPP', Colors.green, () {}),
        _menuItem(context, Icons.campaign, 'Pengumuman Kelas', Colors.purple, () {}),
      ],
    );
  }

  Widget _menuItem(BuildContext context, IconData icon, String title, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: AppTheme.premiumShadowDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
