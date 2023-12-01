import 'package:demo_api_app/app/cubit/app_cubit.dart';
import 'package:demo_api_app/managers/user/manager.dart';
import 'package:demo_api_app/services/user/service.dart';
import 'package:demo_api_app/services/user/service_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../firebase_options.dart';

GetIt locator = GetIt.I;

Future<void> setupDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  locator.registerSingleton(AppCubit());
  locator.registerSingleton(UserManager());
  locator.registerFactory<UserService>(() => FirestoreUserService());
}
