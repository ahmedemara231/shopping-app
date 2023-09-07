import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled9/lib/lib/Cubits/onBoarding_Cubit/states.dart';

import '../../shared_prefs/shared_prefs.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates>
{
  OnBoardingCubit() : super(InitialState());

  static OnBoardingCubit getInstance(context) => BlocProvider.of(context);

  Future<void> storeOnBoardingSkip({
    required String key,
    required dynamic value,
})async
  {
    await PhoneMemory.storeData(key: key, value: value).then((value)
    {
      log('$value');
      emit(SaveDataSuccessState());
    }).catchError((error)
    {
      log('error : ${error.toString()}');
      emit(SaveDataErrorState());
    });
  }
}