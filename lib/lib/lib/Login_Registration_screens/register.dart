import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubits/AuthCubit/auth_models.dart';
import '../Cubits/AuthCubit/cubit.dart';
import '../Cubits/AuthCubit/states.dart';
import '../modules/myText.dart';
import '../modules/textFormField.dart';

class Register extends StatelessWidget {
  Register({super.key});
  var formKey = GlobalKey<FormState>();
  var nameCont = TextEditingController();
  var emailCont = TextEditingController();
  var passCont = TextEditingController();
  var confPassCont = TextEditingController();
  var phoneCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(InitialState()),
      child: BlocConsumer<AuthCubit,AuthStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(),
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
                              text: 'SignUp',
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                            Row(
                              children: [
                                const Spacer(flex: 2,),
                                InkWell(
                                  onTap: () {},
                                  child: SizedBox(
                                    width: 90,
                                    height: 90,
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
                                    width: 90,
                                    height: 90,
                                    child: Card(
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Image.network(
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcSUWGIs3vTxgqa_qQ-0etVCRtIvpxtSI9Xg&usqp=CAU')),
                                    ),
                                  ),
                                ),
                                const Spacer(flex: 2,),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: MyText(
                                text: 'Or, register with email',
                                fontSize: 15,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TFF(
                              obscureText: false,
                              controller: nameCont,
                              prefixIcon: Icons.edit,
                              hintText: 'Name',
                            ),
                            const SizedBox(
                              height: 20,
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
                              obscureText: false,
                              controller: passCont,
                              prefixIcon: Icons.lock,
                              hintText: 'password',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                              ),
                              validator: (confirmedPassword)
                              {
                                if(confirmedPassword != passCont.text)
                                  {
                                    return 'Confirmed Password is not the same';
                                  }
                                else if(confirmedPassword!.isEmpty)
                                  {
                                    return 'This Field is required';
                                  }
                              },
                              controller: confPassCont,
                              decoration: const InputDecoration(
                                errorStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                                prefixIcon: Icon(Icons.lock),
                                hintText: 'Confirm Password',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TFF(
                              obscureText: false,
                              controller: phoneCont,
                              prefixIcon: Icons.phone_android,
                              hintText: 'phone',
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          if(state is RegisterLoadingState)
                            const CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                          if(state != RegisterLoadingState())
                            OutlinedButton(
                            onPressed: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                AuthCubit.getInstance(context).register(
                                  context: context,
                                  registerModel: RegisterModel(
                                    name: nameCont.text.trim(),
                                    email: emailCont.text.trim(),
                                    phone: phoneCont.text.trim(),
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
                                text: 'Register',
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

  }
}
