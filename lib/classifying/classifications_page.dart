import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ClassificationsPage extends StatelessWidget {
  final List<String> phraseList;
  final List<int> selectedPhrasePosList;
  final String groupId;
  final ClassGroup groupData;
  final Map<String, ClassCategory> category;
  final Function(String) onSelectCategory;
  final List<String> selectedCategoryIdList;
  final VoidCallback onSaveClassification;
  final VoidCallback onSetNullSelectedCategoryIdOld;

  const ClassificationsPage({
    Key? key,
    required this.phraseList,
    required this.selectedPhrasePosList,
    required this.groupId,
    required this.groupData,
    required this.category,
    required this.onSelectCategory,
    required this.selectedCategoryIdList,
    required this.onSaveClassification,
    required this.onSetNullSelectedCategoryIdOld,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            onSetNullSelectedCategoryIdOld();
            Navigator.pop(context);
          },
        ),
        title: Text('Análise ${groupData.title}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 28, color: Colors.black),
                  children: buildPhrase(context),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.black12,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('clique para escolher uma ou mais opções'),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: buildCategories(context),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(AppIconData.saveInCloud),
        onPressed: () {
          onSaveClassification();
        },
      ),
    );
  }

  List<InlineSpan> buildPhrase(context) {
    List<InlineSpan> list = [];
    for (var wordPos = 0; wordPos < phraseList.length; wordPos++) {
      list.add(
        TextSpan(
          text: phraseList[wordPos],
          style: selectedPhrasePosList.contains(wordPos)
              ? TextStyle(color: Colors.red)
              : null,
          // recognizer: TapGestureRecognizer()
          //   ..onTap = () {
          // setState(() {});
          // setPhraseSelected(wordPos);
          // },
        ),
      );
      list.add(TextSpan(
        text: ' ',
      ));
    }

    return list;
  }

  List<Widget> buildCategories(context) {
    List<Widget> list = [];

    for (var item in category.entries) {
      list.add(Row(
        children: [
          Expanded(
            child: ListTile(
              tileColor: selectedCategoryIdList.contains(item.key)
                  ? Colors.yellow.shade200
                  : null,
              title: Text('${item.value.title}'),
              subtitle: Text('${item.key}'),
              onTap: () {
                print('${item.key}');
                onSelectCategory(item.key);
              },
            ),
          ),
          Container(
            child: item.value.url != null && item.value.url!.isNotEmpty
                ? IconButton(
                    onPressed: () async {
                      bool can = await canLaunch(item.value.url!);
                      if (can) {
                        await launch(item.value.url!);
                      }
                    },
                    icon: Icon(AppIconData.linkOn))
                : IconButton(onPressed: null, icon: Icon(AppIconData.linkOff)),
          )
        ],
      ));
    }
    return list;
  }
}