import 'package:flutter/material.dart';

class Model extends StatelessWidget {

  String imageUrl;
  String text;
   Model({super.key,
    required this.imageUrl,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(imageUrl,fit: BoxFit.fill,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
              text,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
              ),
          ),
        ),
      ],
    );
  }
}
