import 'package:bloc/bloc.dart';
import 'package:ecoomerenceflutterblocbyrohit/logics/services/preferences.dart';
import 'package:meta/meta.dart';

import '../../data/model/user/userModel.dart';
import '../../data/repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState()){
    _initialize();
  }

  final UserRepository _userRepository = UserRepository();

  void _initialize()async{
    final userDetail = await Preferences.fetchUserDetails();
    String email = userDetail["email"];
    String password = userDetail["password"];

    if(email == null || password == null){
      emit(UserLogoutState());
    }
    else{
      signIn(email: email, password: password);
    }
  }

  void _emitLoggedInState({
    required UserModel userModel,
    required String email ,
    required String password})async{

    await Preferences.saveUserDetails(email, password);
    emit(UserLoggedInState(userModel: userModel));


  }

  void signIn({required String email , required String password})async{

    emit(UserLoadingState());
    try{

      UserModel userModel = await _userRepository.signIn(email: email, password: password);
      _emitLoggedInState(userModel: userModel , email: email , password: password);


    }
    catch(e){
      emit(UserErrorState(message: e.toString()));
    }

  }


  void createAccount({required String email , required String password})async{

    emit(UserLoadingState());
    try{

      UserModel userModel = await _userRepository.createAccount(email: email, password: password);
      _emitLoggedInState(userModel: userModel, email: email, password: password);


    }
    catch(e){
      emit(UserErrorState(message: e.toString()));
    }

  }


  Future<bool> updateUser(UserModel userModel) async {
    emit( UserLoadingState() );
    try {
      UserModel updatedUser = await _userRepository.updateUser( userModel);
      emit( UserLoggedInState(userModel: updatedUser) );
      return true;
    }
    catch(ex) {
      emit( UserErrorState(message: ex.toString()));
      return false;
    }
  }


  void signOut()async{
    await Preferences.clear();

    emit(UserLogoutState());
  }


}
