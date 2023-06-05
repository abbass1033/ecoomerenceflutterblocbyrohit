

import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logics/user_cubit/user_cubit.dart';

class LoginProvider with ChangeNotifier{

  final BuildContext context;

  LoginProvider(this.context){
    _listenToUserCubit();
  }
  bool isLoading = false;
  String error = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  StreamSubscription? _userSubscription;

  final formKey = GlobalKey<FormState>();

  void _listenToUserCubit(){

    log("listening to user state ...");
   _userSubscription = BlocProvider.of<UserCubit>(context).stream.listen((userState) {

      if(userState is UserLoadingState){
        isLoading = false;
        error = "";
        notifyListeners();
      }
      else if(userState is UserErrorState){
        isLoading = false;
        error = userState.message;
        notifyListeners();
      }
      else{
        isLoading = false;
        error = "";
        notifyListeners();
      }
    });

  }

  void logIn(){

    if(!formKey.currentState!.validate()) return null;

    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    BlocProvider.of<UserCubit>(context).signIn(email: email, password: password);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _userSubscription?.cancel();
    super.dispose();
  }

}