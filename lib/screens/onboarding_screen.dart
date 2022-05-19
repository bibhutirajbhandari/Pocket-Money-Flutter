import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocketmoney/components/constraints.dart';
import 'package:pocketmoney/main.dart';
import 'package:pocketmoney/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/pages.dart';
import '../components/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int current_page = 0;

  PageController _pageController = PageController(initialPage: 0);

  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      duration: Duration(milliseconds: 300),
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
        color: current_page == index ? kSecondaryColor : kPrimaryColor,
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

      SizeConfig().init(context);
      double sizeH = SizeConfig.blockSizeH!;


    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: onboard_data.length,
                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() {
                        current_page = value;
                      });
                    },
                    itemBuilder: (context, index) => OnboardContent(
                        image: onboard_data[index].image,
                        title: onboard_data[index].title,
                        description: onboard_data[index].description),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      current_page == onboard_data.length -1 
                      ? 
                       MyTextButton(
                        buttonName: 'Get Started',
                        onPressed: ()
                        {
                          Navigator.push(context,MaterialPageRoute(builder: ((context) => CategoryPage()),);
                        },
                      )
                     : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          NavButton(
                            name: 'Skip',
                            onPressed: () {
                             Navigator.push(context, MaterialPageRoute(builder:((context) => CategoryPage()),
                              );
                            },
                          ),
                          Row(
                            children: List.generate(
                              onboard_data.length,
                              (index) => dotIndicator(index),
                            ),
                          ),
                          NavButton(
                              name: 'Next',
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: Duration(microseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              })
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class onBoard {
  final String image, title, description;

  onBoard(
      {required this.image, required this.title, required this.description});
}

final List<onBoard> onboard_data = [
  onBoard(
      image: 'assets/images/management.svg',
      title: 'Say hi to your new \n budget tracker!',
      description:
          'You\'re amazing for taking this first step towards getting better control over your financial goals'),
  onBoard(
      image: 'assets/images/strategy1.svg',
      title: 'Map your target budget plan',
      description: 'Categorize your budget and get alerts on exceeding limits'),
  onBoard(
      image: 'assets/images/graph.svg',
      title: 'Graphical monitoring of your data',
      description:
          'Visualized represntation of your data to ease your money monitoring'),
  onBoard(
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

  final image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SvgPicture.asset(image, height: 300),
        // const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        SizedBox(height: 6.0),
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
