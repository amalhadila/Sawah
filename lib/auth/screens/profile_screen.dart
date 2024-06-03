import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/auth/cubit/user_cubit.dart';
import 'package:graduation/auth/cubit/user_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is GetUserFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to load user data: ${state.errorMessage}'),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is GetUserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetUserSuccess) {
          return ListView(
            children: [
              const SizedBox(height: 16),
              //! Profile Picture
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(state.user.data.photo),
              ),
              const SizedBox(height: 16),
              //! Name
              ListTile(
                title: Text(state.user.data.name),
                leading: Icon(Icons.person),
              ),
              const SizedBox(height: 16),
              //! Email
              ListTile(
                title: Text(state.user.data.email),
                leading: Icon(Icons.email),
              ),
              const SizedBox(height: 16),
            ],
          );
        } else if (state is GetUserFailure) {
          return Center(
            child: Text(
              'Unexpected state: ${state.errorMessage}',
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
