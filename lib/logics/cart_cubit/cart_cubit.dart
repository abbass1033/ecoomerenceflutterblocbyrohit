import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecoomerenceflutterblocbyrohit/data/model/product/product_model.dart';
import 'package:ecoomerenceflutterblocbyrohit/logics/category_cubit/category_state.dart';
import 'package:meta/meta.dart';

import '../../data/model/cart/cart_item_model.dart';
import '../../data/repositories/cart_repository.dart';
import '../user_cubit/user_cubit.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
    final UserCubit _userCubit;

    StreamSubscription? _streamSubscription;

  CartCubit(this._userCubit) : super(CartInitialState()){

    //initial value
    handleUserState(_userCubit.state);
    _streamSubscription =  _userCubit.stream.listen((userState) {
      handleUserState(userState);
    });

  }


  void sortAndLoad(List<CartItemModel> items ){
    items.sort((a, b)=> b.product!.title!.compareTo(a.product!.title!));
    emit(CartLoadedState(items));

  }


  void handleUserState(UserState userState){
    //listening to user cubit
    if(userState is UserLoggedInState){
      _initialize(userState.userModel.sId!);
      }
      else if( userState is UserLogoutState){
        emit(CartInitialState());
      }

  }
  final _categoryRepository = CartRepository();

  void _initialize(String userId)async{
    emit(CartLoadingState(state.items));
    try{

       final items = await _categoryRepository.fetchCartForUser(userId);
       items.sort((a, b)=> b.product!.title!.compareTo(a.product!.title!));
       emit(CartLoadedState(items));

    }
    catch(e){
    emit(CartErrorState(e.toString() , state.items));
    }

  }

    void addToCart(ProductModel product, int quantity) async {
      emit( CartLoadingState(state.items) );
      try {
        if(_userCubit.state is UserLoggedInState) {
          UserLoggedInState userState = _userCubit.state as UserLoggedInState;

          CartItemModel newItem = CartItemModel(
              product: product,
              quantity: quantity
          );

          final items = await _categoryRepository.addToCart(newItem, userState.userModel.sId!);

          sortAndLoad(items);

        }
        else {
          throw "An error occured while adding the item!";
        }
      }
      catch(ex) {
        emit( CartErrorState(ex.toString(), state.items) );
      }
    }

    void removeFromCart(ProductModel product,) async {
      emit( CartLoadingState(state.items) );
      try {
        if(_userCubit.state is UserLoggedInState) {
          UserLoggedInState userState = _userCubit.state as UserLoggedInState;


          final items = await _categoryRepository.removeFromCart(product.sId! , userState.userModel.sId! );
          sortAndLoad(items);

        }
        else {
          throw "An error occured while adding the item!";
        }
      }
      catch(ex) {
        emit( CartErrorState(ex.toString(), state.items) );
      }
    }

    bool cartContains(ProductModel product) {
      if(state.items.isNotEmpty) {
        final foundItem = state.items.where((item) => item.product!.sId! == product.sId!).toList();
        if(foundItem.isNotEmpty) {
          return true;
        }
        else {
          return false;
        }
      }
      return false;
    }




    @override
  Future<void> close() {
    // TODO: implement close
  _streamSubscription?.cancel();
    return super.close();
  }

}
