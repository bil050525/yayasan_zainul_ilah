import 'package:flutter/material.dart';

class IslamicContentScreen extends StatelessWidget {
  const IslamicContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        app_bar: AppBar(
          title: const Text('Kajian & Doa'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Doa Harian', icon: Icon(Icons.menu_book)),
              Tab(text: 'Kajian Yayasan', icon: Icon(Icons.video_library)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildDoaList(),
            _buildKajianList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDoaList() {
    final doas = [
      {'title': 'Doa Sebelum Belajar', 'arabic': 'رَبِّ زِدْنِي عِلْمًا وَارْزُقْنِي فَهْمًا', 'latin': 'Rabbi zidnii \'ilman warzuqnii fahman'},
      {'title': 'Doa Untuk Orang Tua', 'arabic': 'رَبِّ اغْفِرْ لِي وَلِوَالِدَيَّ', 'latin': 'Rabbighfir lii waliwaalidayya'},
      {'title': 'Doa Kebaikan Dunia Akhirat', 'arabic': 'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً', 'latin': 'Rabbanaa aatinaa fiddunyaa hasanah'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: doas.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ExpansionTile(
            title: Text(doas[index]['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      doas[index]['arabic']!,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      doas[index]['latin']!,
                      style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildKajianList() {
    final kajian = [
      {'title': 'Membangun Karakter Santri', 'speaker': 'Ust. Zainul Ilah', 'date': 'Jumat, 08 Mei'},
      {'title': 'Keutamaan Sedekah Jariyah', 'speaker': 'Ust. Ahmad Fauzi', 'date': 'Senin, 04 Mei'},
      {'title': 'Pentingnya Adab Sebelum Ilmu', 'speaker': 'Wali Kelas 4A', 'date': 'Rabu, 29 April'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: kajian.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                width: double.infinity,
                color: Colors.green[100],
                child: const Icon(Icons.play_circle_filled, size: 50, color: Colors.green),
              ),
              ListTile(
                title: Text(kajian[index]['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${kajian[index]['speaker']} • ${kajian[index]['date']}'),
                trailing: const Icon(Icons.share, size: 20),
              ),
            ],
          ),
        );
      },
    );
  }
}
