import 'package:flutter/material.dart';
import 'package:refactoring_market_app/presentation/screens/login/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../data/models/boarding_model.dart';
import '../../widgets/default_floating_action_button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      title: "Sell Every Thing Easily",
      image: "assets/images/onboarding1.jpg",
      body: "The Easiest way to Buy and Sell Online",
    ),
    BoardingModel(
      title: "Every Thing you need",
      image: "assets/images/onboarding2.jpg",
      body: "All Categories available on our store",
    ),
    BoardingModel(
      title: "working 24 hours",
      image: "assets/images/onboarding3.jpg",
      body: "our support team is available 24 hours",
    ),
  ];

  var boardController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index], context),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.black,
                    dotHeight: 10,
                    expansionFactor: 4,
                    activeDotColor: Colors.cyan,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                ),
                const Spacer(),
                DefaultFloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.decelerate,
                      );
                    }
                  },
                  widget: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model, BuildContext context) => Column(
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            model.title,
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            model.body,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
}
