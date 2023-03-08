import 'package:flutter/material.dart';
import 'package:shop_app/modules/LoginScreen/LoginScreen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/widgets.dart';

import '../../shared/comppoents/Componets.dart';

class BoardingModel {
  final String image;
  final String tittle;
  final String body;

  BoardingModel({
    required this.image,
    required this.tittle,
    required this.body
});
}

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var Boardcontroller = PageController();
  bool Lastpage= false;

  void onSubmit(){

    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        NavigateAndfinish(context, LoginScreen());
        print('done');
      }
    });
  }

  List<BoardingModel> boarding = [
  BoardingModel(image: 'assets/images/onboarding.jpg',
      tittle: 'Tittle 1 ',
      body: 'body 1'),
    BoardingModel(image: 'assets/images/onboarding.jpg',
        tittle: 'Tittle 2 ',
        body: 'body 2'),
    BoardingModel(image: 'assets/images/onboarding.jpg',
        tittle: 'Tittle 3 ',
        body: 'body 3')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            onSubmit();
          },
              child: Text('SKIP'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(child: PageView.builder(itemBuilder: (context, index) =>
                OnBoarding(boarding[index]),
              onPageChanged: (int index) {
              if(index == boarding.length - 1) {
                setState(() {
                  Lastpage = true;
                });
              }
              else {
                setState(() {
                  Lastpage=false;
                });
              }
              },
              itemCount: boarding.length,
              controller: Boardcontroller,
              physics: const BouncingScrollPhysics(),)),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                 SmoothPageIndicator(controller: Boardcontroller,
                     effect: const ExpandingDotsEffect(
                       dotColor: Colors.grey,
                       activeDotColor: Colors.blue,
                       dotHeight: 10,
                       expansionFactor: 4,
                       dotWidth: 10,
                       spacing: 5.0
                     ),
                     count: boarding.length),
                const Spacer(),
                FloatingActionButton(onPressed: (){
                  if(Lastpage){
                    onSubmit();
                  }
                  else{
                    Boardcontroller.nextPage(duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn);
                  }

                },
                  child: const Icon(Icons.arrow_forward_ios)
                  )
              ],
            )
          ],
        ),
      )
    );
  }
}

Widget OnBoarding(BoardingModel model) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
        child: Image(image: AssetImage(model.image))),
    const SizedBox(height: 24.0,),
    Text(model.tittle,
      style: const TextStyle(
        fontSize: 24.0,
      ),
    ),
    const SizedBox(height: 24.0,),
    Text(model.body,
      style: const TextStyle(
        fontSize: 14.0,
      ),)
  ],
);
