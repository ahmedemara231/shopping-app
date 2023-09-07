import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled9/lib/lib/Login_Registration_screens/register.dart';

import '../Cubits/AuthCubit/auth_models.dart';
import '../Cubits/AuthCubit/cubit.dart';
import '../Cubits/AuthCubit/states.dart';
import '../modules/myText.dart';
import '../modules/textFormField.dart';


class Login extends StatefulWidget {
   const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  var formKey = GlobalKey<FormState>();

  var emailCont = TextEditingController();

  var passCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(InitialState()),
      child: BlocConsumer<AuthCubit,AuthStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'images/Screenshot (59).png',
                              fit: BoxFit.fill,
                            ),
                            MyText(
                              text: 'Login',
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                            const SizedBox(
                              height: 23,
                            ),
                            TFF(
                              obscureText: false,
                              controller: emailCont,
                              prefixIcon: Icons.email_outlined,
                              hintText: 'Email ID',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TFF(
                              obscureText: AuthCubit.getInstance(context).hidePassword,
                              controller: passCont,
                              prefixIcon: Icons.lock,
                              hintText: 'password',
                              suffixIcon: IconButton(
                                onPressed: ()
                                {
                                  AuthCubit.getInstance(context).changePasswordVisibility();
                                },
                                icon: AuthCubit.getInstance(context).hidePassword == true?
                                const Icon(Icons.visibility_off) :
                                const Icon(Icons.remove_red_eye),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          if(state is LoginLoadingState)
                            const CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.blue,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                          if(state is LoginSuccessState || state is LoginErrorState || state is InitialState || state is ChangePasswordVisibility)
                            OutlinedButton(
                                onPressed: ()async
                                {
                                  if(formKey.currentState!.validate())
                                  {
                                    AuthCubit.getInstance(context).login(
                                      context: context,
                                        loginModel: LoginModel(
                                            email: emailCont.text.trim(),
                                            password: passCont.text,
                                        ),
                                    );
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.blue),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width / 4,
                                    right: MediaQuery.of(context).size.width / 4,
                                    bottom: 15,
                                    top: 15,
                                  ),
                                  child: MyText(
                                    text: 'Login',
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                )),

                          const SizedBox(
                            height: 40,
                          ),
                          MyText(
                            text: 'Or sign with..',
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              InkWell(
                                onTap: () {},
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Card(
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Image.network(
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkbnAZrEf5OshX7yDHRbxbuUUmfR7vUMsZUA&usqp=CAU')),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {},
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Card(
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Image.network(
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcSUWGIs3vTxgqa_qQ-0etVCRtIvpxtSI9Xg&usqp=CAU')),
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              MyText(text: 'Dont have an account?', fontSize: 15),
                              TextButton(
                                  onPressed: ()
                                  {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Register(),
                                      ),
                                    );
                                  },
                                  child: MyText(
                                    text: 'Register',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } ,
      ),
    );
  }
}
