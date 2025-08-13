import 'package:get/get.dart';
import 'package:my_dictionary/core/network_coller/word_controller.dart';
import 'package:my_dictionary/core/network_coller/word_model.dart';

class NavBarController extends GetxController {
  var selectedIndex = 0.obs;
  var favoriteWords = <Word>[].obs;

  final storageService = WordStorageService();

  @override
  void onInit() {
    super.onInit();
    loadFavoriteWords();
  }

  Future<void> loadFavoriteWords() async {
    final allWords = await storageService.loadWords();
    favoriteWords.value = allWords.where((word) => word.isFavorite).toList();
  }

  void onItemTapped(int index) async {
    if (index == 1) {
      await loadFavoriteWords();
    }
    selectedIndex.value = index;
  }
}
