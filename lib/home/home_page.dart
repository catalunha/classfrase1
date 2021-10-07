import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/phrase/phrase_card.dart';
import 'package:classfrase/theme/app_colors.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String photoUrl;
  final String displayName;
  final String email;
  final String uid;
  final String id;
  final VoidCallback signOut;
  final List<PhraseModel> phraseList;

  const HomePage({
    Key? key,
    required this.photoUrl,
    required this.displayName,
    required this.signOut,
    required this.email,
    required this.uid,
    required this.id,
    required this.phraseList,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: SafeArea(
          child: Container(
            // height: 80,
            color: AppColors.primary,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Olá, $displayName',
                  style: AppTextStyles.titleRegular,
                ),
                Spacer(),
                PopupMenuButton(
                  child: Tooltip(
                    message: 'email: $email\nid: $id\nuid: $uid',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        photoUrl,
                        height: 58,
                        width: 58,
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: InkWell(
                          child: Row(
                            children: [
                              Icon(AppIconData.info),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Informações'),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/information');
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: InkWell(
                          child: Row(
                            children: [
                              Icon(AppIconData.coffee),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Contribuir'),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/coffee');
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: InkWell(
                          child: Row(
                            children: [
                              Icon(AppIconData.exit),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Sair'),
                            ],
                          ),
                          onTap: () {
                            signOut();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ];
                  },
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          uid == '4P3NEIkWqng0t5aal0fae5RdYHj1'
              ? Wrap(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/group',
                        );
                      },
                      child: Text('UpdateClassificationsDocs'),
                    ),
                  ],
                )
              : Container(),
          Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  width: 180,
                  child: Card(
                    elevation: 10,
                    margin: EdgeInsets.all(20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/phrase_addedit',
                          arguments: '',
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 10),
                            Icon(
                              AppIconData.phrase,
                              size: 50.0,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Criar\nFrase',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.titleRegular,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 180,
                  child: Card(
                    elevation: 10,
                    margin: EdgeInsets.all(20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/observer_list',
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 10),
                            Icon(
                              AppIconData.eye,
                              size: 50.0,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Observar\nFrases',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.titleRegular,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  height: 30,
                  color: Colors.black12,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Frases em classificação ',
                        style: AppTextStyles.trailingBold,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: Colors.white,
                      child: IconButton(
                        tooltip: 'Minhas frases arquivadas',
                        icon: Icon(AppIconData.box),
                        onPressed: () {
                          Navigator.pushNamed(context, '/phrase_archived');
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: buildItens(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildItens(context) {
    List<Widget> list = [];
    // List<PhraseModel> phraseListSorted =
    phraseList.sort((a, b) => a.phrase.compareTo(b.phrase));
    for (var phrase in phraseList) {
      list.add(Container(
        key: ValueKey(phrase),
        child: PhraseCard(
          phrase: phrase,
          trailing: phrase.observer!.isEmpty
              ? null
              : Tooltip(
                  message: 'Esta frase esta sendo observada.',
                  child: Icon(AppIconData.eye)),
          widgetList: [
            IconButton(
              tooltip: 'Classificar esta frase',
              icon: Icon(AppIconData.letter),
              onPressed: () async {
                Navigator.pushNamed(context, '/classifying',
                    arguments: phrase.id);
              },
            ),
            SizedBox(
              width: 50,
            ),
            IconButton(
              tooltip: 'Editar esta frase',
              icon: Icon(AppIconData.edit),
              onPressed: () async {
                Navigator.pushNamed(context, '/phrase_addedit',
                    arguments: phrase.id);
              },
            ),
          ],
        ),
      ));
    }
    if (list.isEmpty) {
      list.add(ListTile(
        leading: Icon(AppIconData.smile),
        title: Text('Ops. Vc ainda não criou nenhuma frase.'),
      ));
    }
    return list;
  }
}
