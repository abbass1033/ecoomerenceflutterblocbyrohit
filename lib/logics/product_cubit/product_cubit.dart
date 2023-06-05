import 'package:bloc/bloc.dart';
import 'package:ecoomerenceflutterblocbyrohit/core/api.dart';
import 'package:ecoomerenceflutterblocbyrohit/data/repositories/product_repository.dart';
import 'package:meta/meta.dart';

import '../../data/model/category_model/category_model.dart';
import '../../data/model/product/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()){
    _initialize();
  }
  
  API _api = API();
  ProductRepository _productRepository = ProductRepository();

  _initialize()async{
    emit(ProductLoadingState(state.products));

    try{
      
     final products =await _productRepository.fetchAllProducts();
      emit( ProductLoadedState(products!) );
     
        
    }
    catch(e){
      emit(ProductErrorState(e.toString(), state.products));
    }
  }
}
