part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState{}

class UserLoggedInState extends UserState{
  final UserModel userModel;
  UserLoggedInState({required this.userModel});
}

class UserLogoutState extends UserState{}

class UserErrorState extends UserState{

  final String message;
  UserErrorState({required this.message});

}


