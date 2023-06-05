

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logics/user_cubit/user_cubit.dart';

class SignupProvider with ChangeNotifier{
  final BuildContext context;
  SignupProvider({required this.context}){
    _listToUserCubit();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  StreamSubscription? _userSubscription;

  bool isLoading = false;
  String error = "";


  void _listToUserCubit(){
    _userSubscription = BlocProvider.of<UserCubit>(context).stream.listen((userState) {

      if(userState is UserLoadingState){

        isLoading = true;
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

  void createAccount(){
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    BlocProvider.of<UserCubit>(context).createAccount(email: email, password: password);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _userSubscription?.cancel();
    super.dispose();
  }
}