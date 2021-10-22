import 'package:classfrase/widget/icon_button_action.dart';
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
      appBar: appBar(),
      body: Column(
        children: [
          // admin(context),
          Center(child: Text('Como deseja usar o ClassFrase ?')),
          optionsForUse(context),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              phraseInClass(),
              phraseArchived(context),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: buildPhraseList(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSize appBar() {
    return PreferredSize(
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
              popMenu(),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuButton<dynamic> popMenu() {
    return PopupMenuButton(
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      itemBuilder: (BuildContext context) {
        return [
          popMenuItem(
              context: context,
              icon: AppIconData.info,
              text: 'Informações',
              pushNamed: '/information'),
          popMenuItem(
              context: context,
              icon: AppIconData.coffee,
              text: 'Contribuir',
              pushNamed: '/coffee'),
          popMenuExit(context),
        ];
      },
    );
  }

  PopupMenuItem<Widget> popMenuExit(BuildContext context) {
    return PopupMenuItem(
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
    );
  }

  PopupMenuItem<Widget> popMenuItem({
    required BuildContext context,
    required IconData icon,
    required String text,
    required String pushNamed,
  }) {
    return PopupMenuItem(
      child: InkWell(
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 5,
            ),
            Text(text),
          ],
        ),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, pushNamed);
        },
      ),
    );
  }

  Expanded phraseArchived(BuildContext context) {
    return Expanded(
        flex: 1,
        child: IconButtonAction(
          tooltipMsg: 'Minhas frases arquivadas',
          icon: AppIconData.box,
          pushNamed: '/phrase_archived',
          context: context,
        ));
  }

  Expanded phraseInClass() {
    return Expanded(
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
    );
  }

  admin(context) {
    return uid == '4P3NEIkWqng0t5aal0fae5RdYHj1'
        ? Wrap(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/group',
                  );
                },
                child: Text('seeClassificationsDocs'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/users',
                  );
                },
                child: Text('seeUsersDocs'),
              ),
            ],
          )
        : Container();
  }

  optionsForUse(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            optionButton(
                context: context,
                tooltipMsg: 'Para criar uma frase e classificá-la.',
                pushNamed: '/phrase_addedit',
                icon: AppIconData.phrase,
                label: 'Criar.'),
            SizedBox(width: 10),
            optionButton(
                context: context,
                tooltipMsg:
                    'Para observar frases em classificação em tempo real.',
                pushNamed: '/observer_list',
                icon: AppIconData.eye,
                label: 'Observar.'),
            SizedBox(width: 10),
            optionButton(
                context: context,
                tooltipMsg:
                    'Para aprender com a classificação de outras pessoas.',
                pushNamed: '/learn',
                icon: AppIconData.learn,
                label: 'Aprender.'),
          ],
        ),
      ),
    );
  }

  Tooltip optionButton({context, tooltipMsg, pushNamed, icon, label}) {
    return Tooltip(
      message: tooltipMsg,
      child: Container(
        width: 130,
        child: ElevatedButton.icon(
          onPressed: () => Navigator.pushNamed(
            context,
            pushNamed,
            arguments: '',
          ),
          icon: Icon(AppIconData.phrase),
          label: Text(label),
        ),
      ),
    );
  }

  List<Widget> buildPhraseList(context) {
    List<Widget> list = [];
    for (var phrase in phraseList) {
      list.add(PhraseCard(
        key: ValueKey(phrase),
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
          IconButtonAction(
            context: context,
            tooltipMsg: 'Classificar esta frase',
            icon: AppIconData.letter,
            pushNamed: '/classifying',
            pushNamedArg: phrase.id,
          ),
          SizedBox(
            width: 50,
          ),
          IconButtonAction(
            context: context,
            tooltipMsg: 'Editar esta frase',
            icon: AppIconData.edit,
            pushNamed: '/phrase_addedit',
            pushNamedArg: phrase.id,
          ),
          SizedBox(
            width: 50,
          ),
          IconButtonAction(
            context: context,
            tooltipMsg: 'Imprimir a classificação desta frase.',
            icon: AppIconData.print,
            pushNamed: '/pdf',
            pushNamedArg: phrase.id,
          ),
        ],
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
