import 'package:flutter/material.dart';

import '../../modules/myText.dart';

class AdditionalProducts extends StatelessWidget {
  String image;
  int price;
  int oldPrice;
  int discount;

   AdditionalProducts({super.key,
     required this.image,
     required this.price,
     required this.oldPrice,
     required this.discount,
   });

  @override
  Widget build(BuildContext context) {
    return  Stack(

        children: [
          Image.network(image),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.amber,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyText(text: '$discount %',fontSize: 20,),
                  )),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(10),
          //     child: Container(
          //         color: Colors.grey[300],
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               MyText(text: '$price',fontSize: 20,),
          //               MyText(text: '$oldPrice',fontWeight: FontWeight.w500,textDecoration: TextDecoration.lineThrough,color: Colors.grey,fontSize: 17,)
          //             ],
          //           ),
          //         )),
          //   ),
          // ),
        ],
      );
  }
}
