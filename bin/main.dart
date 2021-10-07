import 'package:uuid/uuid.dart';

void id() {
  var uuid = Uuid();

  // Generate a v4 (random) id
  var v4 = uuid.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'

  print(v4);
}

void main() {
  // id();
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
