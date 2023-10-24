import 'bloc.dart';
import 'dart:async';
import 'package:ondago/models/user_model.dart';

/// Fetch data when open app ///
class UserBloc extends Bloc {
  final userController = StreamController<List<UserModel>>.broadcast();

  @override
  void dispose() {
    /// used to close stream Or StreamController will cause leak issue ///
    userController.close();
  }

}

UserBloc userBloc = UserBloc();