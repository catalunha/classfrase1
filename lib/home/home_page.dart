import 'package:flutter/material.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/phrase/phrase_card.dart';
import 'package:classfrase/theme/app_colors.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/theme/app_text_styles.dart';

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
                    message:
                        'Clique aqui para outras opções.\nemail: $email\nid: ${id.substring(0, 3)} uid: ${uid.substring(0, 3)}',
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
          // uid == '4P3NEIkWqng0t5aal0fae5RdYHj1'
          //     ? Wrap(
          //         children: [
          //           TextButton(
          //             onPressed: () {
          //               Navigator.pushNamed(
          //                 context,
          //                 '/group',
          //               );
          //             },
          //             child: Text('seeClassificationsDocs'),
          //           ),
          //           TextButton(
          //             onPressed: () {
          //               Navigator.pushNamed(
          //                 context,
          //                 '/users',
          //               );
          //             },
          //             child: Text('seeUsersDocs'),
          //           ),
          //         ],
          //       )
          //     : Container(),
          Center(child: Text('Como deseja usar o ClassFrase ?')),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Tooltip(
                    message: 'Para criar uma frase e classificá-la.',
                    child: Container(
                      width: 130,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          '/phrase_addedit',
                          arguments: '',
                        ),
                        icon: Icon(AppIconData.phrase),
                        label: Text('Criar.'),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Tooltip(
                    message:
                        'Para observar frases em classificação em tempo real.',
                    child: Container(
                      width: 130,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          '/observer_list',
                        ),
                        icon: Icon(AppIconData.eye),
                        label: Text('Observar.'),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Tooltip(
                    message:
                        'Para aprender com a classificação de outras pessoas.',
                    child: Container(
                      width: 130,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          '/learn',
                        ),
                        icon: Icon(AppIconData.learn),
                        label: Text('Aprender.'),
                      ),
                    ),
                  ),
                ],
              ),
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
                        'Minhas frases em classificação ',
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
    phraseList.sort((a, b) => a.phrase.compareTo(b.phrase));
    for (var phrase in phraseList) {
      list.add(Container(
        key: ValueKey(phrase),
        child: PhraseCard(
          phrase: phrase,
          trailing: Wrap(
            spacing: 5,
            children: [
              phrase.observer != null && phrase.observer!.isNotEmpty
                  ? Tooltip(
                      message: 'Esta frase esta sendo observada.',
                      child: Icon(AppIconData.eye))
                  : Container(
                      width: 1,
                    ),
              phrase.isPublic
                  ? Tooltip(
                      message: 'Esta frase é pública.',
                      child: Icon(AppIconData.public))
                  : Container(
                      width: 1,
                    ),
            ],
          ),
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
            SizedBox(
              width: 50,
            ),
            IconButton(
              tooltip: 'Imprimir a classificação desta frase.',
              onPressed: () => Navigator.pushNamed(
                context,
                '/pdf',
                arguments: phrase.id,
              ),
              icon: Icon(Icons.print),
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
