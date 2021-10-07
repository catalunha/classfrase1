import 'package:uuid/uuid.dart';

void id() {
  var uuid = Uuid();

  // Generate a v4 (random) id
  var v4 = uuid.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'

  print(v4);
}

void main() {
  // id();
  String phrase = 'Deus é bom.';
  print(phrase);
}
