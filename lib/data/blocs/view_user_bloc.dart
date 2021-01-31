import 'dart:async';

import 'package:guessGame/data/blocs/bloc_provider.dart';
import 'package:guessGame/data/database.dart';
import 'package:guessGame/data/models/user_model.dart';

class ViewUserBloc extends BlocBase {
  final _saveUserController = StreamController<User>.broadcast();
  StreamSink<User> get inSaveUser => _saveUserController.sink;

  final _deleteUserController = StreamController<int>.broadcast();
  StreamSink<int> get inDeleteUser => _deleteUserController.sink;

  final _userDeletedController = StreamController<bool>.broadcast();
  StreamSink<bool> get _inDeleted => _userDeletedController.sink;
  Stream<bool> get deleted => _userDeletedController.stream;

  ViewUserBloc() {
    _saveUserController.stream.listen(_handleSaveUser);
    _deleteUserController.stream.listen(_handleDeleteUser);
  }

  void _handleSaveUser(User user) async {
    await DatabaseProvider.dbProvider.updateUser(user);
  }

  void _handleDeleteUser(int id) async {
    await DatabaseProvider.dbProvider.deleteUser(id);
    _inDeleted.add(true);
  }

  @override
  void dispose() {
    _saveUserController.close();
    _deleteUserController.close();
    _userDeletedController.close();
  }
}
