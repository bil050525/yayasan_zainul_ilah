import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/theme_provider.dart';
import '../auth/login_screen.dart';
import '../attendance/attendance_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        actions: _isLoggedIn ? [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        ] : null,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildMenuSection(context),
            const SizedBox(height: 24),
            _isLoggedIn ? _buildLogoutButton(context) : _buildLoginButton(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Icon(
              _isLoggedIn ? Icons.person : Icons.person_outline, 
              size: 60, 
              color: const Color(0xFF1B5E20)
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _isLoggedIn ? 'Pengurus Yayasan' : 'Tamu Yayasan',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _isLoggedIn ? 'pengurus@email.com' : 'Selamat datang, silakan masuk',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildMenuItem(
            Icons.dark_mode_outlined, 
            'Mode Gelap', 
            () => themeProvider.toggleTheme(),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) => themeProvider.toggleTheme(),
            ),
          ),
          _buildMenuItem(Icons.history, 'Riwayat Donasi', () {}),
          if (_isLoggedIn) // Hanya muncul jika sudah login
            _buildMenuItem(Icons.calendar_today, 'Absensi Pengurus', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AttendanceScreen()),
              );
            }),
          _buildMenuItem(Icons.notifications_outlined, 'Notifikasi', () {}),
          _buildMenuItem(Icons.help_outline, 'Pusat Bantuan', () {}),
          _buildMenuItem(Icons.info_outline, 'Tentang Aplikasi', () {}),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {Widget? trailing}) {
    return Card(
      margin: const EdgeInsets.all(4),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF1B5E20)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: trailing ?? const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            ).then((_) => _checkLoginStatus());
          },
          icon: const Icon(Icons.login),
          label: const Text('MASUK SEKARANG'),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.remove('isLoggedIn');
            _checkLoginStatus();
          },
          icon: const Icon(Icons.logout, color: Colors.red),
          label: const Text('Keluar Akun', style: TextStyle(color: Colors.red)),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.red),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }
}
