import 'package:flutter/material.dart';

class StudentGradesScreen extends StatelessWidget {
  const StudentGradesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rapor Digital'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStudentSummary(),
            const SizedBox(height: 24),
            const Text(
              'Nilai Pengetahuan & Keterampilan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildGradesTable(),
            const SizedBox(height: 32),
            _buildTeacherNotes(),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          Icon(Icons.assignment_ind, color: Colors.blue, size: 32),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tahun Ajaran: 2023/2024', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Semester: Ganjil', style: TextStyle(color: Colors.blueGrey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGradesTable() {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Table(
        border: TableBorder.all(color: Colors.grey[200]!),
        columnWidths: const {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
        },
        children: [
          _tableHeader(),
          _gradeRow('Al-Qur\'an Hadits', '85', 'A'),
          _gradeRow('Akidah Akhlak', '90', 'A'),
          _gradeRow('Fikih', '88', 'A'),
          _gradeRow('B. Arab', '82', 'B'),
          _gradeRow('Matematika', '78', 'B'),
          _gradeRow('IPA', '85', 'A'),
        ],
      ),
    );
  }

  TableRow _tableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey[100]),
      children: const [
        Padding(
          padding: EdgeInsets.all(12),
          child: Text('Mata Pelajaran', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Text('Nilai', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Text('Predikat', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        ),
      ],
    );
  }

  TableRow _gradeRow(String subject, String score, String grade) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(subject),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(score, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(grade, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: grade == 'A' ? Colors.green : Colors.orange)),
        ),
      ],
    );
  }

  Widget _buildTeacherNotes() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber[100]!),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Catatan Wali Kelas:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(
            'Ahmad menunjukkan perkembangan yang sangat baik dalam hafalan juz 30. Tingkatkan terus kedisiplinan dalam mengumpulkan tugas matematika.',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.brown),
          ),
        ],
      ),
    );
  }
}
