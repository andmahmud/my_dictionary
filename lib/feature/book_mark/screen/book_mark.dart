import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_dictionary/core/utils/common_widget/custom_text.dart';
import 'package:my_dictionary/core/utils/constent/app_color.dart';
import 'package:my_dictionary/core/utils/constent/app_sizer.dart';
import 'package:my_dictionary/feature/book_mark/controller/book_mark_controller.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final FavoritesController controller = Get.put(
    FavoritesController(),
    permanent: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.favoriteWords.isEmpty) {
            return Center(
              child: CustomText(text: "No favorite words to display."),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Column(
              children:
                  controller.favoriteWords.map((word) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: "${word.text} = ${word.bangla}",
                            ),
                          ),
                          PopupMenuButton<String>(
                            color: AppColors.primaryBackGround,
                            onSelected: (value) {
                              if (value == 'favorite') {
                                controller.toggleFavorite(word);
                              }
                            },
                            itemBuilder:
                                (context) => const [
                                  PopupMenuItem(
                                    value: 'favorite',
                                    child: CustomText(text: 'Unbookmark'),
                                  ),
                                ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          );
        }),
      ),
    );
  }
}
