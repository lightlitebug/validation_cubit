import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

import 'cubits/signin/signin_cubit.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submit(state) {
    context.read<SigninCubit>().setAutoValidateMode();
    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    // print('email: ${state.email}, password: ${state.password}');

    context.read<SigninCubit>().signin();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state.status == SigninStatus.failure) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(state.error),
              );
            },
          );
        }
      },
      builder: (context, state) {
        // print(state);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Validation'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                autovalidateMode: state.autovalidateMode,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Email'),
                      onSaved: (value) {
                        context.read<SigninCubit>().emailSaved(value!);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email required';
                        }
                        if (!isEmail(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Password'),
                      obscureText: true,
                      onSaved: (value) {
                        context.read<SigninCubit>().passwordSaved(value!);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password required';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: state.status == SigninStatus.submitting
                          ? null
                          : () => _submit(state),
                      child: Text(
                        state.status == SigninStatus.submitting
                            ? 'Submitting...'
                            : 'Sign In',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
