import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Cubits/home_Cubit/cubit.dart';
import '../../Cubits/home_Cubit/states.dart';
import '../../modules/myText.dart';


class Cart extends StatefulWidget {
  // double totalPrice;
    Cart({super.key,
     // required this.totalPrice,
   });

  @override
  State<Cart> createState() => _CartState();
}
class _CartState extends State<Cart> {
  @override
  void initState() {
    // HomeCubit.getInstance(context).calcTotalPrice();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     var homeCubit = HomeCubit.getInstance(context);

    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return Scaffold(
          appBar: AppBar(
            title: MyText(text: 'Your Cart',fontSize: 25,fontWeight: FontWeight.w500,),
            actions: [
              TextButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: MyText(
                    text: 'Buy Now',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
          body: HomeCubit.getInstance(context).cartProducts.isEmpty?
          Center(
            child: MyText(
              text: 'Your Cart is Empty',
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),) :
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Image.network(
                            homeCubit.cartProducts[index]['image'],
                          ),
                          title: MyText(
                            text: '( ${homeCubit.listOfNumberOfCopies[index]} )',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          subtitle: MyText(
                            text: homeCubit.cartProducts[index]['name'],
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          trailing: IconButton(
                              onPressed: ()
                              {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: MyText(text: 'Delete this from cart ?'),
                                    actions: [
                                      TextButton(
                                          onPressed: ()
                                          {
                                            Navigator.pop(context);
                                          }, child: MyText(text: 'Cancel',fontSize: 18,)),
                                      TextButton(
                                          onPressed: ()
                                          {
                                            homeCubit.removeFromProductsList(homeCubit.cartProducts[index]);
                                            homeCubit.removeNumberOfCopiesToList(HomeCubit.getInstance(context).listOfNumberOfCopies[index]);
                                            SnackBar snackBar = SnackBar(
                                              duration: const Duration(seconds: 2),
                                              backgroundColor: Colors.grey,
                                                content: MyText(text: 'Deleted from cart',fontSize: 20,)
                                            );
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            HomeCubit.getInstance(context).total = 0;
                                            HomeCubit.getInstance(context).calcTotalPrice();
                                            Navigator.pop(context);
                                          }, child: MyText(text: 'Delete',fontSize: 18,))
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.delete,color: Colors.red,)
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(height: 20,),
                    itemCount: homeCubit.cartProducts.length,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    color: Colors.grey[400],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyText(text: 'Total is : ${HomeCubit.getInstance(context).total} EGP',fontSize: 25,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
