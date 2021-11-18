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
  static final Box<dynamic> _userCredentialsBox =
      Hive.box<String>(hiveBoxUserCredentials);

  bool _passwordVisible = false;
  bool _rememberMe = _userCredentialsBox.get('email') != null;

  LoginBloc()
      : super(InitialState(
          passwordVisible: false,
          rememberMe: _userCredentialsBox.get('email') != null,
        )) {
    on<SubmitEvent>((event, emit) async {
      final String email = event.email;
      final String password = event.password;

      try {
        emit(LoadingState());

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        //Save users email and password if remember me box checked.
        if (_rememberMe) {
          _userCredentialsBox.put('email', email);
          _userCredentialsBox.put('password', password);
        } else {
          _userCredentialsBox.clear();
        }

        //Save users uid.
        _userCredentialsBox.put('uid', userCredential.user!.uid);
      } catch (error) {
        emit(
          ErrorState(
            error: error,
          ),
        );
      }
    });
    on<TryAgainEvent>((event, emit) {
      emit(
        InitialState(
          passwordVisible: _passwordVisible,
          rememberMe: _rememberMe,
        ),
      );
    });
    on<UpdatePasswordVisibleEvent>((event, emit) {
      _passwordVisible = !_passwordVisible;
      emit(
        InitialState(
            passwordVisible: _passwordVisible, rememberMe: _rememberMe),
      );
    });
    on<UpdateRememberMeEvent>((event, emit) {
      _rememberMe = !_rememberMe;
      emit(
        InitialState(
            passwordVisible: _passwordVisible, rememberMe: _rememberMe),
      );
    });
  }
}
