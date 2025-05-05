import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show exit;

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  // Replace these with your actual links
  final String appUrl =
      "https://play.google.com/store/apps/details?id=com.example.my_dictionary";
  final String moreAppsUrl =
      "https://play.google.com/store/apps/developer?id=YourDeveloperID";
  final String privacyPolicyUrl = "https://your-privacy-policy-link.com";

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  void _shareApp() {
    Share.share("Check out My Dictionary App: $appUrl");
  }

  void _exitApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Exit App"),
          content: const Text("Are you sure you want to exit the app?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => exit(0),
              child: const Text("Exit", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue, 
            ),
            margin: EdgeInsets.zero, 
            padding: EdgeInsets.zero, 
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/icon.png'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'My Dictionary',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Build your vocabulary!',
                    style: TextStyle(color: Colors.white, fontSize: 14),
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

          _buildDrawerItem(
            icon: Icons.share,
            text: "Share App",
            onTap: _shareApp,
          ),

          const Divider(),

          _buildDrawerItem(
            icon: Icons.exit_to_app,
            text: "Exit",
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
      title: Text(text, style: TextStyle(color: color)),
      onTap: onTap,
    );
  }
}
