import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/data_provider.dart';
import '../../models/news_model.dart';

class ManageNewsScreen extends StatelessWidget {
  const ManageNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<DataProvider>(context);
    final newsList = newsProvider.newsList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Berita'),
      ),
      body: ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final news = newsList[index];
          return ListTile(
            leading: Image.network(news.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
            title: Text(news.title),
            subtitle: Text(news.date),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => newsProvider.deleteNews(news.id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNewsDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddNewsDialog(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Berita Baru'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Judul')),
            TextField(controller: contentController, decoration: const InputDecoration(labelText: 'Konten'), maxLines: 3),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              final newNews = NewsModel(
                id: DateTime.now().toString(),
                title: titleController.text,
                content: contentController.text,
                author: 'Admin',
                date: 'Hari ini',
                imageUrl: 'https://picsum.photos/seed/${DateTime.now().millisecond}/600/400',
              );
              Provider.of<DataProvider>(context, listen: false).addNews(newNews);
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
