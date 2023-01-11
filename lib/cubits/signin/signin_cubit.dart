import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit() : super(SigninState.initial());

  void emailSaved(String email) {
    emit(state.copyWith(email: email));
  }

  void passwordSaved(String password) {
    emit(state.copyWith(password: password));
  }

  void setAutoValidateMode() {
    emit(state.copyWith(autovalidateMode: AutovalidateMode.always));
  }

  void signin() async {
    emit(state.copyWith(status: SigninStatus.submitting));

    try {
      await Future.delayed(const Duration(seconds: 2));
      print('email: ${state.email}, password: ${state.password}');

      // throw 'Network error';
      emit(state.copyWith(status: SigninStatus.success));
      print(state);
    } catch (e) {
      emit(state.copyWith(error: e.toString(), status: SigninStatus.failure));
      print(state);
    }
  }
}
