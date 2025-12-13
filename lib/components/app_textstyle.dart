import 'package:flutter/material.dart';

class AppTextstyle {
  static const String _font = 'Readex Pro';

  /// ===== SEMIBOLD =====
  static TextStyle semiBold32(BuildContext context) => Theme.of(context)
      .textTheme
      .bodyLarge!
      .copyWith(fontFamily: _font, fontSize: 32, fontWeight: FontWeight.w600);

  static TextStyle semiBold18(BuildContext context) => Theme.of(context)
      .textTheme
      .bodyLarge!
      .copyWith(fontFamily: _font, fontSize: 18, fontWeight: FontWeight.w600);

  /// ===== MEDIUM =====
  // Size 16
  static TextStyle medium16(BuildContext context) => Theme.of(context)
      .textTheme
      .bodyMedium!
      .copyWith(fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w500);

  static TextStyle medium16Primary(BuildContext context) =>
      medium16(context).copyWith(color: Theme.of(context).colorScheme.primary);

  static TextStyle medium16Green(BuildContext context) =>
      medium16(context).copyWith(color: Theme.of(context).colorScheme.tertiary);

  // Size 18
  static TextStyle medium18(BuildContext context) => Theme.of(context)
      .textTheme
      .bodyMedium!
      .copyWith(fontFamily: _font, fontSize: 18, fontWeight: FontWeight.w500);

  static TextStyle medium18Primary(BuildContext context) =>
      medium16(context).copyWith(color: Theme.of(context).colorScheme.primary);

  /// ===== REGULAR =====
  // Size 14
  static TextStyle regular14(BuildContext context) => Theme.of(context)
      .textTheme
      .bodySmall!
      .copyWith(fontFamily: _font, fontSize: 14, fontWeight: FontWeight.w400);

  static TextStyle regular14Grey(BuildContext context) =>
      regular14(context).copyWith(color: Theme.of(context).hintColor);

  static TextStyle regular14Green(BuildContext context) =>
      regular14(context).copyWith(color: Colors.green);
  static TextStyle regular14Black(BuildContext context) =>
      regular14(context).copyWith(color: Colors.black);

  // Size 12
  static TextStyle regular12(BuildContext context) => Theme.of(context)
      .textTheme
      .bodySmall!
      .copyWith(fontFamily: _font, fontSize: 12, fontWeight: FontWeight.w400);

  static TextStyle regular12Grey(BuildContext context) =>
      regular14(context).copyWith(color: Theme.of(context).hintColor);

  static TextStyle regular12Green(BuildContext context) =>
      regular14(context).copyWith(color: Colors.green);

  // Size 16
  static TextStyle regular16(BuildContext context) => Theme.of(context)
      .textTheme
      .bodySmall!
      .copyWith(fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w400);

  static TextStyle regular16Grey(BuildContext context) =>
      regular14(context).copyWith(color: Theme.of(context).hintColor);

  static TextStyle regular16Green(BuildContext context) =>
      regular14(context).copyWith(color: Colors.green);
}
