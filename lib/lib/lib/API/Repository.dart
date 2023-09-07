import 'package:dio/dio.dart';
import 'package:untitled9/lib/lib/API/services.dart';

import '../Cubits/AuthCubit/auth_models.dart';
import 'model.dart';

class Repo
{
  Services services = Services();

  Future<ResponseModel> login({
    required LoginModel loginModel,
})async
  {
   Response response = await services.postData(
       path: 'login',
       data:
    {
      'email' : loginModel.email,
      'password' : loginModel.password
    });
   return ResponseModel.fromJson(response.data);
  }

  Future<ResponseModel> register({
  required RegisterModel registerModel,
})async
  {
    Response response = await services.postData(
      path: 'register',
      data:
      {
        'name' : registerModel.name,
        'email' : registerModel.email,
        'password' : registerModel.password,
        'phone' : registerModel.phone,
      },
    );
    return ResponseModel.fromJson(response.data);
}

  Future<ResponseModel> updateInfo({
    required UpdateUserDataModel userDataModel,
})async
  {
    Response response = await services.putData(
        token: userDataModel.token,
        path: 'update-profile',
        data:
        {
          'name' : userDataModel.name,
          'email' : userDataModel.email,
          'phone' : userDataModel.phone,
        }
    );
    return ResponseModel.fromJson(response.data);
  }
  
  Future<ResponseModel> getProducts()async
  {
    Response response = await services.getData('products');
    return ResponseModel.fromJson(response.data);
  }
  
  // void logOut() async
  // {
  //   Response response = await services.postData(path: 'logout', data: {});
  // }

  Future<ResponseModel> getCategoryProducts()async
  {
    Response response = await services.getData(
      'products',
      queryParams:
        {
          'category_id' : '1'
        },
    );
    return ResponseModel.fromJson(response.data);
  }

  Future<ResponseModel> getHomeData() async
  {
   Response response = await services.getData(
       'home',
   );
   return ResponseModel.fromJson(response.data);
  }


  Future<ResponseModel> getCategory() async
  {
    Response response = await services.getData('categories',lang: 'en');
    return ResponseModel.fromJson(response.data);
  }

  Future<ResponseModel> contactUs({required String path})async
  {
    Response response = await services.getData(path);
    return ResponseModel.fromJson(response.data);
  }

}
