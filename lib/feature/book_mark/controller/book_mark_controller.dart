import 'package:get/get.dart';
import 'package:my_dictionary/core/network_coller/word_model.dart';


class FavoritesController extends GetxController {
  var favoriteWords = <Word>[].obs;

  void updateFavorites(List<Word> allWords) {
    // Update favoriteWords based on the allWords list
    favoriteWords.assignAll(allWords.where((w) => w.isFavorite).toList());
  }

  void toggleFavorite(Word word) {
    word.isFavorite = !word.isFavorite;

    if (word.isFavorite) {
      favoriteWords.add(word);
    } else {
      favoriteWords.removeWhere((w) => w.text == word.text);
    }
  }

  void deleteWord(Word word) {
    favoriteWords.removeWhere((w) => w.text == word.text);
  }
}
