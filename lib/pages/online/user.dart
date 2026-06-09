import 'package:bmusic/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPage extends StatelessWidget {
    const UserPage({super.key});

    @override
    Widget build(BuildContext context) {
        return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is Authenticated) {
                final user = state.user;

                return Padding(padding: const EdgeInsets.all(16),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('${user.first_name} ${user.last_name}', style: Theme.of(context).textTheme.headlineSmall),
                        Text('@${user.username}'),
                        const SizedBox(height: 10),
                        Text(user.email ?? 'No email'),
                        const SizedBox(height: 20),
                        ElevatedButton(onPressed: () {
                            context.read<AuthBloc>().add(SignOut());},
                            child: const Text('Sign Out'),
                        ),
                    ]),
                );
            } else {
              return const Center(child: Text('Not authenticated'));
            }
        });
    }
}