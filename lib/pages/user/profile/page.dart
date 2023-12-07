import 'dart:io';

import 'package:demo_api_app/pages/user/profile/cubit/user_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  static Route<UserProfilePage> get route =>
      MaterialPageRoute(builder: (_) => const UserProfilePage());

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formMap = {};
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
              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _container(state),
                      _labelText("Name"),
                      _name,
                      SizedBox(height: 15),
                      _labelText("Email"),
                      _email,
                      SizedBox(height: 15),
                      _labelText("Phone"),
                      _phone,
                      SizedBox(height: 15),
                      _labelText("Address"),
                      _address,
                      SizedBox(height: 15),
                      _labelText("Company"),
                      _company,
                      SizedBox(height: 15),
                      _labelText("Website"),
                      _website,
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<UserProfileCubit>().saveUser({}),
                        child: const Text('Save'),
                      )
                    ],
                  ),
                ),
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

  _container(UserProfileLoaded state) => Container(
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
      );
  _labelText(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: TextStyle(fontSize: 15, color: Colors.black),
      ),
    );
  }

  Widget get _name => TextFormField(
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: "Name",
            hintStyle: const TextStyle(fontSize: 15, color: Colors.black)),
        keyboardType: TextInputType.name,
        onSaved: (String? value) {
          formMap['name'] = value?.trim() ?? '';
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Name is required";
          }
          return null;
        },
      );

  Widget get _email => TextFormField(
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: "Email",
            hintStyle: const TextStyle(fontSize: 15, color: Colors.black)),
        keyboardType: TextInputType.name,
        onSaved: (String? value) {
          formMap['email'] = value?.trim() ?? '';
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Email is required";
          }
          return null;
        },
      );
  Widget get _phone => TextFormField(
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: "Phone",
            hintStyle: const TextStyle(fontSize: 15, color: Colors.black)),
        keyboardType: TextInputType.name,
        onSaved: (String? value) {
          formMap['phone'] = value?.trim() ?? '';
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Phone is required";
          }
          return null;
        },
      );

  Widget get _address => TextFormField(
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: "Address",
            hintStyle: const TextStyle(fontSize: 15, color: Colors.black)),
        keyboardType: TextInputType.name,
        onSaved: (String? value) {
          formMap['address'] = value?.trim() ?? '';
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Address is required";
          }
          return null;
        },
      );
  Widget get _company => TextFormField(
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: "Company",
            hintStyle: const TextStyle(fontSize: 15, color: Colors.black)),
        keyboardType: TextInputType.name,
        onSaved: (String? value) {
          formMap['company'] = value?.trim() ?? '';
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Company is required";
          }
          return null;
        },
      );
  Widget get _website => TextFormField(
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: "website",
            hintStyle: const TextStyle(fontSize: 15, color: Colors.black)),
        keyboardType: TextInputType.name,
        onSaved: (String? value) {
          formMap['website'] = value?.trim() ?? '';
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Website is required";
          }
          return null;
        },
      );
}
