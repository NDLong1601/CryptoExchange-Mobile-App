import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

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
        title: Text('Wallet', style: context.theme.textTheme.bodyLarge),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.fingerprint_rounded),
            color: context.theme.iconTheme.color,
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            'Wallet Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
