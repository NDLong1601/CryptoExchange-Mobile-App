import 'package:cryptoexchange_mobile_app/components/app_button.dart';
import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
import 'package:cryptoexchange_mobile_app/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/const/app_color.dart';
import 'package:cryptoexchange_mobile_app/core/enum/enum.dart';
import 'package:cryptoexchange_mobile_app/routes/app_route.dart';
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
              onPressed: () {
                if (_currentPage < 2) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                } else {
                  Navigator.pushReplacementNamed(context, AppRoute.home);
                }
              },
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

  Widget _buildContent() {
    final titles = [
      "Take hold of your\n finances",
      "\nSmart trading tools",
      "\nInvest in the future",
    ];

    final descriptions = [
      "Lorem ipsum dolor sit amet, consectetur\n adipiscing elit. Ut egestas mauris massa pharetra.",
      "Lorem ipsum dolor sit amet, consectetur\n adipiscing elit. Ut egestas mauris massa pharetra.",
      "Lorem ipsum dolor sit amet, consectetur\n adipiscing elit. Ut egestas mauris massa pharetra.",
    ];

    return Column(
      children: [
        AppText(
          text: titles[_currentPage],
          style: AppTextstyle.semiBoldTs32Black,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AppText(
            text: descriptions[_currentPage],
            style: AppTextstyle.regularTs14Black,
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
