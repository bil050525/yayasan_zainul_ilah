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
  int _currentStep = 1; // 1: Form, 2: Payment, 3: Instructions, 4: Success
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
            if (_currentStep > 1 && _currentStep < 4) {
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
      case 3: return 'Instruksi Bayar';
      case 4: return 'Donasi Berhasil';
      default: return 'Donasi';
    }
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 1: return _buildCheckoutForm();
      case 2: return _buildPaymentMethods();
      case 3: return _buildPaymentInstructions();
      case 4: return _buildFinalStatus();
      default: return const SizedBox();
    }
  }

  // ... (Step 1 & 2 tetap sama) ...

  // --- STEP 3: PAYMENT INSTRUCTIONS (NATIVE UI) ---
  Widget _buildPaymentInstructions() {
    return SingleChildScrollView(
      key: const ValueKey(3),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: AppTheme.premiumShadowDecoration(),
            child: Column(
              children: [
                const Text('Batas Waktu Pembayaran', style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 8),
                const Text('23:59:59', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                const Divider(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedPaymentMethod, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Icon(Icons.account_balance, color: Colors.blue, size: 32),
                  ],
                ),
                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Nomor Virtual Account', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('8800112233445566', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                    TextButton(
                      onPressed: () {
                        Clipboard.setData(const ClipboardData(text: '8800112233445566'));
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nomor VA disalin!')));
                      },
                      child: const Text('SALIN', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const Divider(height: 32),
                _summaryRow('Total Tagihan', 'Rp ${widget.initialAmount?.toInt() ?? 0}', isBold: true),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Cara Pembayaran', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 16),
          _buildInstructionStep('1', 'Buka aplikasi Mobile Banking Anda.'),
          _buildInstructionStep('2', 'Pilih menu "Transfer" lalu pilih "Virtual Account".'),
          _buildInstructionStep('3', 'Masukkan nomor VA di atas.'),
          _buildInstructionStep('4', 'Periksa detail donasi dan konfirmasi pembayaran.'),
        ],
      ),
    );
  }

  Widget _buildInstructionStep(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Text(number, style: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14, color: Colors.black87))),
        ],
      ),
    );
  }

  // --- STEP 4: FINAL STATUS --- (Sama seperti sebelumnya tapi key berubah ke 4)
  Widget _buildFinalStatus() {
    return Center(
      key: const ValueKey(4),
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

  // --- BOTTOM ACTION BUTTON ---
  Widget _buildBottomAction() {
    if (_currentStep == 4) {
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
          } else if (_currentStep == 3) {
            setState(() => _currentStep = 4); // Simulasi: Selesai bayar
          }
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[700], minimumSize: const Size(double.infinity, 55)),
        child: Text(_currentStep == 1 ? 'LANJUT KE PEMBAYARAN' : (_currentStep == 2 ? 'PROSES PEMBAYARAN' : 'SAYA SUDAH TRANSFER')),
      ),
    );
  }
}
