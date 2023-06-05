import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecoomerenceflutterblocbyrohit/data/model/cart/cart_item_model.dart';
import 'package:ecoomerenceflutterblocbyrohit/data/repositories/order_repository.dart';
import 'package:meta/meta.dart';

import '../../data/model/order/order_model.dart';
import '../user_cubit/user_cubit.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  UserCubit _userCubit;
  StreamSubscription? streamSubscription;
  OrderCubit(this._userCubit ) : super(OrderInitialState()){

    _handleUserState(_userCubit.state);
   streamSubscription = _userCubit.stream.listen(_handleUserState);
  }

  void _handleUserState(UserState userState){

    if(userState is UserLoggedInState){
      _initialize(userState.userModel.id!);
    }
    else if(_userCubit is UserLogoutState){
      emit(OrderInitialState());
    }
  }

  final _repository = OrderRepository();

  Future<void> _initialize(String id) async {

    try{
      emit(OrderLoadingState(state.orders));

      final orders = await _repository.fetchOrdersForUser(id);

      emit(OrderLoadedState(orders));
    }
    catch(e){

      emit(OrderErrorState(e.toString(), state.orders));
    }

    
  }

  Future<bool> createOrder({
    required List<CartItemModel> items,
    required String paymentMethod
}) async {

    if(_userCubit.state is! UserLoggedInState){
      return false;
    }

    OrderModel newOrder = OrderModel(
      items: items,
      user: (_userCubit.state as UserLoggedInState).userModel,
      status: (paymentMethod == "pay-on-deliery") ? "order-placed" : "payment-pending"
    );

    try{
      emit(OrderLoadingState(state.orders));



      final orders = await _repository.createOrder(newOrder);
      List<OrderModel> order = [...state.orders , orders];

      emit(OrderLoadedState(order));
      return true;
    }
    catch(e){

      emit(OrderErrorState(e.toString(), state.orders));
      return false;
    }


  }

  @override
  Future<void> close() {
    // TODO: implement close
    streamSubscription?.cancel();
    return super.close();
  }



}
