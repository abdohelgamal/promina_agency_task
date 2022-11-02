import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/controllers/auth/auth_states.dart';
import 'package:task/data/abstract/api_helper.dart';
import 'package:task/data/abstract/hive_helper.dart';
import 'package:task/data/controller_helpers/auth_api_helper.dart';

class AuthCubit extends Cubit<AuthAbstractState> {
  AuthCubit() : super(AuthInitialState());
  Future<void> login(
    String email,
    String password,
  ) async {
    emit(AuthLoadingState());
    await AuthApiHelper.login(email, password).then((value) async {
      if (value.data['error_message'] == null) {
        await HiveHelper.storeToken(value.data['token']);
        ApiHelper.setToken(value.data['token']);
        emit(AuthSuccessState());
      } else {
        emit(AuthErrorState(value.data['error_message']));
      }
    });
  }

  Future<void> logout() async {
    HiveHelper.logOut();
    ApiHelper.deleteToken();
  }
}
