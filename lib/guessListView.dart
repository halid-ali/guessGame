import 'package:flutter/material.dart';
import 'package:guessGame/guessListItem.dart';

class GuessListView extends StatefulWidget {
  final _GuessListViewState _guessListViewState = _GuessListViewState();

  void addItem(String guessString, int known, int correct, int wrong) {
    _guessListViewState._addItem(guessString, known, correct, wrong);
  }

  @override
  _GuessListViewState createState() => _guessListViewState;
}

class _GuessListViewState extends State<GuessListView> {
  final List<GuessListItem> _entries = <GuessListItem>[];
  final ScrollController _scrollController = ScrollController();
  int _itemIndex = 0;

  void _addItem(String guessString, int known, int correct, int wrong) {
    setState(() {
      _itemIndex++;
      _entries.add(GuessListItem(
        guess: guessString,
        index: _itemIndex,
        knownCount: known,
        correctCount: correct,
        wrongCount: wrong,
      ));
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        reverse: true,
        controller: _scrollController,
        padding: EdgeInsets.all(5),
        itemCount: _entries.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            padding: EdgeInsets.all(5),
            child: _entries[index],
          );
        },
        separatorBuilder: (context, index) => Divider(
          thickness: 1,
          color: Colors.grey,
          height: 7,
          indent: 5,
          endIndent: 5,
        ),
      ),
    );
  }
}
