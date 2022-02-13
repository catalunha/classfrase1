import 'dart:collection';

class Dados {
  String nome;
  Dados({
    required this.nome,
  });
  @override
  toString() {
    return 'Dados(nome = $nome)';
  }
}

maplist() {
  Map<String, Dados> map = {};
  map['b'] = Dados(nome: 'bb');
  map['a'] = Dados(nome: 'aa');
  map['ab'] = Dados(nome: 'aa');
  print(map);
  Map<String, Dados> mapSorted = SplayTreeMap.from(
      map, (key1, key2) => map[key1]!.nome.compareTo(map[key2]!.nome));
  print(mapSorted);
  List<Dados> dados = [Dados(nome: 'b'), Dados(nome: 'a'), Dados(nome: 'a')];
  print(dados);
  dados.sort((a, b) => a.nome.compareTo(b.nome));
  print(dados);
}
