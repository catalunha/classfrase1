import 'package:uuid/uuid.dart';

void id() {
  var uuid = Uuid();

  // Generate a v4 (random) id
  var v4 = uuid.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'

  print(v4);
}

String jsonClass = '''{
    "group": {
        "5uJjfUNL8Z8SgHeayNiT": {
            "title": "Morfometria",
            "url": ""
        },
        "UXFWGGbU2KLPH3eqca4N": {
            "title": "Sintática",
            "url": ""
        }
    },
    "category":{
        "HW95WkQQmfD3tmNLYi0Q":{
            "title":"Substantivo",
            "url":"",
            "group":"5uJjfUNL8Z8SgHeayNiT"
        },
        "wrojgevrQyKiv9fQMJf3":{
            "title":"Sujeito",
            "url":"",
            "group":"UXFWGGbU2KLPH3eqca4N"
        }

    }
}''';
void main() {
  id();
  print(jsonClass);
}
