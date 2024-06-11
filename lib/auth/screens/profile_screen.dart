import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/auth/cubit/user_cubit.dart';
import 'package:graduation/auth/cubit/user_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is GetUserFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('n'),
          ),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        body: state is GetUserLoading
            ? const CircularProgressIndicator()
            : state is GetUserSuccess
                ? ListView(
                    children: [
                      const SizedBox(height: 16),
                      //! Profile Picture
                      CircleAvatar(
                        radius: 80,
                        child: Image.asset(state.user.data.photo),
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

                      //! Phone number

                      //! Address
                      const ListTile(
                        title: Text("Address"),
                        leading: Icon(Icons.location_city),
                      ),
                      const SizedBox(height: 16),
                    ],
                  )
                : Container(),
      );
    });
  }
}
