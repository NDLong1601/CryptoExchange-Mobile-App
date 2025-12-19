import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class TradingChartScreen extends StatefulWidget {
  const TradingChartScreen({super.key});

  @override
  State<TradingChartScreen> createState() => _TradingChartScreenState();
}

class _TradingChartScreenState extends State<TradingChartScreen> {
  late final TextEditingController _searchCtrl;

  @override
  void initState() {
    super.initState();
    _searchCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

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
        title: Text('Market', style: context.theme.textTheme.bodyLarge),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              AppAssetsPath.filter,
              width: 24,
              height: 24,
              color: context.theme.iconTheme.color,
            ),
          ),
        ],
      ),
    );
  }
}
