import 'package:demo_api_app/pages/user/profile/cubit/user_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserProfileCubit>(
      create: (context) => UserProfileCubit()..initialize(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Update',
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    4,
                  ),
                  color: Colors.grey[200],
                ),
                child: Center(
                  child: Icon(Icons.image),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
