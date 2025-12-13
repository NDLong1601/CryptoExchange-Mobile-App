import 'package:cryptoexchange_mobile_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final Widget? trailing;
  final VoidCallback? onTap;

  const AppTile({
    super.key,
    required this.title,
    required this.iconPath,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 24,
              height: 24,
              color: Theme.of(context).iconTheme.color?.withValues(alpha: 0.85),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title, style: Theme.of(context).textTheme.bodyMedium),
            ),
            trailing ??
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Theme.of(context).hintColor,
                ),
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
    final themeProvider = context.watch<ThemeProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            width: 24,
            height: 24,
            color: Theme.of(context).iconTheme.color,
          ),
          const SizedBox(width: 12),

          Text("Theme", style: Theme.of(context).textTheme.bodyMedium),

          const Spacer(),

          Text("Dark mode", style: Theme.of(context).textTheme.bodySmall),

          Switch(
            value: themeProvider.isDarkMode,
            onChanged: (_) => themeProvider.toggleTheme(),
          ),
        ],
      ),
    );
  }
}
