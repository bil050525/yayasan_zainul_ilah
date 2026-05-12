import 'package:flutter/material.dart';
import '../models/news_model.dart';
import '../models/program_model.dart';

class DataProvider with ChangeNotifier {
  List<NewsModel> _newsList = [...dummyNews];
  List<ProgramModel> _programsList = [...dummyPrograms];

  List<NewsModel> get newsList => _newsList;
  List<ProgramModel> get programsList => _programsList;

  // Manajemen Berita
  void addNews(NewsModel news) {
    _newsList.insert(0, news);
    notifyListeners();
  }

  void updateNews(String id, NewsModel updatedNews) {
    int index = _newsList.indexWhere((n) => n.id == id);
    if (index != -1) {
      _newsList[index] = updatedNews;
      notifyListeners();
    }
  }

  void deleteNews(String id) {
    _newsList.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  // Manajemen Program
  void addProgram(ProgramModel program) {
    _programsList.insert(0, program);
    notifyListeners();
  }

  void updateProgram(String id, ProgramModel updatedProgram) {
    int index = _programsList.indexWhere((p) => p.id == id);
    if (index != -1) {
      _programsList[index] = updatedProgram;
      notifyListeners();
    }
  }

  void deleteProgram(String id) {
    _programsList.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
