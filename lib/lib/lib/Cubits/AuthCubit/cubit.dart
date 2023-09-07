import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled9/lib/lib/Cubits/AuthCubit/states.dart';
import '../../API/Repository.dart';
import '../../API/model.dart';
import '../../Screens/Home/home.dart';
import '../../Screens/bottomNavBar.dart';
import '../../modules/myText.dart';
import 'auth_models.dart';

class AuthCubit extends Cubit<AuthStates>
{
  AuthCubit(super.initialState);
 static AuthCubit getInstance(context) => BlocProvider.of(context);


  bool hidePassword = true;
  void changePasswordVisibility()
  {
    hidePassword = !hidePassword;
    emit(ChangePasswordVisibility());
  }
  Repo repo = Repo();

  late ResponseModel logModel;
  Future<void> login({
    required LoginModel loginModel,
    required context,
})async
  {
    emit(LoginLoadingState());
    try {
      await repo.login(loginModel: loginModel).then((value)
      {
        if(value.status == true)
          {
           logModel = value;
           log('${logModel.message}');
           Navigator.pushAndRemoveUntil(
             context,
             MaterialPageRoute(
               builder: (context) => BottomNavBar(
                 name: logModel.data?['name'],
                 email: logModel.data?['email'],
                 phone: logModel.data?['phone'],
                 // password: logModel.data?['password'],
                 token: logModel.data?['token'],
               ),
             ), (route) => false,
           );
           emit(LoginSuccessState());
          }
        else{
          log('${value.message}');
          emit(LoginErrorState());
          var snackBar = SnackBar(content: MyText(text: '${value.message}',fontSize: 18,),backgroundColor: Colors.red,);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    } on Exception catch (e)
    {
      log('the error is :${e.toString()}');
      emit(LoginErrorState());
    }
  }

  late ResponseModel regModel;
  Future<void> register({
    required RegisterModel registerModel,
    required context,
})async
  {
    emit(RegisterLoadingState());
    try {
      await repo.register(registerModel: registerModel).then((value)
      {
        if(value.status == true)
          {
            regModel = value;
            log('${value.message}');
            emit(RegisterSuccessState());
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Home(name: regModel.data?['name']),
              ), (route) => false,
            );
          }
        else{
          log('${value.message}');
          emit(RegisterErrorState());

          var snackBar = SnackBar(content: MyText(text: '${value.message}',fontSize: 18,),backgroundColor: Colors.red,);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

      });
    } on Exception catch (e) {
      log('the error is : ${e.toString()}');
      emit(RegisterErrorState());
    }
  }

 late ResponseModel updateModel;
  Future<void> updateUserData({
    required UpdateUserDataModel userDataModel
  }) async
  {
    emit(UpdateUserDataLoadingState());
    try {
      repo.updateInfo(userDataModel: userDataModel).then((value)
      {
        if(value.status == true)
          {
            updateModel = value;
            log('${value.message}');
            emit(UpdateUserDataSuccessState());
          }
        else{
          log('${value.message}');
          emit(UpdateUserDataErrorState());
        }
      });
    } on Exception catch (e) {
      log('the error is ${e.toString()}');
      emit(UpdateUserDataErrorState());
    }
  }

  void Function()? onPressed;
  void changeData({
    required String token,
    required String name,
    required String email,
    required String phone,
    required context,
})
  {
    onPressed = () async {
      await updateUserData(
        userDataModel: UpdateUserDataModel(
            token: token,
            name: name,
            email: email,
            phone: phone
        ),
      ).then((value) {
        SnackBar snackBar = SnackBar(
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
            content: MyText(text: 'Updated Successfully',fontSize: 20,)
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    };
    emit(ChangeOnPressed1State());
  }

  void onPressedEqualNull()
  {
    onPressed = null;
    emit(ChangeOnPressed2State());
  }

}