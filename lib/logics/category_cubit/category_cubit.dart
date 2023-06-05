import 'package:bloc/bloc.dart';
import 'package:ecoomerenceflutterblocbyrohit/logics/category_cubit/category_state.dart';
import 'package:meta/meta.dart';

import '../../data/model/category_model/category_model.dart';
import '../../data/repositories/category_repository.dart';


class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitialState()){
    _initialize();
  }

  final _categoryRepository = CategoryRepository();

  void _initialize() async {

    try{

      emit(CategoryLoadedState(state.categories));

    List<CategoryModel> category =  await _categoryRepository.fetchAllCategory();

      emit(CategoryLoadedState(category));


    }catch(e){
      emit(CategoryErrorState(e.toString(), state.categories));
    }


  }


}


