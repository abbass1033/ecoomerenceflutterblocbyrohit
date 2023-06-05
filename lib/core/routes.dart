
import 'package:ecoomerenceflutterblocbyrohit/data/model/category_model/category_model.dart';
import 'package:ecoomerenceflutterblocbyrohit/data/model/product/product_model.dart';
import 'package:ecoomerenceflutterblocbyrohit/logics/category_product_cubit/category_product_cubit.dart';
import 'package:ecoomerenceflutterblocbyrohit/presentation/auth/login_screen.dart';
import 'package:ecoomerenceflutterblocbyrohit/presentation/auth/provider/login_provider.dart';
import 'package:ecoomerenceflutterblocbyrohit/presentation/auth/provider/signup_provider.dart';
import 'package:ecoomerenceflutterblocbyrohit/presentation/auth/signup_screen.dart';
import 'package:ecoomerenceflutterblocbyrohit/presentation/cart/cart_screen.dart';
import 'package:ecoomerenceflutterblocbyrohit/presentation/home/home_screen.dart';
import 'package:ecoomerenceflutterblocbyrohit/presentation/order/order_detail_screen.dart';
import 'package:ecoomerenceflutterblocbyrohit/presentation/order/order_places_screen.dart';
import 'package:ecoomerenceflutterblocbyrohit/presentation/order/providers/order_detail_provider.dart';
import 'package:ecoomerenceflutterblocbyrohit/presentation/product/category_product_screen.dart';
import 'package:ecoomerenceflutterblocbyrohit/presentation/splash/splash_screen.dart';
import 'package:ecoomerenceflutterblocbyrohit/presentation/user/edit_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../presentation/order/my_order_screen.dart';
import '../presentation/product/product_detail_screen.dart';

class Routes{
 static Route?  onGenerateRoutes(RouteSettings routeSettings){

   switch(routeSettings.name)
       {
     case RoutesName.splashScreen : return CupertinoPageRoute(
         builder: (BuildContext context)=> const SplashScreen()
     );
     case RoutesName.signInScreen : return CupertinoPageRoute(
         builder: (BuildContext context)=> ChangeNotifierProvider(create: (BuildContext context)=> LoginProvider(context),
         child: const LoginScreen())
     );

     case RoutesName.signUpScreen : return CupertinoPageRoute(
         builder: (BuildContext context)=> ChangeNotifierProvider(create: (BuildContext context)=> SignupProvider( context: context),

         child: const SignupScreen(),
         )

     );

     case RoutesName.homeScreen : return CupertinoPageRoute(
         builder: (BuildContext context)=> const HomeScreen()

     );

     case RoutesName.productDetail : return CupertinoPageRoute(
         builder: (BuildContext context)=>  ProductDetailsScreen(productModel: routeSettings.arguments as ProductModel,
           
         )
     );

     case RoutesName.cartScreen : return CupertinoPageRoute(
         builder: (BuildContext context)=>  const CartScreen()
     );


     case RoutesName.categoryProductScreen: return CupertinoPageRoute(
         builder: (context) => BlocProvider(
             create: (context) => CategoryProductCubit(routeSettings.arguments as CategoryModel),
             child: const CategoryProductScreen()
         )
     );


     case RoutesName.editProfileScreen: return CupertinoPageRoute(
         builder: (context) => BlocProvider(
             create: (context) => CategoryProductCubit(routeSettings.arguments as CategoryModel),
             child: const EditProfileScreen()
         )
     );



     case RoutesName.orderDetailScreen : return CupertinoPageRoute(
         builder: (BuildContext context)=>  ChangeNotifierProvider(create: (BuildContext context) => OrderDetailProvider(),
         child: const OrderDetailScreen())
     );

     case RoutesName.orderPlacedScreen : return CupertinoPageRoute(
         builder: (BuildContext context)=>  const OrderPlacedScreen()
     );
     case RoutesName.myOrderScreen : return CupertinoPageRoute(
         builder: (BuildContext context)=>  const MyOrderScreen()
     );
     default : return null;
   }
  }

}


class RoutesName {
  static const String splashScreen = "splashScreen";
  static const String signInScreen = "signInScreen";
  static const String signUpScreen = "signUpScreen";
  static const String homeScreen = "homeScreen";
  static const String productDetail = "productDetail";
  static const String cartScreen = "cartScreen";
  static const String categoryProductScreen = "categoryProductScreen";
  static const String editProfileScreen = "editProfileScreen";
  static const String orderDetailScreen = "orderDetailScreen";
  static const String orderPlacedScreen = "orderPlacedScreen";
  static const String myOrderScreen = "myOrderScreen";
}