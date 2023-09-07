import 'dart:developer';

import 'package:dio/dio.dart';

class Services
{
  late Dio dio ;
  Services() {
    dio = Dio(
        BaseOptions(
            baseUrl: 'https://student.valuxapps.com/api/',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
        )
    );
  }
    Future<Response> postData({
      required String path,
      required Map<String,dynamic> data,
    }) async
    {
        try
        {
          Response response = await dio.post(path,data: data);
          return response;
        } on DioError catch(error)
        {
          throw handleError(error);
        }
    }

    Future<Response> getData(
        String path,
        {
          Map<String, dynamic>? queryParams,
          String? lang,
        })async
    {
      try
      {
        dio.options.headers =
        {
          'lang' : 'en'
        };
        Response response = await dio.get(path, queryParameters: queryParams);
        return response;
      } on DioError catch(error)
      {
        throw handleError(error);
      }
  }

  Future<Response> putData({
    required String path,
    required Map<String , dynamic> data,
    required String token,
  })async
  {
    dio.options.headers =
    {
        'Authorization' : token,
    };
    try
    {
      Response response = await dio.put(
        path,
        data: data,
      );
      return response;
    } on DioError catch(error)
    {
      throw handleError(error);
    }
  }

    Exception handleError(DioError error)
    {
      String errorMessage = '';
      if(error.type == DioErrorType.badResponse)
      {
        errorMessage = 'bad response ${error.response?.statusCode} / ${error.response?.statusMessage}';
      }else if(error.type == DioErrorType.connectionTimeout)
        {
          errorMessage = 'time out';
        }
      log(errorMessage);
      return error;
    }

}