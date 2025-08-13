import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_dictionary/core/utils/constent/app_sizer.dart';

import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.addOrEditWord(),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Row(
                      children: [
                        Checkbox(
                            value: controller.showFavoritesOnly.value,
                            onChanged: (value) {
                              controller.showFavoritesOnly.value = value!;
                              controller.filterWords();
                            }),
                        const Text("Show Favorites Only"),
                      ],
                    )),
                const SizedBox(height: 8),
                Obx(() {
                  if (controller.filteredWords.isEmpty) {
                    return const Center(
                        child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text("No words to display."),
                    ));
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.filteredWords.length,
                    itemBuilder: (context, index) {
                      final word = controller.filteredWords[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        elevation: 4,
                        child: ListTile(
                          title: Text("${word.text} = ${word.bangla}",
                              style: const TextStyle(fontSize: 18)),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'favorite') {
                                controller.toggleFavorite(index);
                              } else if (value == 'edit') {
                                controller.addOrEditWord(
                                    word: word, index: index);
                              } else if (value == 'delete') {
                                controller.deleteWord(index);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: 'favorite',
                                  child: Row(
                                    children: [
                                      Icon(
                                        word.isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: word.isFavorite
                                            ? Colors.red
                                            : null,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(word.isFavorite
                                          ? 'Unfavorite'
                                          : 'Favorite'),
                                    ],
                                  )),
                              const PopupMenuItem(
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit, color: Colors.blue),
                                      SizedBox(width: 8),
                                      Text('Edit'),
                                    ],
                                  )),
                              const PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text('Delete'),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
