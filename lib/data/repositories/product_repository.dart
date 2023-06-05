
import 'package:dio/dio.dart';
import 'package:ecoomerenceflutterblocbyrohit/core/api.dart';
import 'package:ecoomerenceflutterblocbyrohit/data/model/product/product_model.dart';

class ProductRepository{

  API _api = API();


  Future<List<ProductModel>?>fetchAllProducts()async{

    try{

     Response response = await _api.sendRequest.get("/product");

     ApiResponse apiResponse = ApiResponse.fromResponse(response);

     if(!apiResponse.success){
       throw apiResponse.message.toString();
     }

     return (apiResponse.data as List<dynamic>).map((e) => ProductModel.fromJson(e)).toList();

    }catch(e){
      rethrow;

    }
  }

  Future<List<ProductModel>?>fetchProductsByCategory(String categoryId)async{

    try{

      Response response = await _api.sendRequest.get("/product/category/$categoryId");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success){
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>).map((e) => ProductModel.fromJson(e)).toList();

    }catch(e){
      rethrow;

    }
  }
}