import 'package:cryptoexchange_mobile_app/components/app_button.dart';
import 'package:cryptoexchange_mobile_app/components/app_section.dart';
import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
import 'package:cryptoexchange_mobile_app/components/app_tile.dart';
import 'package:cryptoexchange_mobile_app/components/app_user_card.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_color.dart';
import 'package:cryptoexchange_mobile_app/core/enum/enum.dart';

// import 'package:cryptoexchange_mobile_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppBar(
        backgroundColor: AppColor.bg,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: AppText(text: "Settings", style: AppTextstyle.mediumTs18Black),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          AppUserCard(
            name: "Dmutro",
            email: "to***@gmail.com",
            userId: "28954761",
            avatarPath: AppAssetsPath.avatar,
          ),
          SizedBox(height: 16 / 912 * screenHeight),

          // Privacy
          AppSectionHeader(title: 'Privacy'),
          AppTile(title: 'Profile', iconPath: AppAssetsPath.profile),
          AppTile(title: 'Security', iconPath: AppAssetsPath.securityic),

          // Finance
          AppSectionHeader(title: 'Finance'),
          AppTile(title: 'History', iconPath: AppAssetsPath.history),
          AppTile(title: 'Limits', iconPath: AppAssetsPath.limits),

          // Account
          AppSectionHeader(title: 'Account'),
          AppThemeTile(iconPath: AppAssetsPath.themes),
          AppTile(title: 'Notification', iconPath: AppAssetsPath.notifications),

          // More
          AppSectionHeader(title: 'More'),
          AppTile(title: 'My bonus', iconPath: AppAssetsPath.bonus),
          AppTile(title: 'Share with friends', iconPath: AppAssetsPath.add),
          AppTile(title: 'Support', iconPath: AppAssetsPath.support),

          // Button
          SizedBox(height: 24),
          AppButton(
            text: "Log Out",
            type: AppButtonType.secondary,
            onPressed: () {},
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
