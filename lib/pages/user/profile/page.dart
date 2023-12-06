import 'dart:io';

import 'package:demo_api_app/pages/user/profile/cubit/user_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  static Route<UserProfilePage> get route =>
      MaterialPageRoute(builder: (_) => const UserProfilePage());

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
        body: BlocConsumer<UserProfileCubit, UserProfileState>(
          listener: (context, state) {
            if (state is UserProfileUpdated) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state is UserProfileLoaded) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.symmetric(
                      vertical: 32,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        4,
                      ),
                      color: Colors.grey[200],
                    ),
                    child: GestureDetector(
                      onTap: () => context.read<UserProfileCubit>().pickImage(),
                      child: Stack(
                        children: [
                          if (state.imageFile != null)
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Image.file(
                                File(state.imageFile!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          const Center(
                            child: Icon(Icons.image),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<UserProfileCubit>().saveUser({}),
                    child: const Text('Save'),
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
