import 'package:demo_api_app/app/cubit/app_cubit.dart';
import 'package:demo_api_app/app/notifier/app_provider.dart';
import 'package:demo_api_app/pages/user/state_ful.dart';
import 'package:demo_api_app/services/locator.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class DemoContactApp extends StatelessWidget {
  const DemoContactApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserStatefulPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyApp extends StatelessWidget {
  ///
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final providers = [EmailAuthProvider()];

    return MultiProvider(
      providers: [
        BlocProvider(create: (_) {
          // final cubit = AppCubit();
          // cubit.initialize();
          // return cubit;
          // or
          return AppCubit()..initialize();
        }),
        //ChangeNotifierProvider(create: (_) => AppProvider())
      ],
      child: BlocBuilder<AppCubit, AppState>(
        //selector: (context, provider) => provider.user,
        builder: (context, state) {
          return MaterialApp(
            key: ValueKey(state.user.id),
            initialRoute: state.user.isEmpty ? '/sign-in' : '/profile',
            // initialRoute: FirebaseAuth.instance.currentUser == null
            //     ? '/sign-in'
            //     : '/profile',
            routes: {
              '/sign-in': (context) {
                return SignInScreen(
                  providers: providers,
                  actions: [
                    AuthStateChangeAction<SignedIn>((context, state) {
                      if (state.user != null) {
                        context.read<AppCubit>().onUserLogin(state.user!);
                        //context.read<AppProvider>().onUserLogin(state.user!);
                        //Navigator.pushReplacementNamed(context, '/profile');
                      }
                    }),
                  ],
                );
              },
              '/profile': (context) {
                return ProfileScreen(
                  providers: providers,
                  actions: [
                    SignedOutAction((context) {
                      //Navigator.pushReplacementNamed(context, '/sign-in');
                      locator<AppCubit>().onUserLogout();
                    }),
                  ],
                );
              },
            },
          );
        },
      ),
    );
  }
}
