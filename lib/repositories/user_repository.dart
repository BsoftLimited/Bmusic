import 'package:bmusic/repositories/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthResponse, Supabase, SupabaseClient;

class UserRepository{
    final SupabaseClient __supabase = Supabase.instance.client;

    Future<User> signUpWithEmail({ required String firstName, required String lastName, required String email, required String username, required String password }) async {
        try {
            final AuthResponse res = await __supabase.auth.signUp(
                email: email,
                password: password,
                data: { 'username': username, 'first_name': firstName, 'last_name': lastName },
            );

            if (res.user == null) {
                throw Exception('Sign up failed - no user returned');
            }

            // 2. Create profile in public.users table
            final response = await __supabase.from('users').upsert({ 'id': res.user!.id, 'email': email, 'username': username,
                'first_name': firstName, 'last_name': lastName }).single();

            return User.fromJson(response);
        } catch (e) {
            return Future.error(e);
        }
    }

    Future<User> loginWithEmail({ required String email, required String password }) async {
        try {
            final AuthResponse res = await __supabase.auth.signInWithPassword(
                email: email,
                password: password,
            );

            if (res.user == null) {
                throw Exception('Sign in failed - no user returned');
            }

            final response = await __supabase.from('users').select("*").eq( 'id', res.user!.id ).single();

            return User.fromJson(response);
        } catch (e) {
            return Future.error(e);
        }
    }

    Future<User> fetchUser() async{
        final user = __supabase.auth.currentUser;
        if(user == null){
            throw Exception("unable to fetch user detail, please try signing in again");
        }

        final id = user.id;
        final firstName = user.userMetadata!["first_name"];
        final lastName = user.userMetadata!["last_name"];
        final username = user.userMetadata!["username"];
        final email = user.userMetadata!["email"];

        return User(id: id, first_name: firstName, last_name: lastName, username: username, email: email);
    }

    Future<void> logout() async{
        await __supabase.auth.signOut();
    }
}