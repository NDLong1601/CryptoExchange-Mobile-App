import 'package:cryptoexchange_mobile_app/components/app_tab_bar.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:cryptoexchange_mobile_app/screens/trade/widget/trade_realtime_header.dart';
import 'package:flutter/material.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  int _tabIndex = 0;

  final _tabs = const ['Spot', 'Margin', 'Grid', 'Fiat'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: context.theme.iconTheme.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Trade', style: context.theme.textTheme.bodyLarge),
        actions: const [Icon(Icons.favorite_outline), SizedBox(width: 12)],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              AppTabBar(
                tabs: _tabs,
                currentIndex: _tabIndex,
                onChanged: (i) => setState(() => _tabIndex = i),
              ),
              TradeRealtimeHeader(),
            ],
          ),
        ),
      ),
    );
  }
}
