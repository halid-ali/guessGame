import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guessGame/data/blocs/bloc_provider.dart';
import 'package:guessGame/data/blocs/user_bloc.dart';
import 'package:guessGame/data/models/user_model.dart';
import 'package:guessGame/utils/constants.dart';
import 'package:guessGame/widgets/app_bar.dart';
import 'package:intl/intl.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Constants.appBarHeight),
          child: CustomAppBar(title: AppLocalizations.of(context).users),
        ),
        body: BlocProvider(
          bloc: UsersBloc(),
          child: UserList(),
        ),
      ),
    );
  }
}

class UserList extends StatefulWidget {
  UserList({Key key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  UsersBloc _usersBloc;

  @override
  void initState() {
    super.initState();
    _usersBloc = BlocProvider.of<UsersBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: _usersBloc.users,
            builder: (
              BuildContext context,
              AsyncSnapshot<List<User>> snapshot,
            ) {
              if (snapshot.hasData) {
                if (snapshot.data.length == 0) {
                  return Center(child: Text('No registered users.'));
                }

                List<User> users = snapshot.data;

                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    User user = users[index];

                    //TODO: Users cards will be clickable
                    //TODO: Improve design of cards

                    return GestureDetector(
                      onTap: () {
                        print(user.username);
                      },
                      child: Card(
                        color: Colors.grey[200],
                        shadowColor: Colors.grey[800],
                        elevation: 2,
                        borderOnForeground: true,
                        child: Container(
                          margin: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Icon(Icons.account_box, size: 60),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getText(AppLocalizations.of(context).username,
                                      true),
                                  getText(
                                      AppLocalizations.of(context).email, true),
                                  getText(AppLocalizations.of(context).register,
                                      true),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getText(':', true),
                                  getText(':', true),
                                  getText(':', true),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getText(user.username, false),
                                  getText(user.email, false),
                                  getText(
                                      DateFormat('yyyy.MM.dd – kk:mm')
                                          .format(user.registerDate),
                                      false),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }

  Text getText(String value, bool isHeader) {
    Color color = isHeader ? Colors.pink : Colors.black;
    return Text(
      value,
      style: TextStyle(color: color, fontSize: 11),
    );
  }
}
