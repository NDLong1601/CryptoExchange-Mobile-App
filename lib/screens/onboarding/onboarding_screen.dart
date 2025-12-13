import 'package:cryptoexchange_mobile_app/components/app_button.dart';
import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_color.dart';
import 'package:cryptoexchange_mobile_app/core/enum/enum.dart';
import 'package:cryptoexchange_mobile_app/routes/app_route.dart';
import 'package:cryptoexchange_mobile_app/services/storage_service.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    final completed = await StorageService.instance.isOnboardingCompleted();
    if (!mounted) return;
    if (completed) {
      Navigator.pushReplacementNamed(context, AppRoute.home);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onNextPressed() async {
    final lastPageIndex = _titles.length - 1;

    if (_currentPage < lastPageIndex) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // await _storageService.setOnboardingCompleted(true);
      if (!mounted) return;

      Navigator.pushReplacementNamed(context, AppRoute.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * (6 / 812),
                bottom: screenHeight * (18 / 812),
              ),
              child: Center(child: Image.asset(AppAssetsPath.coinmoney)),
            ),
            SizedBox(
              height: 372 / 812 * screenHeight,
              child: PageView.builder(
                controller: _pageController,
                itemCount: AppAssetsPath().onboardingImages.length,
                onPageChanged: (int page) {
                  setState(() => _currentPage = page);
                },
                itemBuilder: (context, index) {
                  return Center(
                    child: Image.asset(
                      AppAssetsPath().onboardingImages[index],
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: screenHeight * (34 / 812)),
            _buildContent(),
            AppButton(
              text: 'Next',
              type: AppButtonType.primary,
              onPressed: _onNextPressed,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isActive = _currentPage == index;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? AppColor.primary : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }

  final _titles = [
    "Take hold of your\n finances",
    "\nSmart trading tools",
    "\nInvest in the future",
  ];

  final _descriptions = [
    "Lorem ipsum dolor sit amet, consectetur\n adipiscing elit. Ut egestas mauris massa pharetra.",
    "Lorem ipsum dolor sit amet, consectetur\n adipiscing elit. Ut egestas mauris massa pharetra.",
    "Lorem ipsum dolor sit amet, consectetur\n adipiscing elit. Ut egestas mauris massa pharetra.",
  ];

  Widget _buildContent() {
    return Column(
      children: [
        AppText(
          text: _titles[_currentPage],
          style: AppTextstyle.semiBold32(context),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AppText(
            text: _descriptions[_currentPage],
            style: AppTextstyle.regular14(context),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
        const SizedBox(height: 20),
        _buildIndicator(),
        const SizedBox(height: 24),
      ],
    );
  }
}
