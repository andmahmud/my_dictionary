import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_dictionary/core/utils/common_widget/custom_text.dart';
import 'package:my_dictionary/core/utils/constent/app_color.dart';
import 'package:my_dictionary/core/utils/constent/app_sizer.dart';
import 'package:my_dictionary/drawer.dart';
import 'package:my_dictionary/feature/book_mark/screen/book_mark.dart';
import 'package:my_dictionary/feature/home/controller/home_controller.dart';
import 'package:my_dictionary/feature/home/screen/home_screen.dart';
import 'package:my_dictionary/feature/nav_bar/controller/nav_bar_controller.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  final homecontroller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final NavBarController controller = Get.put(
      NavBarController(),
      permanent: true,
    );

    final List<Widget> pages = [HomeScreen(), FavoritesScreen()];
    final List<String> titles = ["Word Mate", "Bookmarks Words"];

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: CustomText(
            text: titles[controller.selectedIndex.value],
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: CustomDrawer(),
        body: pages[controller.selectedIndex.value],
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          color: AppColors.secondary,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Home button
                GestureDetector(
                  onTap: () => controller.onItemTapped(0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.home,
                        color:
                            controller.selectedIndex.value == 0
                                ? Colors.white
                                : Colors.black,
                      ),
                      CustomText(
                        text: 'Word Mate',

                        color:
                            controller.selectedIndex.value == 0
                                ? Colors.white
                                : Colors.black,
                        fontSize: 12.sp,
                      ),
                    ],
                  ),
                ),
                // Bookmark button
                GestureDetector(
                  onTap: () => controller.onItemTapped(1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.bookmark_outlined,
                        color:
                            controller.selectedIndex.value == 1
                                ? Colors.white
                                : Colors.black,
                      ),
                      CustomText(
                        text: 'Bookmarks',
                        color:
                            controller.selectedIndex.value == 1
                                ? Colors.white
                                : Colors.black,
                        fontSize: 12.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => homecontroller.addOrEditWord(),
          backgroundColor: AppColors.textFormFieldBorder,
          shape: const CircleBorder(),
          child: Icon(Icons.add, color: Colors.black, size: 30.sp),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
