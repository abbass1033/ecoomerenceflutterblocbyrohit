import 'package:bloc/bloc.dart';
import 'package:ecoomerenceflutterblocbyrohit/data/repositories/product_repository.dart';
import 'package:meta/meta.dart';

import '../../data/model/category_model/category_model.dart';
import '../../data/model/product/product_model.dart';

part 'category_product_state.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  final CategoryModel category;
  CategoryProductCubit(this.category) : super(CategoryProductInitialState()){
    _initialize();
  }

  final _productRepository = ProductRepository();

  void _initialize()async{
    emit(CategoryProductLoadingState(state.products));
    try{

     final product = await _productRepository.fetchProductsByCategory(category.sId!);
    
      emit(CategoryProductLoadedState(product));
    }catch(e){
      emit(CategoryProductErrorState(e.toString(), state.products));
      
    }

  }
}
