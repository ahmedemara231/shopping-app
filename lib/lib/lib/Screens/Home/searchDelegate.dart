import 'package:flutter/material.dart';
import 'package:untitled9/lib/lib/Screens/Home/product_details.dart';

import '../../modules/myText.dart';

class Search extends SearchDelegate
{
  List dataList;
  Search({required this.dataList});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: ()
        {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List filteredProducts = dataList.where((element) => (element['name'] as String).contains(query)).toList();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              text: 'Search for your offers',
              fontWeight: FontWeight.w500,
              fontSize: 28,
            ),
            const SizedBox(height: 20,),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              crossAxisCount: 2,
              children: List.generate(
                filteredProducts.isNotEmpty ?
                filteredProducts.length :
                dataList.length,
                    (index) => InkWell(
                  onTap: ()
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(
                            index: index,
                            name: filteredProducts.isNotEmpty ? filteredProducts[index] ['name']: dataList[index]['name'],
                            description: filteredProducts.isNotEmpty ? filteredProducts[index] ['description']: dataList[index]['description'],
                            image: filteredProducts.isNotEmpty ? filteredProducts[index] ['image']: dataList[index]['image'],
                            currentPrice: filteredProducts.isNotEmpty ? filteredProducts[index] ['price']: dataList[index]['price'],
                            oldPrice: filteredProducts.isNotEmpty ? filteredProducts[index] ['old_price']: dataList[index]['old_price'],
                            discount: filteredProducts.isNotEmpty ? filteredProducts[index] ['discount']: dataList[index]['discount']
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.network(
                          filteredProducts.isNotEmpty ? filteredProducts[index]['image'] :
                          dataList[index]['image'],
                          fit: BoxFit.fill,
                        ),
                        // if(dataList[index]['discount'] > 0)
                        //   Align(
                        //     alignment: Alignment.topLeft,
                        //     child: ClipRRect(
                        //       borderRadius: BorderRadius.circular(10),
                        //       child: Container(
                        //         width: MediaQuery.of(context).size.width/6,
                        //         color: Colors.amber,
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(4.0),
                        //           child: MyText(
                        //             text: filteredProducts.isEmpty ?
                        //             '${dataList[index]['discount']} %' :
                        //             '${filteredProducts[index]['discount']} %'
                        //             ,
                        //             fontSize: 20,
                        //             fontWeight: FontWeight.w500,
                        //           )
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.grey[350],
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: MyText(
                                  text:
                                  filteredProducts.isNotEmpty ?
                                  '${filteredProducts[index]['price']} EGP' :
                                  '${dataList[index]['price']} EGP',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}