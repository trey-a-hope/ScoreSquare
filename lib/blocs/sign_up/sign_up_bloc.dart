import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/pages/terms_service_page.dart';
import 'package:score_square/services/auth_service.dart';
import 'package:score_square/services/modal_service.dart';
import 'package:score_square/services/user_service.dart';
import 'package:score_square/services/validation_service.dart';
import 'package:score_square/widgets/custom_button.dart';
import '../../constants.dart';
import '../../service_locator.dart';

part 'sign_up_event.dart';
part 'sign_up_page.dart';
part 'sign_up_state.dart';

abstract class SignUpBlocDelegate {
  void navigateHome();
  void navigateToTermsServicePage();
  void showMessage({required String message});
}

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc()
      : super(
          SignUpStartState(
            termsServicesChecked: false,
          ),
        );

  SignUpBlocDelegate? _signUpBlocDelegate;
  bool _termsServicesChecked = false;

  void setDelegate({required SignUpBlocDelegate delegate}) {
    _signUpBlocDelegate = delegate;
  }

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUp) {
      try {
        yield LoadingState();

        final String email = event.email;
        final String password = event.password;
        final String username = event.username;

        final UserCredential userCredential = await locator<AuthService>()
            .createUserWithEmailAndPassword(email: email, password: password);

        final User firebaseUser = userCredential.user!;

        UserModel newUser = UserModel(
          imgUrl: null,
          email: email,
          created: DateTime.now(),
          modified: DateTime.now(),
          uid: firebaseUser.uid,
          username: username,
          fcmToken: null,
        );

        await locator<UserService>().createUser(user: newUser);

        // final UserModel treyHopeUser =
        //     await locator<UserService>().retrieveUser(uid: TREY_HOPE_UID);

        // await locator<FCMNotificationService>().sendNotificationToUser(
        //   fcmToken: treyHopeUser.fcmToken!,
        //   title: 'New User!',
        //   body: newUser.username,
        //   notificationData: null,
        // );

        _signUpBlocDelegate!.navigateHome();

        yield SignUpStartState(termsServicesChecked: _termsServicesChecked);
      } catch (error) {
        _signUpBlocDelegate!.showMessage(message: 'Error: ${error.toString()}');
        yield SignUpStartState(termsServicesChecked: _termsServicesChecked);
      }
    }

    if (event is NavigateToTermsServicePageEvent) {
      _signUpBlocDelegate!.navigateToTermsServicePage();
    }

    if (event is TermsServiceCheckboxEvent) {
      _termsServicesChecked = event.checked;

      yield SignUpStartState(
        termsServicesChecked: _termsServicesChecked,
      );
    }
  }
}
