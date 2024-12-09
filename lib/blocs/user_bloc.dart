import 'package:bmusic/blocs/states/user_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class UserBloc extends Cubit<UserState>{
    UserBloc(): super(UserState());
}