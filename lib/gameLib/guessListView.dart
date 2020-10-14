import 'package:flutter/material.dart';
import 'package:guessGame/gameLib/guess.dart';
import 'package:guessGame/gameLib/guessListItem.dart';

typedef AddGuessCallback = Function(Guess guess);

class GuessListView extends StatefulWidget {
  final _GuessListViewState _guessListViewState = _GuessListViewState();

  @override
  _GuessListViewState createState() => _guessListViewState;

  void addGuess(Guess guess) {
    _guessListViewState.addGuess(guess);
  }
}

class _GuessListViewState extends State<GuessListView> {
  List<GuessListItem> _entries = List<GuessListItem>();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _entries.length,
      itemBuilder: (context, index) => _entries.reversed.toList()[index],
    );
  }

  void addGuess(Guess guess) {
    _index++;
    setState(() {
      _entries.add(GuessListItem(index: _index, guess: guess));
    });
  }
}
