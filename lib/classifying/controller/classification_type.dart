enum ClassBy { grupo, selecao, linha }

extension ClassByExtension on ClassBy {
  static const names = {
    ClassBy.grupo: 'Classificação por GRUPO.',
    ClassBy.selecao: 'Classificação por SELEÇÃO.',
    ClassBy.linha: 'Classificação por LINHA.',
  };
  String get name => names[this]!;
}
