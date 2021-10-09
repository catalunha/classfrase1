void splitPhrase() {
  // String phrase = 'Deus é bom.';
  String phrase =
      'Palavra a b c Ponto. Ponto . D\'Ávila ?! Virgula, Ponto e vírgula; Dois pontos: Reticencias... ou ...Reticentias ou ... Reticentias Travessão x-y Parenteses (m) ou ( n ) "Aspas" ou " Aspas " Exclamação! Interrogação ? R\$123.456';

  print(phrase);
  String word = '';
  List<String> phraseList = [];
  for (var i = 0; i < phrase.length; i++) {
    // print(
    //     '${phrase[i]} ${phrase[i].contains(RegExp(r"/^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$/"))}');
    print(
        '${phrase[i]} ${phrase[i].contains(RegExp(r"[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ0123456789]"))}');
    // print(
    //     '${phrase[i]} ${phrase[i].contains(RegExp(r"[A-Za-z\u00C0-\u00FF]"))}');
    if (phrase[i].contains(
        RegExp(r"[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ0123456789]"))) {
      word += phrase[i];
    } else {
      print(word);
      if (word.isNotEmpty) {
        phraseList.add(word);
        word = '';
      }
      phraseList.add(phrase[i]);
    }
  }
  if (word.isNotEmpty) {
    phraseList.add(word);
    word = '';
  }
  print(phraseList);
  print(phraseList.join());
}


  // String phrase =
  //     'Palavra a b c Ponto. Ponto . Virgula, Ponto e vírgula; Dois pontos: Reticencias... ou ...Reticentias ou ... Reticentias Travessão x-y Parenteses (m) ou ( n ) "Aspas" ou " Aspas " Exclamação! Interrogação ? R\$40.00';


  // print(phrase.replaceAll('-', ' - ').split(' '));
  // List<String> phraseList = phrase.replaceAll('-', ' - ').split(' ');
  // print(
  //     phrase.split(' ').join('|').replaceAll('.', '|.').replaceAll('||', '|'));

  // for (var item in phrase.) {}
  // var phraseList = phrase
  //     .replaceAll('...', ' ... ')
  //     // .replaceAll('.', ' . ')
  //     .replaceAll(',', ' , ')
  //     .replaceAll(';', ' ; ')
  //     .replaceAll('!', ' ! ')
  //     .replaceAll('?', ' ? ')
  //     .replaceAll('--', ' -- ')
  //     .replaceAll('-', ' - ')
  //     .replaceAll('"', ' " ')
  //     .replaceAll(':', ' : ')
  //     .replaceAll('(', ' ( ')
  //     .replaceAll(')', ' ) ')
  //     .replaceAll('  ', ' ')
  //     .replaceAll('  ', ' ')
  //     .split(' ');
  // print(phraseList.join('|'));
  // print(phraseList.join('|').replaceAll('.', '|.'));
  // print(phraseList.join('|').replaceAll('.', '|.').split('|'));
  // // phraseList = phraseList.join('|').replaceAll('.', '|.|').split('|');
  // print(phraseList);
  // var phraseList2 = phrase
  //     .replaceAll('.', '')
  //     .replaceAll(',', '')
  //     .replaceAll(';', '')
  //     .replaceAll('!', '')
  //     .replaceAll('?', '')
  //     .replaceAll('--', '')
  //     .replaceAll('-', ' ')
  //     .replaceAll('"', '')
  //     .replaceAll(':', '')
  //     .replaceAll('...', '')
  //     .replaceAll('(', '')
  //     .replaceAll(')', '')
  //     .replaceAll('  ', ' ')
  //     .replaceAll('   ', ' ')
  //     .split(' ');
  // print(phraseList2);
  // var phraseList3 = phrase.replaceAll('-', ' ').split(' ');
  // print(phraseList3);