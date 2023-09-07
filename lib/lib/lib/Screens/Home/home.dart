import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled9/lib/lib/Screens/Home/product_details.dart';
import 'package:untitled9/lib/lib/Screens/Home/searchDelegate.dart';
import '../../Cubits/home_Cubit/cubit.dart';
import '../../Cubits/home_Cubit/states.dart';
import '../../modules/myText.dart';
import 'additional_products.dart';
import 'cart.dart';

class Home extends StatefulWidget {
  String name;
   Home({super.key,
     required this.name,
   });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Widget> additionalProducts =
  [
    AdditionalProducts(
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyGWiLqhA3UmX5ZcvEHjOyc0maWgzWhFIfbg&usqp=CAU',
        price: 100,
        oldPrice: 150,
        discount: 33
    ),
    AdditionalProducts(
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT97WioMGspC3HNACU4aYn6XImzNt2__9SiFQ&usqp=CAU',
        price: 20000,
        oldPrice: 25000,
        discount: 20
    ),
    AdditionalProducts(
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfK9eD_tFCaxfT39MW4mQkeUZdLD7mFRR2pg&usqp=CAU',
        price: 20000,
        oldPrice: 25000,
        discount: 20
    ),
    AdditionalProducts(
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR94L6YVxKM0J-U0NjLFgRxQoXoeGvln6zqLQ&usqp=CAU',
        price: 30000,
        oldPrice: 25000,
        discount: 17
    ),
  ];

  @override
  void initState() {
    // var num = 6.2569852.round();
    // print(num);
    // homeCubit.getHomeProducts();
    HomeCubit.getInstance(context).getHomeData(context: context);
   // HomeCubit.getInstance(context).getHomeUpperPhotos();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state)
      {
        log('$state');
      },
        builder: (context, state)
        {
          return Scaffold(
              appBar: AppBar(
                title: MyText(text: 'Hello ${widget.name}',fontWeight: FontWeight.w500,),
                actions: [
                  IconButton(
                      onPressed: ()
                      {
                        showSearch(
                            context: context,
                          delegate: Search(
                              dataList: ((HomeCubit.getInstance(context).homeProducts.data?['data'] as List))
                          ),
                        );
                      },
                      icon: const Icon(Icons.search),
                  ),
                  IconButton(
                    onPressed: ()
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Cart(
                              // totalPrice: HomeCubit.getInstance(context).total,
                            ),
                          ),
                      );
                    },
                      icon: Row(
                        children: [
                          const Icon(Icons.shopping_cart),
                          const SizedBox(width: 8,),
                          MyText(text: 'Cart',fontSize: 20,fontWeight: FontWeight.w500,),
                        ],
                      ),
                  ),
                ],
              ),
              body: state is HomeLoadingState || state is HomeInitialState?
              const Center(child: CircularProgressIndicator(),) :
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: state is GetHomeUpperPhotosErrorState || state is GetHomeProductsErrorState ?
                const Center(child: CircularProgressIndicator()) :
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider(
                          items: List.generate(
                              (HomeCubit.getInstance(context).homeUpperPhotos.data?['banners'] as List).length,
                                  (index) => Image.network((HomeCubit.getInstance(context).homeUpperPhotos.data?['banners'] as List)[index]['image']),
                          ),
                          options: CarouselOptions(
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration: const Duration(seconds: 1),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      const SizedBox(
                        height: 15,
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        crossAxisCount: 2,
                        children: List.generate(
                          (HomeCubit.getInstance(context).homeProducts.data?['data'] as List).length,
                              (index) => InkWell(
                                onTap: ()
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetails(
                                          index: index,
                                          name: (HomeCubit.getInstance(context).homeProducts.data?['data'] as List)[index]['name'],
                                          description: (HomeCubit.getInstance(context).homeProducts.data?['data'] as List)[index]['description'],
                                          image: (HomeCubit.getInstance(context).homeProducts.data?['data'] as List)[index]['image'],
                                          currentPrice: (HomeCubit.getInstance(context).homeProducts.data?['data'] as List)[index]['price'],
                                          oldPrice: (HomeCubit.getInstance(context).homeProducts.data?['data'] as List)[index]['old_price'],
                                          discount: (HomeCubit.getInstance(context).homeProducts.data?['data'] as List)[index]['discount']
                                        ),
                                      ),
                                  );
                                },
                                child: Card(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.network(
                                        (HomeCubit.getInstance(context).homeProducts.data?['data']as List)[index]['image'],
                                        fit: BoxFit.fill,
                                      ),
                                      if((HomeCubit.getInstance(context).homeProducts.data?['data'] as List)[index]['discount'] > 0)
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width/6,
                                              color: Colors.amber,
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: MyText(text: '${
                                                   ( (
                                                        ((HomeCubit.getInstance(context).homeProducts.data?['data'] as List)[index]['old_price'] as num)
                                                            - ((HomeCubit.getInstance(context).homeProducts.data?['data'] as List)[index]['price'] as num)
                                                    ) / ((HomeCubit.getInstance(context).homeProducts.data?['data'] as List)[index]['old_price'] as num) * 100).round()
                                                } %',
                                                  fontSize: 25,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Container(
                                              color: Colors.grey[350],
                                              child: Padding(
                                                padding: const EdgeInsets.all(2.0),
                                                child: MyText(
                                                    text: '${(HomeCubit.getInstance(context).homeProducts.data?['data'] as List )[index]['price']} EGP',
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        height: 5,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          children: [
                            MyText(
                              text: 'For special offers visit our website',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            InkWell(
                              onTap: () {},
                                child: MyText(text: 'https://pub.dev/packages/webview_flutter/example',color: Colors.blue,fontSize: 20,))
                          ],
                        ),
                      ),
                      const Divider(
                        height: 5,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MyText(
                        text: 'Deals For You',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              additionalProducts.length,
                                  (index) => Row(
                                    children: [
                                      Card(
                                        child: additionalProducts[index],
                                      ),
                                      const SizedBox(width: 10,),
                                    ],
                                  ),
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
        }
    );
  }
}
