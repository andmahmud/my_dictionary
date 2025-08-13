import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'word_model.dart';

class WordStorageService {
  static const _key = 'words';

  Future<List<Word>> loadWords() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.map((e) => Word.fromMap(jsonDecode(e))).toList();
  }

  Future<void> saveWords(List<Word> words) async {
    final prefs = await SharedPreferences.getInstance();
    final data = words.map((e) => jsonEncode(e.toMap())).toList();
    await prefs.setStringList(_key, data);
  }
}
