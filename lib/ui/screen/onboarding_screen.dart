import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_guinee/ui/screen/accounts/sign_in_screen.dart';
import 'package:safe_guinee/utils/app_text_style.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentPage = 0;
  final List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      title: "Signalez en un clic",
      image: "assets/images/onboarding3.png",
      description:
          "Alertez la communauté et les autorités sur les dangers routiers en temps réel.",
    ),
    OnboardingItem(
      title: "Restez informé",
      image: "assets/images/onboarding4.png",
      description:
          "Recevez des notifications sur les incidents proches de vous : embouteillages, accidents, routes barrées.",
    ),
    OnboardingItem(
      title: "Naviguez en sécurité",
      image: "assets/images/onboarding6.png",
      description:
          "Trouvez les meilleurs itinéraires pour éviter les zones à risque et circuler sereinement.",
    ),
    OnboardingItem(
      title: "Construisons ensemble",
      image: "assets/images/onboarding1.png",
      description:
          "Une Guinée plus sûre commence avec vous. Chaque signalement compte pour améliorer nos routes.",
    ),
  ];

  void _handleGetStarted() {
    Get.off(() => SignInScreen());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingItems.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    onboardingItems[index].image,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    onboardingItems[index].title,
                    textAlign: TextAlign.center,
                    style: AppTextstyles.withColor(
                      AppTextstyles.h3,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      onboardingItems[index].description,
                      textAlign: TextAlign.center,
                      style: AppTextstyles.withColor(
                        AppTextstyles.bodySmall,
                        isDark? Colors.white: Colors.black
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingItems.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 8,
                  width: currentPage == index ? 20 : 8,
                  decoration: BoxDecoration(
                    color:
                        currentPage == index
                            ? Theme.of(context).primaryColor
                            : Colors.grey[700],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => _handleGetStarted(),
                  child: Text(
                    "Skip",
                    style: AppTextstyles.withColor(
                      AppTextstyles.bodyMedium,
                      Colors.grey[600]!,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (currentPage < onboardingItems.length - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _handleGetStarted();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    currentPage < onboardingItems.length - 1
                        ? "Suivant"
                        : "Commencer",
                    style: AppTextstyles.withColor(
                      AppTextstyles.bodyMedium,
                      Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final String title;
  final String image; // chemin de l'asset ou URL
  final String description;

  OnboardingItem({
    required this.title,
    required this.image,
    required this.description,
  });
}
