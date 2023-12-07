import 'dart:io';

import 'package:demo_api_app/models/user.dart';
import 'package:demo_api_app/pages/user/profile/cubit/user_profile_cubit.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
              if (formMap.isEmpty) {
                _setupInitialValue(state.user);
              }

              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _container(context, state),
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
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              _formKey.currentState!.save();
                              context
                                  .read<UserProfileCubit>()
                                  .saveUser(formMap);
                            }
                          },
                          child: const Text('Save'),
                        )
                      ],
                    ),
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

  void _setupInitialValue(User user) {
    formMap.addAll(user.toJson());
  }

  Widget _container(BuildContext context, UserProfileLoaded state) => Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            4,
          ),
          color: Colors.grey[200],
        ),
        child: GestureDetector(
          onTap: () => context.read<UserProfileCubit>().pickImage(),
          child: SizedBox(
            height: MediaQuery.of(context).size.width * 9 / 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
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
                    )
                  else if (state.user.hasImage)
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Image(
                        image: FirebaseImageProvider(
                          FirebaseUrl.fromReference(FirebaseStorage.instance
                              .ref(state.user.imageUrl)),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  const Center(
                    child: Icon(
                      Icons.image,
                      color: Colors.yellow,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _labelText(String label, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
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
          hintStyle: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        keyboardType: TextInputType.name,
        initialValue: formMap['name'],
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
        initialValue: formMap['email'],
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
        initialValue: formMap['phone'],
        onSaved: (String? value) {
          formMap['phone'] = value?.trim() ?? '';
        },
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return "Phone is required";
        //   }
        //   return null;
        // },
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
        initialValue: formMap['address'],
        onSaved: (String? value) {
          formMap['address'] = value?.trim() ?? '';
        },
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return "Address is required";
        //   }
        //   return null;
        // },
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
        initialValue: formMap['company']?['name'],
        onSaved: (String? value) {
          formMap['company'] = value?.trim() ?? '';
        },
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return "Company is required";
        //   }
        //   return null;
        // },
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
        initialValue: formMap['website'],
        onSaved: (String? value) {
          formMap['website'] = value?.trim() ?? '';
        },
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return "Website is required";
        //   }
        //   return null;
        // },
      );
}
