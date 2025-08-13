import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_dictionary/core/network_coller/word_controller.dart';
import 'package:my_dictionary/core/network_coller/word_model.dart';
import 'package:my_dictionary/feature/book_mark/controller/book_mark_controller.dart';

class HomeController extends GetxController {
  var words = <Word>[].obs;
  var filteredWords = <Word>[].obs;
  var showFavoritesOnly = false.obs;
  var searchController = TextEditingController();

  final storageService = WordStorageService();
  final FavoritesController favController =
      Get.put(FavoritesController(), permanent: true);

  @override
  void onInit() {
    super.onInit();
    loadWords();
    searchController.addListener(filterWords);
  }

  Future<void> loadWords() async {
    final loaded = await storageService.loadWords();
    words.assignAll(loaded);
    filteredWords.assignAll(loaded);
    // Update favorites after loading words
    favController.updateFavorites(words);
  }

  Future<void> saveWords() async {
    await storageService.saveWords(words);
  }

  void filterWords() {
    String query = searchController.text.toLowerCase();
    filteredWords.assignAll(
      words.where((word) {
        bool matchesSearch = word.text.toLowerCase().contains(query) ||
            word.bangla.toLowerCase().contains(query);
        bool matchesFavorites = !showFavoritesOnly.value || word.isFavorite;
        return matchesSearch && matchesFavorites;
      }).toList(),
    );
  }

  void addOrEditWord({Word? word, int? index}) {
    final englishController = TextEditingController(text: word?.text ?? '');
    final banglaController = TextEditingController(text: word?.bangla ?? '');

    Get.dialog(AlertDialog(
      title: Text(word == null ? 'Add Word' : 'Edit Word'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: englishController,
            decoration: const InputDecoration(labelText: 'First Word'),
          ),
          TextField(
            controller: banglaController,
            decoration: const InputDecoration(labelText: 'Second Word'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (englishController.text.isEmpty ||
                banglaController.text.isEmpty) return;

            if (word == null) {
              final newWord = Word(
                text: englishController.text,
                bangla: banglaController.text,
              );
              words.add(newWord);
            } else {
              words[index!] = Word(
                text: englishController.text,
                bangla: banglaController.text,
                isFavorite: word.isFavorite,
              );
            }
            filterWords();
            favController.updateFavorites(words); // update favorites
            saveWords();
            Get.back();
          },
          child: const Text('Save'),
        ),
      ],
    ));
  }

  void toggleFavorite(int index) {
    Word word = words[index];
    word.isFavorite = !word.isFavorite;

    // Notify favorites controller
    favController.updateFavorites(words);

    filterWords();
    saveWords();
  }

  void deleteWord(int index) {

    words.removeAt(index);

    // Notify favorites controller
    favController.updateFavorites(words);

    filterWords();
    saveWords();
  }
}
