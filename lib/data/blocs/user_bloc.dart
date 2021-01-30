import 'dart:async';

import 'package:guessGame/data/blocs/bloc_provider.dart';
import 'package:guessGame/data/database.dart';
import 'package:guessGame/data/models/user_model.dart';

class UsersBloc implements BlocBase {
  final _usersController = StreamController<List<User>>.broadcast();
  StreamSink<List<User>> get _inUsers => _usersController.sink;
  Stream<List<User>> get users => _usersController.stream;

  final _addUserController = StreamController<User>.broadcast();
  StreamSink<User> get inUserAdd => _addUserController.sink;

  UsersBloc() {
    getUsers();
    _addUserController.stream.listen(_handleAddUser);
  }

  void getUsers() async {
    List<User> users = await DatabaseProvider.dbProvider.getUsers();
    _inUsers.add(users);
  }

  void _handleAddUser(User user) async {
    await DatabaseProvider.dbProvider.addUser(user);
    getUsers();
  }

  @override
  void dispose() {
    _usersController.close();
    _addUserController.close();
  }
}
