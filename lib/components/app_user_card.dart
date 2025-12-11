import 'package:flutter/material.dart';
import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_color.dart';

class AppUserCard extends StatelessWidget {
  final String name;
  final String email;
  final String userId;
  final bool verified;
  final String avatarPath;

  const AppUserCard({
    super.key,
    required this.name,
    required this.email,
    required this.userId,
    required this.avatarPath,
    this.verified = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              avatarPath,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(text: name, style: AppTextstyle.mediumTs16Black),
                const SizedBox(height: 2),
                AppText(text: email, style: AppTextstyle.regularTs14Grey),
                const SizedBox(height: 6),
                AppText(
                  text: "ID $userId",
                  style: AppTextstyle.regularTs12Grey,
                ),
              ],
            ),
          ),

          if (verified)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F5EC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 16,
                    color: AppColor.green,
                  ),
                  const SizedBox(width: 4),
                  AppText(
                    text: "Verified",
                    style: AppTextstyle.mediumTs14Green,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
