import 'package:classfrase/theme/app_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ClassifyingPage extends StatefulWidget {
  final List<String> phraseList;
  final List<int> selectedPhrasePosList;
  final Function(int) setPhraseSelected;

  const ClassifyingPage({
    Key? key,
    required this.phraseList,
    required this.selectedPhrasePosList,
    required this.setPhraseSelected,
  }) : super(key: key);

  @override
  _ClassifyingPageState createState() => _ClassifyingPageState();
}

class _ClassifyingPageState extends State<ClassifyingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classificando ${widget.selectedPhrasePosList.length}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 28, color: Colors.black),
                  children: buildItens(context),
                ),
              ),
            ),
          ),
          Wrap(
            children: [
              IconButton(onPressed: () {}, icon: Icon(AppIconData.addInCloud))
            ],
          )
        ],
      ),
    );
  }

  List<InlineSpan> buildItens(context) {
    List<InlineSpan> list = [];
    for (var wordPos = 0; wordPos < widget.phraseList.length; wordPos++) {
      list.add(TextSpan(
        text: widget.phraseList[wordPos],
        style: widget.selectedPhrasePosList.contains(wordPos)
            ? TextStyle(color: Colors.red)
            : null,
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            setState(() {});
            widget.setPhraseSelected(wordPos);
          },
      ));
      list.add(TextSpan(
        text: ' ',
      ));
    }

    return list;
  }
}
