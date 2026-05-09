import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String _currentTime = '';
  String _currentDate = '';
  bool _hasClockedIn = false;
  bool _hasClockedOut = false;
  String _clockInTime = '--:--';
  String _clockOutTime = '--:--';

  @override
  void initState() {
    super.initState();
    _updateDateTime();
  }

  void _updateDateTime() {
    setState(() {
      _currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
      _currentDate = DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.now());
    });
    Future.delayed(const Duration(seconds: 1), _updateDateTime);
  }

  void _handleClockIn() {
    setState(() {
      _hasClockedIn = true;
      _clockInTime = DateFormat('HH:mm').format(DateTime.now());
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Absen masuk berhasil!')),
    );
  }

  void _handleClockOut() {
    setState(() {
      _hasClockedOut = true;
      _clockOutTime = DateFormat('HH:mm').format(DateTime.now());
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Absen pulang berhasil!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Absensi Pengurus'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildClockCard(),
            const SizedBox(height: 32),
            _buildAttendanceActions(),
            const SizedBox(height: 32),
            _buildHistorySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildClockCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            _currentTime,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _currentDate,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceActions() {
    return Row(
      children: [
        Expanded(
          child: _actionButton(
            'Masuk',
            _clockInTime,
            Icons.login,
            Colors.green,
            _hasClockedIn ? null : _handleClockIn,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _actionButton(
            'Pulang',
            _clockOutTime,
            Icons.logout,
            Colors.orange,
            (!_hasClockedIn || _hasClockedOut) ? null : _handleClockOut,
          ),
        ),
      ],
    );
  }

  Widget _actionButton(String label, String time, IconData icon, Color color, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: onTap == null ? Colors.grey[100] : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: onTap == null ? Colors.grey[300]! : color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: onTap == null ? Colors.grey : color, size: 32),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: onTap == null ? Colors.grey : Colors.black87)),
            Text(time, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: onTap == null ? Colors.grey : color)),
          ],
        ),
      ),
    );
  }

  Widget _buildHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Riwayat Mingguan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _historyItem('Jumat, 08 Mei', '08:00', '17:00'),
        _historyItem('Kamis, 07 Mei', '07:55', '17:05'),
        _historyItem('Rabu, 06 Mei', '08:10', '17:00'),
      ],
    );
  }

  Widget _historyItem(String date, String cin, String cout) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(date),
        subtitle: Text('Masuk: $cin - Pulang: $cout'),
        trailing: const Icon(Icons.check_circle, color: Colors.green),
      ),
    );
  }
}
