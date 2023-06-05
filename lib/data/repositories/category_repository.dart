

import 'package:dio/dio.dart';
import 'package:ecoomerenceflutterblocbyrohit/core/api.dart';
import 'package:ecoomerenceflutterblocbyrohit/data/model/category_model/category_model.dart';
import 'package:flutter/foundation.dart';

class CategoryRepository{

  API _api = API();
  Future<List<CategoryModel>> fetchAllCategory()async{

    try{

      Response response = await _api.sendRequest.get("/category");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success){
        throw apiResponse.message.toString();
      }

     return (apiResponse.data as List<dynamic>).map((json) => CategoryModel.fromJson(json)).toList();


    }catch(e){
      rethrow ;
    }
  }
}