import 'package:flutter/material.dart';
import 'package:shop_application/modules/login/login.dart';
import 'package:shop_application/shared/components/components.dart';
import 'package:shop_application/shared/network/local/ccch_helper.dart';
import 'package:shop_application/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var controllerBoard = PageController();
  bool isLast = false;
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, Login());
      }
    });
  }

  List<BoardingModel> bording = [
    BoardingModel(
        image: 'assets/images/onboard.jpg',
        title: 'On Board 1 title',
        body: 'On Board 1 body'),
    BoardingModel(
        image: 'assets/images/onboard.jpg',
        title: 'On Board 2 title',
        body: 'On Board 2 body'),
    BoardingModel(
        image: 'assets/images/onboard.jpg',
        title: 'On Board 3 title',
        body: 'On Board 3 body'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [TextButton(onPressed: submit, child: Text('SKIP'))],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controllerBoard,
                  onPageChanged: (int index) {
                    if (index == bording.length - 1) {
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
                      buildBoardItem(bording[index]),
                  itemCount: bording.length,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: controllerBoard,
                    count: bording.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: defaultColoer,
                      dotColor: Colors.grey,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        controllerBoard.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget buildBoardItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
}
