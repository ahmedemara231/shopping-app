import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Cubits/AuthCubit/cubit.dart';
import '../../Cubits/AuthCubit/states.dart';
import '../../Login_Registration_screens/login_screen.dart';
import '../../modules/myText.dart';
import '../../modules/textFormField.dart';
import 'contacting_screen.dart';

class Profile extends StatefulWidget {
  String token;
  String name;
  String email;
  String phone;
  // String password;

  Profile({super.key,
    required this.token,
    required this.name,
    required this.email,
    required this.phone,
    // required this.password,
   });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var nameCont = TextEditingController();

  var emailCont = TextEditingController();

  var passCont = TextEditingController();

  var phoneCont = TextEditingController();

  @override
  void initState() {
    nameCont.text = widget.name;
    emailCont.text = widget.email;
    // passCont.text = widget.password;
    phoneCont.text = widget.phone;
    super.initState();
  }
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return  Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: MyText(text: 'Profile',fontWeight: FontWeight.w500,fontSize: 25,),
              actions: [
                IconButton(
                    onPressed: ()
                    {
                      scaffoldKey.currentState?.showBottomSheet((context) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Container(
                              height: 2,
                              width: MediaQuery.of(context).size.width/3,
                              color: Colors.black,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ListTile(
                                  title: MyText(text: 'Dark Mode',fontSize: 22,fontWeight: FontWeight.w500,),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12,),
                          InkWell(
                            onTap: ()
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ContactUs(),
                                  ),
                              );
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ListTile(
                                  title: MyText(text: 'Contact us',fontSize: 22,fontWeight: FontWeight.w500,),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12,),
                          InkWell(
                            onTap: () 
                            {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: MyText(text: 'Are you sure to logout ?'),
                                  actions: [
                                    TextButton(
                                        onPressed: ()
                                        {
                                          Navigator.pop(context);
                                        }, child: MyText(text: 'Cancel',fontSize: 18,)),
                                    TextButton(
                                        onPressed: ()
                                        {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const Login(),
                                            ), (route) => false,
                                          );
                                        }, child: MyText(text: 'logout',fontSize: 18,))
                                  ],
                                ),
                              );
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ListTile(
                                  title: MyText(text: 'Log out',fontSize: 22,fontWeight: FontWeight.w500,),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),);
                    },
                    icon: const Icon(Icons.settings),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(text: 'Your info',fontWeight: FontWeight.bold,fontSize: 30,),
                  const SizedBox(height: 20,),
                  TFF(
                    obscureText: false,
                    controller: nameCont,
                    hintText: 'Name',
                    prefixIcon: Icons.edit,
                    prefixIconColor: Colors.grey,
                    onChanged: (name)
                    {
                      if(nameCont.text == widget.name)
                        {
                          AuthCubit.getInstance(context).onPressedEqualNull();
                        }
                      else{
                          AuthCubit.getInstance(context).changeData(
                              token: widget.token,
                              name: nameCont.text,
                              email: emailCont.text,
                              phone: phoneCont.text,
                            context: context,
                          );
                      }
                    },
                  ),
                  const SizedBox(height: 20,),
                  TFF(
                    obscureText: false,
                    controller: emailCont,
                    hintText: 'E-Mail',
                    prefixIcon: Icons.email,
                    prefixIconColor: Colors.blue,
                    onChanged: (email)
                    {
                      if(emailCont.text == widget.email)
                      {

                        AuthCubit.getInstance(context).onPressedEqualNull();

                      }
                      else{
                        AuthCubit.getInstance(context).changeData(
                          token: widget.token,
                          name: nameCont.text,
                          email: emailCont.text,
                          phone: phoneCont.text,
                          context: context,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20,),
                  // TFF(
                  //   controller: passCont,
                  //   hintText: 'Password',
                  //   prefixIcon: Icons.lock,
                  // ),
                  // const SizedBox(height: 20,),
                  TFF(
                    obscureText: false,
                    controller: phoneCont,
                    hintText: 'phone',
                    prefixIcon: Icons.phone,
                    prefixIconColor: Colors.red,
                    onChanged: (phone)
                    {
                      if(phoneCont.text == widget.phone)
                      {

                        AuthCubit.getInstance(context).onPressedEqualNull();

                      }
                      else{
                        AuthCubit.getInstance(context).changeData(
                          token: widget.token,
                          name: nameCont.text,
                          email: emailCont.text,
                          phone: phoneCont.text,
                          context: context,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20,),
                  if(state is UpdateUserDataLoadingState)
                    const LinearProgressIndicator(),
                  if(state is UpdateUserDataSuccessState || state is UpdateUserDataErrorState || state is InitialState || state is ChangeOnPressed1State || state is ChangeOnPressed2State)
                    OutlinedButton(
                        onPressed: AuthCubit.getInstance(context).onPressed,
                        style: OutlinedButton.styleFrom(
                             backgroundColor:
                             state is ChangeOnPressed1State ?
                            Colors.blue :
                            Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10.0,
                            right: 50,
                            left: 50,
                            top: 10,
                          ),
                          child: MyText(text: 'Update',color: Colors.white,fontSize: 22,),
                        )),
                ],
              ),
            )
        );
      },
    );
  }
}
