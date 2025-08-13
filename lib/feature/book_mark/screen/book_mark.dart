import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_dictionary/feature/book_mark/controller/book_mark_controller.dart';


class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final FavoritesController controller =
      Get.put(FavoritesController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.favoriteWords.isEmpty) {
        return const Center(child: Text("No favorite words to display."));
      }

      return ListView.builder(
        itemCount: controller.favoriteWords.length,
        itemBuilder: (context, index) {
          final word = controller.favoriteWords[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text("${word.text} = ${word.bangla}"),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') {
                    controller.deleteWord(word);
                  } else if (value == 'favorite') {
                    controller.toggleFavorite(word);
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'delete', child: Text('Delete')),
                  PopupMenuItem(value: 'favorite', child: Text('Unfavorite')),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
