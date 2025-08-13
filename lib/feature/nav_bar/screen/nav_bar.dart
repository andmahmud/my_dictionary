import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_dictionary/core/utils/common_widget/custom_text.dart';
import 'package:my_dictionary/core/utils/constent/app_color.dart';
import 'package:my_dictionary/core/utils/constent/app_sizer.dart';
import 'package:my_dictionary/drawer.dart';
import 'package:my_dictionary/feature/book_mark/screen/book_mark.dart';
import 'package:my_dictionary/feature/home/screen/home_screen.dart';
import 'package:my_dictionary/feature/nav_bar/controller/nav_bar_controller.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final NavBarController controller = Get.put(
      NavBarController(),
      permanent: true,
    );

    final List<Widget> pages = [HomeScreen(), FavoritesScreen()];
    final List<String> titles = ["My Dictionary", "Favorite Words"];

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
        ),

        drawer: CustomDrawer(),
        body: pages[controller.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          backgroundColor: AppColors.secondary,
          onTap: controller.onItemTapped,
        ),
      ),
    );
  }
}
