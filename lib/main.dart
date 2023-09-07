import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled9/lib/lib/shared_prefs/shared_prefs.dart';
import 'lib/lib/Cubits/AuthCubit/cubit.dart';
import 'lib/lib/Cubits/AuthCubit/states.dart';
import 'lib/lib/Cubits/home_Cubit/cubit.dart';
import 'lib/lib/Cubits/observer.dart';
import 'lib/lib/Cubits/onBoarding_Cubit/cubit.dart';
import 'lib/lib/Login_Registration_screens/login_screen.dart';
import 'lib/lib/onBoarding/onBoarding_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await PhoneMemory.init();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    PhoneMemory.getData(key: 'onBoarding');
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(InitialState()),
        ),
        BlocProvider(
          create: (context) => OnBoardingCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              actionsIconTheme: IconThemeData(
                color: Colors.black,
              )
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              actionsIconTheme: IconThemeData(
                color: Colors.white,
              )
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: PhoneMemory.getData(key: 'onBoarding') == true ?
        const Login() :
        const OnBoarding(),
        // home: BottomNavBar(token: 'sss', name: 'ahmed',email: 'aaa',phone: 'aaaaaaa',)
      ),
    );
  }
}
// home: BottomNavBar(token: 'sss', name: 'ahmed',email: 'aaa',phone: 'aaaaaaa',)