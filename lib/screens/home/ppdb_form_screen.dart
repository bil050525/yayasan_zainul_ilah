import 'package:flutter/material.dart';

class PpdbFormScreen extends StatefulWidget {
  const PpdbFormScreen({super.key});

  @override
  State<PpdbFormScreen> createState() => _PpdbFormScreenState();
}

class _PpdbFormScreenState extends State<PpdbFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _parentController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedLevel = 'MI (Madrasah Ibtidaiyah)';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Pendaftaran Terkirim'),
          content: const Text('Terima kasih! Data pendaftaran Anda telah kami terima. Panitia PPDB akan segera menghubungi Anda melalui WhatsApp.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Back to Home
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulir PPDB'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pendaftaran Santri Baru',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Silakan isi formulir di bawah ini dengan data yang benar.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              _buildTextField('Nama Lengkap Calon Santri', _nameController, Icons.person),
              const SizedBox(height: 20),
              _buildDropdownField(),
              const SizedBox(height: 20),
              _buildTextField('Nama Wali / Orang Tua', _parentController, Icons.family_restroom),
              const SizedBox(height: 20),
              _buildTextField('Nomor WhatsApp Aktif', _phoneController, Icons.phone, keyboardType: TextInputType.phone),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('KIRIM PENDAFTARAN', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  '*Pendaftaran ini tidak dipungut biaya (Gratis)',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Bagian ini wajib diisi';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      value: _selectedLevel,
      decoration: InputDecoration(
        labelText: 'Jenjang Pendidikan',
        prefixIcon: const Icon(Icons.school),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      items: ['RA (Raudhatul Athfal)', 'MI (Madrasah Ibtidaiyah)', 'MTs (Madrasah Tsanawiyah)']
          .map((level) => DropdownMenuItem(value: level, child: Text(level)))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedLevel = value!;
        });
      },
    );
  }
}
