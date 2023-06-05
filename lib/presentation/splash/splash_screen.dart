import 'dart:async';

import 'package:ecoomerenceflutterblocbyrohit/core/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logics/user_cubit/user_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(milliseconds: 1000), () {
      goToNext();
    });

    super.initState();
  }

  void goToNext() {
    UserState userState = BlocProvider
        .of<UserCubit>(context)
        .state;

    if (userState is UserLoggedInState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, RoutesName.homeScreen);
    }
    else if (userState is UserLogoutState) {
      Navigator.pushReplacementNamed(context, RoutesName.signInScreen);
    }
    else if (userState is UserErrorState) {
      Navigator.pushReplacementNamed(context, RoutesName.signInScreen);
    }
    else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        // TODO: implement listener
        goToNext();
      },
      child: Scaffold(
        body: Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}
