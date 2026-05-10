import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final _amountController = TextEditingController();
  String _selectedMethod = 'Transfer Bank BSI';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran Donasi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Masukkan Nominal Donasi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
              decoration: InputDecoration(
                prefixText: 'Rp ',
                hintText: '0',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Pilih Metode Pembayaran',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _paymentMethodTile('Transfer Bank BSI', Icons.account_balance),
            _paymentMethodTile('Transfer Bank Mandiri', Icons.account_balance),
            _paymentMethodTile('E-Wallet (GoPay/OVO)', Icons.account_balance_wallet),
            const SizedBox(height: 32),
            _buildBankDetails(),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  if (_amountController.text.isNotEmpty) {
                    _showSuccess();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Silakan masukkan nominal donasi')),
                    );
                  }
                },
                child: const Text('KONFIRMASI PEMBAYARAN', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentMethodTile(String name, IconData icon) {
    return RadioListTile<String>(
      title: Text(name),
      secondary: Icon(icon, color: Theme.of(context).primaryColor),
      value: name,
      groupValue: _selectedMethod,
      contentPadding: EdgeInsets.zero,
      onChanged: (value) {
        setState(() {
          _selectedMethod = value!;
        });
      },
    );
  }

  Widget _buildBankDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green[100]!),
      ),
      child: Column(
        children: [
          const Text('Nomor Rekening Tujuan:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          const Text(
            '7123-456-789',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2, color: Color(0xFF1B5E20)),
          ),
          const Text('a.n. Yayasan Zainul Ilah', style: TextStyle(color: Colors.blueGrey, fontSize: 13)),
          const SizedBox(height: 12),
          const Text(
            '*Silakan transfer sesuai nominal dan simpan bukti transfer Anda.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  void _showSuccess() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        ),
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 24),
            const Text(
              'Donasi Berhasil!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Terima kasih atas kebaikan Anda.\nSemoga menjadi amal jariyah.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),
            _receiptRow('Nominal Donasi', 'Rp ${_amountController.text}'),
            _receiptRow('Metode Pembayaran', _selectedMethod),
            _receiptRow('Status', 'Berhasil'),
            _receiptRow('ID Transaksi', 'TX-99881122'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close bottom sheet
                  Navigator.pop(context); // Back to program list
                },
                child: const Text('KEMBALI KE BERANDA'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _receiptRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}
