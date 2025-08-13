import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_dictionary/core/network_coller/word_controller.dart';
import 'package:my_dictionary/core/network_coller/word_model.dart';
import 'package:my_dictionary/core/utils/common_widget/custom_button.dart';
import 'package:my_dictionary/core/utils/common_widget/custom_text.dart';
import 'package:my_dictionary/core/utils/common_widget/custom_textformfield.dart';
import 'package:my_dictionary/core/utils/constent/app_color.dart';
import 'package:my_dictionary/core/utils/constent/app_sizer.dart';
import 'package:my_dictionary/feature/book_mark/controller/book_mark_controller.dart';

class HomeController extends GetxController {
  var words = <Word>[].obs;
  var filteredWords = <Word>[].obs;
  var showFavoritesOnly = false.obs;
  var searchController = TextEditingController();

  final storageService = WordStorageService();
  final FavoritesController favController = Get.put(
    FavoritesController(),
    permanent: true,
  );

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
        bool matchesSearch =
            word.text.toLowerCase().contains(query) ||
            word.bangla.toLowerCase().contains(query);
        bool matchesFavorites = !showFavoritesOnly.value || word.isFavorite;
        return matchesSearch && matchesFavorites;
      }).toList(),
    );
  }

  void addOrEditWord({Word? word, int? index}) {
    final englishController = TextEditingController(text: word?.text ?? '');
    final banglaController = TextEditingController(text: word?.bangla ?? '');

    Get.dialog(
      AlertDialog(
        title: CustomText(
          textAlign: TextAlign.center,
          text: word == null ? 'Add Word' : 'Edit Word',
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              radius: 15,
              fillColor: AppColors.containerBorder,
              controller: englishController,
              hintText: 'First Word',
            ),
            SizedBox(height: 10),
            CustomTextField(
              radius: 15,
              fillColor: AppColors.containerBorder,
              controller: banglaController,
              hintText: 'Second Word',
            ),
          ],
        ),
        actions: [
          CustomButton(
            onTap: () {
              if (englishController.text.isEmpty ||
                  banglaController.text.isEmpty)
                return;

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
              favController.updateFavorites(words);
              saveWords();
              Get.back();
            },
            color: AppColors.secondary,
            text: "Save",
          ),
        ],
      ),
    );
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
