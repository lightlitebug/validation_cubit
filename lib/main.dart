import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/signin/signin_cubit.dart';
import 'signin_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SigninCubit>(
          create: (context) => SigninCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Validation',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SigninPage(),
      ),
    );
  }
}
