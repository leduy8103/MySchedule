import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_repository/schedule_repository.dart';
import 'package:task_management/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:task_management/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:task_management/screens/auth/views/welcome_screen.dart';
import 'package:task_management/screens/home/views/home_screen.dart';
import 'package:task_management/screens/schedule/blocs/set_schedule/set_schedule_bloc.dart';
import 'package:task_management/screens/schedule/views/schedule_screen.dart';
import 'package:user_repository/src/user_repo.dart';
import './screens/schedule/views/homePageState.dart';
import './screens/schedule/blocs/schedule_page/scheduleBloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Delivery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade200,
          onSurface: Colors.black,
          primary: Colors.blue,
          onPrimary: Colors.white,
        ),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: ((context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SignInBloc(
                      context.read<AuthenticationBloc>().userRepository),
                ),
                BlocProvider(
                  create: (context) => SetScheduleBloc(
                      scheduleRepository: context.read<
                          ScheduleRepository>()), // Cung cấp SetScheduleBloc
                ),
                BlocProvider(
                  create: (context) => scheduleBloc(),
                ),
              ],
              child: MaterialApp(
                title: 'Schedule App',
                theme: ThemeData(
                  primarySwatch: Colors.purple,
                ),
                home: HomePage(), // Main home page with bottom navigation bar
              ),
            );
          } else {
            return const WelcomeScreen();
          }
        }),
      ),
    );
  }
}
