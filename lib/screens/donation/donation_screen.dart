import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donasi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(context),
            const SizedBox(height: 32),
            const Text(
              'Metode Transfer Bank',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildBankCard(
              context,
              bankName: 'Bank Syariah Indonesia (BSI)',
              accountNumber: '7123456789',
              accountName: 'Yayasan Zainul Ilah',
              logo: Icons.account_balance,
            ),
            const SizedBox(height: 16),
            _buildBankCard(
              context,
              bankName: 'Bank Mandiri',
              accountNumber: '1230009876543',
              accountName: 'Yayasan Zainul Ilah',
              logo: Icons.account_balance,
            ),
            const SizedBox(height: 32),
            const Text(
              'Konfirmasi Donasi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Setelah melakukan transfer, mohon konfirmasi melalui WhatsApp kami untuk pendataan.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.message),
                label: const Text('Konfirmasi via WhatsApp'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline, color: Colors.white, size: 40),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'Setiap rupiah yang Anda donasikan akan sangat berarti bagi mereka yang membutuhkan.',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankCard(
    BuildContext context, {
    required String bankName,
    required String accountNumber,
    required String accountName,
    required IconData logo,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(logo, color: Theme.of(context).primaryColor),
                const SizedBox(width: 12),
                Text(
                  bankName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const Divider(height: 32),
            const Text('Nomor Rekening:', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  accountNumber,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                ),
                IconButton(
                  icon: const Icon(Icons.copy, size: 20),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: accountNumber));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Nomor rekening disalin!')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Atas Nama:', style: TextStyle(color: Colors.grey, fontSize: 12)),
            Text(
              accountName,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
