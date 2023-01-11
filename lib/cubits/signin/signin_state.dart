part of 'signin_cubit.dart';

enum SigninStatus { initial, submitting, success, failure }

class SigninState extends Equatable {
  final String email;
  final String password;
  final SigninStatus status;
  final String error;
  final AutovalidateMode autovalidateMode;
  const SigninState({
    required this.email,
    required this.password,
    required this.status,
    required this.error,
    required this.autovalidateMode,
  });

  factory SigninState.initial() {
    return const SigninState(
      email: '',
      password: '',
      status: SigninStatus.initial,
      error: '',
      autovalidateMode: AutovalidateMode.disabled,
    );
  }

  @override
  List<Object> get props => [email, password, status, error, autovalidateMode];

  @override
  String toString() {
    return 'SigninState(email: $email, password: $password, status: $status, error: $error, autovalidateMode: $autovalidateMode)';
  }

  SigninState copyWith({
    String? email,
    String? password,
    SigninStatus? status,
    String? error,
    AutovalidateMode? autovalidateMode,
  }) {
    return SigninState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      error: error ?? this.error,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
    );
  }
}
