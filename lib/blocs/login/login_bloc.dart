import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:score_square/blocs/sign_up/sign_up_bloc.dart';
import 'package:score_square/constants.dart';
import 'package:score_square/service_locator.dart';
import 'package:score_square/services/validation_service.dart';
import 'package:score_square/widgets/custom_button.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_page.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  static final Box<dynamic> _loginCredentialsBox =
      Hive.box<String>(hiveBoxLoginCredentials);

  bool _passwordVisible = false;
  bool _rememberMe = _loginCredentialsBox.get('email') != null;

  LoginBloc()
      : super(LoginInitialState(
          passwordVisible: false,
          rememberMe: _loginCredentialsBox.get('email') != null,
        )) {
    on<LoginSubmitEvent>((event, emit) async {
      final String email = event.email;
      final String password = event.password;

      try {
        emit(LoginLoadingState());

        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        //Save users email and password if remember me box checked.
        if (_rememberMe) {
          _loginCredentialsBox.put('email', email);
          _loginCredentialsBox.put('password', password);
        } else {
          _loginCredentialsBox.clear();
        }

        emit(
          LoginInitialState(
            passwordVisible: _passwordVisible,
            rememberMe: _rememberMe,
          ),
        );
      } catch (error) {
        emit(
          LoginErrorState(
            error: error,
          ),
        );
      }
    });
    on<LoginTryAgainEvent>((event, emit) {
      emit(
        LoginInitialState(
          passwordVisible: _passwordVisible,
          rememberMe: _rememberMe,
        ),
      );
    });
    on<LoginUpdatePasswordVisibleEvent>((event, emit) {
      _passwordVisible = !_passwordVisible;
      emit(
        LoginInitialState(
            passwordVisible: _passwordVisible, rememberMe: _rememberMe),
      );
    });
    on<LoginUpdateRememberMeEvent>((event, emit) {
      _rememberMe = !_rememberMe;
      emit(
        LoginInitialState(
            passwordVisible: _passwordVisible, rememberMe: _rememberMe),
      );
    });
  }
}
