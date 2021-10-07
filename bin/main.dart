import 'package:uuid/uuid.dart';

void id() {
  var uuid = Uuid();

  // Generate a v4 (random) id
  var v4 = uuid.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'

  print(v4);
}

void main() {
  // id();
  String phrase =
      'Palavra a b c Ponto. Ponto . Virgula, Ponto e vírgula; Dois pontos: Reticencias... ou ...Reticentias ou ... Reticentias Travessão x-y Parenteses (m) ou ( n ) "Aspas" ou " Aspas " Exclamação! Interrogação ? R\$40.00';
  print(phrase);
  print(phrase.replaceAll('-', ' - ').split(' '));
  List<String> phraseList = phrase.replaceAll('-', ' - ').split(' ');
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
}
