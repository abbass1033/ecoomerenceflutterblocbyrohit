import 'dart:developer';

import 'package:ecoomerenceflutterblocbyrohit/logics/cart_cubit/cart_cubit.dart';
import 'package:ecoomerenceflutterblocbyrohit/logics/category_cubit/category_cubit.dart';
import 'package:ecoomerenceflutterblocbyrohit/logics/order/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/colors.dart';
import 'core/routes.dart';
import 'logics/product_cubit/product_cubit.dart';
import 'logics/user_cubit/user_cubit.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => CategoryCubit()),
        BlocProvider(create: (context) => ProductCubit()),
        BlocProvider(create: (context) => CartCubit(
          BlocProvider.of<UserCubit>(context)
        )),

        BlocProvider(create: (context) => OrderCubit(
            BlocProvider.of<UserCubit>(context)
        )),
      ],
      child: MaterialApp(
        theme: Themes.defaultTheme,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        onGenerateRoute: Routes.onGenerateRoutes,
        initialRoute: RoutesName.signInScreen,
      ),
    );
  }
}


class MyBlocObserver extends BlocObserver{
  @override
  void onCreate(BlocBase bloc) {
    // TODO: implement onCreate
    log("created : $bloc");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    // TODO: implement onChange

    log("change in $change");
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition

    log("on Transition : $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
    log("on error $error");
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    // TODO: implement onClose

    log("on closed $bloc");
    super.onClose(bloc);
  }
}
