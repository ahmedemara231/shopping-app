import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Cubits/home_Cubit/cubit.dart';
import '../../Cubits/home_Cubit/states.dart';
import '../../modules/myText.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  void initState() {
    HomeCubit.getInstance(context).contactUs();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {},
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: state is GetContactingDataLoadingState?
              const Center(child: CircularProgressIndicator(),) :
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(text: 'Contact Us On Our Social Media',fontSize: 25,fontWeight: FontWeight.w500,),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {},
                        child: Card(
                          color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.network((HomeCubit.getInstance(context).contactingModel.data?['data'] as List)[index]['image']),
                              MyText(text: (HomeCubit.getInstance(context).contactingModel.data?['data'] as List)[index]['value'],color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500,)
                            ],
                          ),
                        ),
                    ),
                      ),
                      itemCount:(HomeCubit.getInstance(context).contactingModel.data?['data'] as List).length ,
                    ),
                  )
                ],
              ),
            ),
          );
        },
    );
  }
}
