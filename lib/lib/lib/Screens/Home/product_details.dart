import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Cubits/home_Cubit/cubit.dart';
import '../../Cubits/home_Cubit/states.dart';
import '../../modules/myText.dart';

class ProductDetails extends StatelessWidget {
  String name;
  String description;
  String image;
  var currentPrice;
  var oldPrice;
  var discount;
  int index;
  ProductDetails({super.key,
     required this.name,
     required this.description,
     required this.image,
     required this.currentPrice,
     required this.oldPrice,
     required this.discount,
     required this.index,
   });

   var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: MyText(
              text: 'Details',
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.network(image,fit: BoxFit.fill,),
                      if(discount > 0)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              color: Colors.amber,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MyText(text: '$discount% OFF',fontSize: 20,fontWeight: FontWeight.bold,),
                              )),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            color: Colors.grey[300],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MyText(
                                text:'$currentPrice EGP',
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                      const SizedBox(width: 10,),
                      if(discount > 0)
                        MyText(
                        text: '$oldPrice',
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        textDecoration: TextDecoration.lineThrough,
                      )
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: ()
                        {
                          HomeCubit.getInstance(context).decrementNumberOfCopies();
                        },
                        icon: const Icon(Icons.remove,size: 30,),
                      ),
                      MyText(
                        text: '${HomeCubit.getInstance(context).numberOfCopies}',
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      IconButton(
                        onPressed: ()
                        {
                          HomeCubit.getInstance(context).incrementNumberOfCopies();
                        },
                        icon: const Icon(Icons.add,size: 30,),
                      ),
                    ],
                  ),
                  OutlinedButton(
                      onPressed: ()
                      {
                        if( HomeCubit.getInstance(context).numberOfCopies == 0)
                          {
                            SnackBar snackBar = SnackBar(
                              duration: const Duration(seconds: 2),
                                backgroundColor: Colors.red,
                                content: MyText(text: 'please select the number of your product',fontSize: 18,));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        else{
                          HomeCubit.getInstance(context).addToProductsList((HomeCubit.getInstance(context).homeProducts.data?['data'] as List)[index]);
                          HomeCubit.getInstance(context).addNumberOfCopiesToList();
                          HomeCubit.getInstance(context).numberOfCopies = 0;
                          SnackBar snackBar = SnackBar(
                              duration: const Duration(seconds: 2),
                              backgroundColor: Colors.green,
                              content: MyText(text: 'Added Successfully to your cart',fontSize: 20,));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          HomeCubit.getInstance(context).total = 0;
                          HomeCubit.getInstance(context).calcTotalPrice();
                          log('${HomeCubit.getInstance(context).total}');
                        }
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.orange
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: MyText(text: 'Add to Cart',color: Colors.black,fontSize: 22,),
                      )),
                  const SizedBox(height: 10,),
                  OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.yellowAccent
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: MyText(text: 'Buy now',color: Colors.black,fontSize: 22,),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
