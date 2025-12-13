import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/core/enum/enum.dart';
import 'package:flutter/material.dart';

class SettingsItem {
  final String title;
  final String iconPath;
  final SettingsItemType type;
  final VoidCallback? onTap;

  SettingsItem({
    required this.title,
    required this.iconPath,
    this.type = SettingsItemType.normal,
    this.onTap,
  });
}

class SettingsSection {
  final String title;
  final List<SettingsItem> items;

  SettingsSection({
    required this.title,
    required this.items,
  });
}

final List<SettingsSection> settingsSections = [
  SettingsSection(
    title: 'Privacy',
    items: [
      SettingsItem(title: 'Profile', iconPath: AppAssetsPath.profile),
      SettingsItem(title: 'Security', iconPath: AppAssetsPath.securityIcon),
    ],
  ),
  SettingsSection(
    title: 'Finance',
    items: [
      SettingsItem(title: 'History', iconPath: AppAssetsPath.history),
      SettingsItem(title: 'Limits', iconPath: AppAssetsPath.limits),
    ],
  ),
  SettingsSection(
    title: 'Account',
    items: [
      SettingsItem(
        title: 'Theme',
        iconPath: AppAssetsPath.themes,
        type: SettingsItemType.themeSwitch,
      ),
      SettingsItem(
        title: 'Notification',
        iconPath: AppAssetsPath.notifications,
      ),
    ],
  ),
  SettingsSection(
    title: 'More',
    items: [
      SettingsItem(title: 'My bonus', iconPath: AppAssetsPath.bonus),
      SettingsItem(title: 'Share with friends', iconPath: AppAssetsPath.add),
      SettingsItem(title: 'Support', iconPath: AppAssetsPath.support),
    ],
  ),
];

