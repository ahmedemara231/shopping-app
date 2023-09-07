import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled9/lib/lib/onBoarding/pageView_model.dart';
import '../Cubits/onBoarding_Cubit/cubit.dart';
import '../Cubits/onBoarding_Cubit/states.dart';
import '../Login_Registration_screens/login_screen.dart';

class OnBoarding extends StatefulWidget {
   const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
   List<Model> models =
   [
     Model(
         imageUrl: 'images/Screenshot (59).png',
         text: 'Welcome to Our App'
     ),
     Model(
         imageUrl: 'images/Screenshot (57).png',
         text: 'Sign in now to shop your favorite products',
     ),
   ];
   bool isLast = false;

   var cont = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit,OnBoardingStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return Scaffold(
          floatingActionButton: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SmoothPageIndicator(
                  count: models.length,
                  controller: cont,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.deepOrange,
                    dotColor: Colors.grey,
                  ),
                ),
              ),
              const Spacer(),
              FloatingActionButton(
                backgroundColor: Colors.deepOrange,
                onPressed: ()
                {
                  cont.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubicEmphasized
                  );
                  if(isLast)
                  {
                    OnBoardingCubit.getInstance(context).storeOnBoardingSkip(
                      key: 'onBoarding',
                      value: true,
                    );
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(
                      builder: (context) => const Login(),
                    ), (route) => false);
                  }
                },
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
          body: PageView.builder(
            controller: cont,
            itemBuilder: (context, index) => models[index],
            itemCount: models.length,
            onPageChanged: (pageIndex)
            {
              if(pageIndex == (models.length-1))
              {
                setState(() {
                  isLast = true;
                  log('last');
                });
              }
            },
          ),
        );
      },
    );
  }
}
