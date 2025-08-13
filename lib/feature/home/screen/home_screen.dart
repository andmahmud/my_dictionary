import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_dictionary/core/utils/common_widget/custom_text.dart';
import 'package:my_dictionary/core/utils/common_widget/custom_textformfield.dart';
import 'package:my_dictionary/core/utils/constent/app_color.dart';
import 'package:my_dictionary/core/utils/constent/app_sizer.dart';

import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => controller.addOrEditWord(),
      //   child: Icon(Icons.add),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                CustomTextField(
                  controller: controller.searchController,
                  hintText: "Search words",
                  radius: 30,
                  fillColor: AppColors.containerBorder,
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.textSecondary,
                  ),
                ),

                // Obx(
                //   () => Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       CustomText(text: "Show Favorites Only"),
                //       Checkbox(
                //         value: controller.showFavoritesOnly.value,
                //         onChanged: (value) {
                //           controller.showFavoritesOnly.value = value!;
                //           controller.filterWords();
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 8.h),
                Obx(() {
                  if (controller.filteredWords.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: CustomText(text: "No words to display."),
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.filteredWords.length,
                    itemBuilder: (context, index) {
                      final word = controller.filteredWords[index];
                      return 
                      
                      
                      
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 5.h,
                        ), // optional spacing
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ), // inner padding
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ), // border color and width
                          borderRadius: BorderRadius.circular(
                            10,
                          ), // rounded corners
                          color: Colors.white, // optional background color
                        ),
                        child: 
                        
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text
                Expanded(
                  child: CustomText(
                    text: "${word.text} = ${word.bangla}",
                    fontSize: 18.sp,
                  ),
                ),
                // Popup menu
                PopupMenuButton<String>(
                  
                  color: AppColors.primaryBackGround,
                  onSelected: (value) {
                    if (value == 'favorite') {
                      controller.toggleFavorite(index);
                    } else if (value == 'edit') {
                      controller.addOrEditWord(
                        word: word,
                        index: index,
                      );
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
                                ? Icons.bookmark_remove_outlined
                                : Icons.bookmark_add_outlined,
                            color: word.isFavorite ? Colors.red : null,
                          ),
                          const SizedBox(width: 8),
                          CustomText(
                            text: word.isFavorite ? 'Unbookmark' : 'Bookmark',
                          ),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: Colors.blue),
                          SizedBox(width: 8),
                          CustomText(text: 'Edit'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          CustomText(text: 'Delete'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
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
