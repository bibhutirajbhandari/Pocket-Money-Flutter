import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocketmoney/components/constants.dart';
import 'package:pocketmoney/main.dart';
import 'package:pocketmoney/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/pages.dart';
import '../components/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 5),
      duration: const Duration(milliseconds: 300),
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
        color: currentPage == index ? kSecondaryColor : kPrimaryColor,
        shape: BoxShape.circle,
      ),
    );
  }

  Future setSeenOnBoard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    seenOnBoard = await prefs.setBool("seenOnboard", true);
  }

  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    // double sizeH = SizeConfig.blockSizeH!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: PageView.builder(
                  itemCount: onboardData.length,
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemBuilder: (context, index) => OnboardContent(
                      image: onboardData[index].image,
                      title: onboardData[index].title,
                      description: onboardData[index].description),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    currentPage == onboardData.length - 1
                        ? MyTextButton(
                            bgColor: Colors.blueAccent,
                            buttonName: 'Get Started',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CategoryPage(),
                                ),
                              );
                            },
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              NavButton(
                                name: 'Skip',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CategoryPage(),
                                    ),
                                  );
                                },
                              ),
                              Row(
                                children: List.generate(
                                  onboardData.length,
                                  (index) => dotIndicator(index),
                                ),
                              ),
                              NavButton(
                                name: 'Next',
                                onPressed: () {
                                  _pageController.nextPage(
                                    duration: const Duration(microseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                },
                              )
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnBoard {
  final String image, title, description;

  OnBoard(
      {required this.image, required this.title, required this.description});
}

final List<OnBoard> onboardData = [
  OnBoard(
      image: 'assets/images/management.svg',
      title: 'Say hi to your new \n budget tracker!',
      description:
          'You\'re amazing for taking this first step towards getting better control over your financial goals'),
  OnBoard(
      image: 'assets/images/strategy1.svg',
      title: 'Map your target budget plan',
      description: 'Categorize your budget and get alerts on exceeding limits'),
  OnBoard(
      image: 'assets/images/graph.svg',
      title: 'Graphical monitoring of your data',
      description:
          'Visualized represntation of your data to ease your money monitoring'),
  OnBoard(
      image: 'assets/images/success.svg',
      title: 'Together we\'ll reach your financial goals',
      description:
          'If you fail to plan,you plan to fail. PocketMoney will help you on tracking your spent and reach your goals'),
];

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        SvgPicture.asset(
          image,
          height: SizeConfig.screenHeight! * 0.6,
        ),
        // const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6.0),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        // const Spacer(),
      ],
    );
  }
}
