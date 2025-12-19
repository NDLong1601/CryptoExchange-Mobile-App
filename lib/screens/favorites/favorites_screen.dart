import 'package:cryptoexchange_mobile_app/components/app_text_header.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:cryptoexchange_mobile_app/screens/favorites/widget/list_favourites.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: context.theme.iconTheme.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text('Favourites', style: context.theme.textTheme.bodyLarge),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              AppAssetsPath.filter,
              color: context.theme.iconTheme.color,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              const AppTextHeader(),
              Divider(
                color: context.theme.dividerColor.withValues(alpha: 0.35),
              ),
              const SizedBox(height: 13),
              ListFavourites(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
