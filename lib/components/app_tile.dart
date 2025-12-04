import 'package:cryptoexchange_mobile_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
import 'package:cryptoexchange_mobile_app/const/app_color.dart';
import 'package:provider/provider.dart';

class AppTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback? onTap;

  const AppTile({
    super.key,
    required this.title,
    required this.iconPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, width: 24, height: 24, color: AppColor.grey),
            const SizedBox(width: 12),
            AppText(text: title, style: AppTextstyle.regularTs16Black),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: AppColor.grey),
          ],
        ),
      ),
    );
  }
}

class AppThemeTile extends StatelessWidget {
  final String iconPath;
  const AppThemeTile({required this.iconPath, super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Image.asset(iconPath, width: 24, height: 24, color: AppColor.grey),
          const SizedBox(width: 12),

          AppText(text: "Theme", style: AppTextstyle.regularTs16Black),
          const Spacer(),

          AppText(text: "Dark mode", style: AppTextstyle.regularTs14Grey),

          Switch(
            value: themeProvider.isDarkMode,
            activeThumbColor: AppColor.primary,
            onChanged: (_) => themeProvider.toggleTheme(),
          ),
        ],
      ),
    );
  }
}
