import 'package:cryptoexchange_mobile_app/components/app_button.dart';
import 'package:cryptoexchange_mobile_app/components/app_listview_item.dart';
import 'package:cryptoexchange_mobile_app/components/app_section.dart';
import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
import 'package:cryptoexchange_mobile_app/components/app_tile.dart';
import 'package:cryptoexchange_mobile_app/components/app_user_card.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/core/enum/enum.dart';
import 'package:cryptoexchange_mobile_app/screens/setting/widget/setting_card_widget.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final String email = 'dmutro@gmail.com';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: AppText(text: "Settings", style: AppTextstyle.medium16(context)),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
            onPressed: () {},
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          AppUserCard(
            name: "Dmutro",

            /// masked email
            /// TODO: implement email masking function -> later can use it globally
            email: "to***@gmail.com",
            userId: "28954761",
            avatarPath: AppAssetsPath.avatar,
          ),

          const SizedBox(height: 16),

          ...settingsSections.map((section) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSectionHeader(title: section.title),
                SettingsCard(
                  children: section.items.map((item) {
                    switch (item.type) {
                      case SettingsItemType.themeSwitch:
                        return AppThemeTile(iconPath: item.iconPath);

                      case SettingsItemType.normal:
                        return AppTile(
                          title: item.title,
                          iconPath: item.iconPath,
                          onTap: item.onTap,
                        );
                    }
                  }).toList(),
                ),
              ],
            );
          }),

          const SizedBox(height: 24),

          AppButton(
            text: 'Log Out',
            type: AppButtonType.secondary,
            onPressed: () {},
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
