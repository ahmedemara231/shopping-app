import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled9/lib/lib/Screens/Home/home.dart';

import '../Cubits/home_Cubit/cubit.dart';
import '../Cubits/home_Cubit/states.dart';
import 'Profile/profile.dart';
import 'favorites.dart';

class BottomNavBar extends StatelessWidget {
  String name;
  String email;
  String phone;
  // String password;
  String token;

   BottomNavBar({super.key,
     required this.name,
     required this.email,
     required this.phone,
     // required this.password,
     required this.token,
   });

  @override
  Widget build(BuildContext context) {
    List<Widget> screens =
     [
      Home(
        name: name,
      ),
      Favorites(),
      Profile(
        name: name,
        // password: password,
        email: email,
        phone: phone,
        token: token,
      ),
    ];

    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedIconTheme: const IconThemeData(
              size: 30,
              color: Colors.deepPurple,
            ),
            selectedLabelStyle: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
            unselectedLabelStyle: const TextStyle(fontSize: 13,fontWeight: FontWeight.w500),
            currentIndex: HomeCubit.getInstance(context).currentIndex,
            onTap: (tap)
            {
              HomeCubit.getInstance(context).changeTapIndex(tap: tap);
            },
            items: const [
              BottomNavigationBarItem(label: 'Home',icon: Icon(Icons.home_filled)),
              BottomNavigationBarItem(label: 'Favorites',icon: Icon(Icons.favorite)),
              BottomNavigationBarItem(label: 'profile',icon: Icon(Icons.person)),
            ],
          ),
          body: screens[HomeCubit.getInstance(context).currentIndex],
        );
      },
    );
  }
}
