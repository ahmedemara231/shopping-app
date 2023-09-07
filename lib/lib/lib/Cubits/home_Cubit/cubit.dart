import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled9/lib/lib/Cubits/home_Cubit/states.dart';

import '../../API/Repository.dart';
import '../../API/model.dart';
import '../../modules/myText.dart';


class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit getInstance(context) => BlocProvider.of(context);

  Repo repo = Repo();
  late ResponseModel homeProducts;
  late ResponseModel homeUpperPhotos;

  Future<void> getHomeData({required context}) async {
    emit(HomeLoadingState());
    repo.getProducts().then((value) {
      homeProducts = value;
      log('${homeProducts.status}');

      repo.getHomeData().then((value) {
        if (value.status == true) {
          homeUpperPhotos = value;
          log('homeUpperPhotos done');
        } else {
          log('error');
          emit(GetHomeUpperPhotosErrorState());
          var snackBar = SnackBar(
            content: MyText(
              text: '${value.message}',
              fontSize: 18,
            ),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        emit(GetHomeDataSuccessState());
      });
    }).catchError((error) {
        log(error.toString());
      },
    );
  }

  // Future<void> getHomeProducts({required context}) async {
  //   repo.getProducts().then((value) {
  //     homeProducts = value;
  //     log('${homeProducts.status}');
  //   }).catchError(
  //     (error) {
  //       log(error.toString());
  //     },
  //   );
  // }
  //
  // Future<void> getHomeUpperPhotos({required context}) async {
  //   try {
  //     repo.getHomeData().then((value) {
  //       if (value.status == true) {
  //         homeUpperPhotos = value;
  //         log('homeUpperPhotos done');
  //       } else {
  //         log('error');
  //         emit(GetHomeUpperPhotosErrorState());
  //
  //         var snackBar = SnackBar(
  //           content: MyText(
  //             text: '${value.message}',
  //             fontSize: 18,
  //           ),
  //           backgroundColor: Colors.red,
  //         );
  //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       }
  //     });
  //   } on Exception catch (e) {
  //     log('the error is ${e.toString()}');
  //     emit(GetHomeUpperPhotosErrorState());
  //   }
  // }

  int currentIndex = 0;

  void changeTapIndex({required int tap}) {
    currentIndex = tap;
    emit(ChangeTapIndex());
    log('$currentIndex');
  }

  List<Map<String, dynamic>> cartProducts = [];
  void addToProductsList(Map<String, dynamic> product) {
    cartProducts.add(product);
    log('adding product to cart done');
    emit(PutProductInListState());
  }

  void removeFromProductsList(Map<String, dynamic> product) {
    cartProducts.remove(product);
    log('removing product to cart done');
    log('${cartProducts.length}');
    emit(RemoveProductFromListState());
  }

  int numberOfCopies = 0;
  void incrementNumberOfCopies() {
    numberOfCopies++;
    emit(ProductIncrementState());
  }

  void decrementNumberOfCopies() {
    if (numberOfCopies == 0) {
      return;
    } else {
      numberOfCopies--;
      emit(ProductDecrementState());
    }
  }

  List<int> listOfNumberOfCopies = [];
  void addNumberOfCopiesToList() {
    listOfNumberOfCopies.add(numberOfCopies);
    emit(AddNumberOfCopiesToListState());
  }

  void removeNumberOfCopiesToList(int number) {
    listOfNumberOfCopies.remove(number); // فيه هنا مشكلة
    emit(RemoveNumberOfCopiesToListState());
  }

  late ResponseModel contactingModel;
  Future<void> contactUs() async {
    emit(GetContactingDataLoadingState());
    try {
      await repo.contactUs(path: 'contacts').then((value) {
        if (value.status == true) {
          contactingModel = value;
          log('${contactingModel.status}');
          emit(GetContactingDataSuccessState());
        } else {
          log('${contactingModel.status}');
          emit(GetHomeProductsErrorState());
        }
      });
    } on Exception catch (e) {
      log('the error is : ${e.toString()}');
      emit(GetHomeProductsErrorState());
    }
  }
  double total = 0;

  void calcTotalPrice()
  {
    for
    (
    int i = 0;
    i < cartProducts.length && cartProducts.length == listOfNumberOfCopies.length;
    i++
    )
    {
      total += cartProducts[i]['price'] * listOfNumberOfCopies[i];
    }
  }
}
