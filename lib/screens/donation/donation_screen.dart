import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/program_model.dart';
import '../../core/app_theme.dart';
import 'package:intl/intl.dart';

class DonationScreen extends StatefulWidget {
  final ProgramModel? program;
  final double? initialAmount;

  const DonationScreen({super.key, this.program, this.initialAmount});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  int _currentStep = 1; // 1: Form, 2: Payment Method, 3: Success/Instructions
  bool _isAnonymous = false;
  String _selectedPaymentMethod = '';
  final _nameController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_currentStep > 1 && _currentStep < 3) {
              setState(() => _currentStep--);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _buildCurrentStep(),
      ),
      bottomNavigationBar: _buildBottomAction(),
    );
  }

  String _getAppBarTitle() {
    switch (_currentStep) {
      case 1: return 'Konfirmasi Donasi';
      case 2: return 'Metode Pembayaran';
      case 3: return 'Instruksi Pembayaran';
      default: return 'Donasi';
    }
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 1: return _buildCheckoutForm();
      case 2: return _buildPaymentMethods();
      case 3: return _buildFinalStatus();
      default: return const SizedBox();
    }
  }

  // --- STEP 1: CHECKOUT FORM ---
  Widget _buildCheckoutForm() {
    return SingleChildScrollView(
      key: const ValueKey(1),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProgramSummary(),
          const SizedBox(height: 32),
          const Text('Data Diri Donatur', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildTextField('Nama Lengkap', _nameController, Icons.person_outline),
          const SizedBox(height: 16),
          _buildTextField('Email / WhatsApp', _whatsappController, Icons.contact_mail_outlined),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Sembunyikan nama saya (Hamba Allah)', style: TextStyle(fontSize: 13)),
              Switch(
                value: _isAnonymous,
                onChanged: (v) => setState(() => _isAnonymous = v),
                activeColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildTextField('Pesan / Doa (Opsional)', _messageController, Icons.chat_bubble_outline, maxLines: 3),
        ],
      ),
    );
  }

  Widget _buildProgramSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.premiumShadowDecoration(),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(widget.program?.imageUrl ?? '', width: 80, height: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.program?.title ?? 'Program Kebaikan', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  'Nominal: Rp ${widget.initialAmount?.toInt() ?? 0}',
                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  // --- STEP 2: PAYMENT METHODS ---
  Widget _buildPaymentMethods() {
    return SingleChildScrollView(
      key: const ValueKey(2),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('E-Wallet'),
          _paymentTile('GoPay', 'assets/icons/gopay.png', Icons.account_balance_wallet),
          _paymentTile('OVO', 'assets/icons/ovo.png', Icons.account_balance_wallet),
          _paymentTile('Dana', 'assets/icons/dana.png', Icons.account_balance_wallet),
          const SizedBox(height: 24),
          _buildSectionTitle('Virtual Account Bank'),
          _paymentTile('BSI Virtual Account', '', Icons.account_balance),
          _paymentTile('BCA Virtual Account', '', Icons.account_balance),
          _paymentTile('Mandiri Virtual Account', '', Icons.account_balance),
          const SizedBox(height: 24),
          _buildSectionTitle('Lainnya'),
          _paymentTile('QRIS (Modern & Cepat)', '', Icons.qr_code_scanner),
          const SizedBox(height: 32),
          _buildCostSummary(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }

  Widget _paymentTile(String name, String asset, IconData icon) {
    bool isSelected = _selectedPaymentMethod == name;
    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentMethod = name),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? Theme.of(context).primaryColor : Colors.transparent, width: 2),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Theme.of(context).primaryColor : Colors.grey),
            const SizedBox(width: 16),
            Text(name, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            const Spacer(),
            if (isSelected) Icon(Icons.check_circle, color: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildCostSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.blueGrey[50], borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          _summaryRow('Donasi', 'Rp ${widget.initialAmount?.toInt() ?? 0}'),
          const SizedBox(height: 8),
          _summaryRow('Biaya Admin', 'Gratis', isGreen: true),
          const Divider(height: 24),
          _summaryRow('Total Pembayaran', 'Rp ${widget.initialAmount?.toInt() ?? 0}', isBold: true),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isGreen = false, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        Text(value, style: TextStyle(
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: isGreen ? Colors.green : (isBold ? Colors.black : Colors.black87),
          fontSize: isBold ? 16 : 13,
        )),
      ],
    );
  }

  // --- STEP 3: FINAL STATUS / INSTRUCTIONS ---
  Widget _buildFinalStatus() {
    return Center(
      key: const ValueKey(3),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 24),
            const Text('Pembayaran Berhasil!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Terima kasih, donasi Anda telah kami terima.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
            _buildReceiptCard(),
            const SizedBox(height: 40),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.share),
              label: const Text('BAGIKAN BUKTI KEBAIKAN'),
              style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.premiumShadowDecoration(),
      child: Column(
        children: [
          _receiptRow('ID Transaksi', 'ZIL-99228811'),
          _receiptRow('Tanggal', DateFormat('dd MMM yyyy, HH:mm').format(DateTime.now())),
          _receiptRow('Program', widget.program?.title ?? ''),
          _receiptRow('Donatur', _isAnonymous ? 'Hamba Allah' : _nameController.text),
          const Divider(height: 32),
          _receiptRow('Total', 'Rp ${widget.initialAmount?.toInt() ?? 0}', isBold: true),
        ],
      ),
    );
  }

  Widget _receiptRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w500, fontSize: 13)),
        ],
      ),
    );
  }

  // --- BOTTOM ACTION BUTTON ---
  Widget _buildBottomAction() {
    if (_currentStep == 3) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('KEMBALI KE BERANDA'),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: ElevatedButton(
        onPressed: () {
          if (_currentStep == 1) {
            if (_nameController.text.isNotEmpty && _whatsappController.text.isNotEmpty) {
              setState(() => _currentStep = 2);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mohon lengkapi data diri Anda')));
            }
          } else if (_currentStep == 2) {
            if (_selectedPaymentMethod.isNotEmpty) {
              setState(() => _currentStep = 3);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Silakan pilih metode pembayaran')));
            }
          }
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[700], minimumSize: const Size(double.infinity, 55)),
        child: Text(_currentStep == 1 ? 'LANJUT KE PEMBAYARAN' : 'BAYAR SEKARANG'),
      ),
    );
  }
}
