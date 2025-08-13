import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_dictionary/core/utils/common_widget/custom_button.dart';
import 'package:my_dictionary/core/utils/common_widget/custom_text.dart';
import 'package:my_dictionary/core/utils/constent/app_color.dart';
import 'package:my_dictionary/core/utils/constent/app_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  final String appUrl =
      "https://play.google.com/store/apps/dev?id=6248440650607625083";
  final String moreAppsUrl =
      "https://play.google.com/store/apps/dev?id=6248440650607625083";
  final String privacyPolicyUrl =
      "https://play.google.com/store/apps/dev?id=6248440650607625083";

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  void _exitApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryBackGround,
          title: CustomText(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
            text: "Exit App",
          ),
          content: CustomText(
            fontSize: 12.sp,
            text: "Are you sure you want to exit the app?",
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onTap: () => Navigator.of(context).pop(),
                    text: "Cancel",
                    color: AppColors.secondary,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: CustomButton(
                    onTap: () => exit(0),
                    text: "Exit",

                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryBackGround,
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.secondary),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/app_logo.png'),
                  ),
                  SizedBox(height: 10.h),
                  CustomText(
                    text: 'Word Mate',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: 'My Personal Dictionary',
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),

          _buildDrawerItem(
            icon: Icons.home,
            text: "Home",
            onTap: () => Navigator.pop(context),
          ),

          const Divider(),

          _buildDrawerItem(
            icon: Icons.privacy_tip,
            text: "Privacy Policy",
            onTap: () => _launchURL(privacyPolicyUrl),
          ),

          _buildDrawerItem(
            icon: Icons.star_rate,
            text: "Rate Us",
            onTap: () => _launchURL(appUrl),
          ),

          _buildDrawerItem(
            icon: Icons.apps,
            text: "More Apps",
            onTap: () => _launchURL(moreAppsUrl),
          ),

          const Divider(),

          _buildDrawerItem(
            icon: Icons.exit_to_app,
            text: "Exit App",
            onTap: () => _exitApp(context),
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: CustomText(
        text: text,
        color: color,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      onTap: onTap,
    );
  }
}
