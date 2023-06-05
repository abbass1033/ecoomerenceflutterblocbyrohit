part of 'product_cubit.dart';

@immutable
abstract class ProductState {
  final List<ProductModel> products;
  ProductState(this.products);
}

class ProductInitialState extends ProductState {
  ProductInitialState() : super([]);
}


class ProductLoadingState extends ProductState{
  ProductLoadingState(super.products);

}

class ProductLoadedState extends ProductState{
  ProductLoadedState(super.products);

}

class ProductErrorState extends ProductState{
  final String message;
  ProductErrorState(this.message , super.products);

}




