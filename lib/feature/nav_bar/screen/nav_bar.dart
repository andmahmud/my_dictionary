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
          iconTheme: const IconThemeData(
            color: Colors.white,
          ), // Drawer menu icon
        ),
        drawer: CustomDrawer(),
        body: pages[controller.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          items:  [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Word Mate'),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outlined),
              label: 'Bookmarks',
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          backgroundColor: AppColors.secondary,
          onTap: controller.onItemTapped,
        ),
     floatingActionButton: controller.selectedIndex.value == 0
    ? FloatingActionButton(
        onPressed: () => homecontroller.addOrEditWord(),
        backgroundColor: AppColors.textFormFieldBorder,
        shape: CircleBorder(),
        child:  Icon(Icons.add, color: Colors.black, size: 30.sp), // Adjust icon size
      )
    : null,


        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
