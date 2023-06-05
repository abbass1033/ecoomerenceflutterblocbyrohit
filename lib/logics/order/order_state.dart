part of 'order_cubit.dart';

@immutable
abstract class OrderState {
  List<OrderModel> orders;

  OrderState(this.orders);
}

class OrderInitialState extends OrderState {
  OrderInitialState() : super([]);
}


class OrderLoadingState extends OrderState{
  OrderLoadingState(super.orders);

}

class OrderLoadedState extends OrderState {
  OrderLoadedState(super.orders);
}

class OrderErrorState extends OrderState {
  String message;
  OrderErrorState(this.message,super.orders);

  }

