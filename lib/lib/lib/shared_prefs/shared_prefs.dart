// import 'dart:developer';
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Memory
// {
//   static SharedPreferences? sharedPreferences;
//
//   static void init() async
//   {
//     sharedPreferences = await SharedPreferences.getInstance();
//     if(sharedPreferences == null)
//       {
//         log('null');
//       }
//     else{
//       log('not null');
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneMemory
{
  static late SharedPreferences sharedPreferences;
  static Future<void> init()async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> storeData({required String key, required dynamic value})
  {
    if(value is int) {
      return sharedPreferences.setInt(key, value);
    }
    if(value is double) {
      return sharedPreferences.setDouble(key, value);
    }
    if(value is bool) {
      return sharedPreferences.setBool(key, value);
    }
    else {
      return sharedPreferences.setString(key, value);
    }
  }

  static getData({required String key})
  {
   return sharedPreferences.get(key);
  }
}