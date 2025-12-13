import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const SettingsCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: List.generate(children.length, (index) {
          return Column(
            children: [
              children[index],
              if (index != children.length - 1)
                Divider(
                  height: 1,
                  thickness: 0.8,
                  color: Colors.grey.withValues(alpha: 0.5),
                ),
            ],
          );
        }),
      ),
    );
  }
}
