import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/data_provider.dart';
import '../../models/program_model.dart';

class ManageProgramsScreen extends StatelessWidget {
  const ManageProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final programs = dataProvider.programsList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Program'),
      ),
      body: ListView.builder(
        itemCount: programs.length,
        itemBuilder: (context, index) {
          final program = programs[index];
          return ListTile(
            leading: Icon(program.icon, color: Colors.green),
            title: Text(program.title),
            subtitle: Text(program.category),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => dataProvider.deleteProgram(program.id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProgramDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddProgramDialog(BuildContext context) {
    final titleController = TextEditingController();
    final targetController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Program Baru'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Nama Program')),
            TextField(controller: targetController, decoration: const InputDecoration(labelText: 'Target Dana'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              final newProgram = ProgramModel(
                id: DateTime.now().toString(),
                title: titleController.text,
                description: 'Deskripsi program baru.',
                category: 'Lainnya',
                imageUrl: 'https://picsum.photos/seed/${DateTime.now().millisecond}/600/400',
                targetAmount: double.tryParse(targetController.text) ?? 0,
                collectedAmount: 0,
                icon: Icons.volunteer_activism,
              );
              Provider.of<DataProvider>(context, listen: false).addProgram(newProgram);
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
