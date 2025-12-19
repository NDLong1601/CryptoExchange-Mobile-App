import 'package:cryptoexchange_mobile_app/components/app_tab_bar.dart';
import 'package:cryptoexchange_mobile_app/components/app_text_header.dart';
import 'package:cryptoexchange_mobile_app/components/app_textfield.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:cryptoexchange_mobile_app/screens/market/widget/list_market.dart';
import 'package:flutter/material.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  late TextEditingController _searchCtrl;

  final _tabs = const ['All Coin', 'Most Trade', 'Most loses', 'New Coin'];
  int _currentIndex = 0;

  @override
  void initState() {
    _searchCtrl = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Text('Market', style: context.theme.textTheme.bodyLarge),
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                AppTextField(
                  controller: _searchCtrl,
                  hintText: 'Cryptocoin search ',
                  suffix: '',
                  enableMinus: true,
                  isSelected: false,
                ),
                SizedBox(height: 16),
                AppTabBar(
                  tabs: _tabs,
                  currentIndex: _currentIndex,
                  onChanged: (i) => setState(() => _currentIndex = i),
                ),
                SizedBox(height: 16),
                AppTextHeader(),
                Divider(
                  color: context.theme.dividerColor.withValues(alpha: 0.35),
                ),
                ListMarket(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
