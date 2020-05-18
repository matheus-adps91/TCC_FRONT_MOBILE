class ProductCategory {

  static const String Categoria ='Categoria';
  static const String Teclado = 'Teclado';
  static const String Mouse = 'Mouse';
  static const String Monitor = 'Monitor';
  static const String Notebook = 'Notebook';
  static const String Memoria =  'Memória';
  static const String Processador =  'Processador';
  static const String Fonte =  'Fonte';
  static const String Placamae =  'Placa-Mãe';

  static List<String> getAllProductCategories() {
    return <String> [
      Categoria,
      Teclado,
      Mouse,
      Monitor,
      Notebook,
      Memoria,
      Processador,
      Fonte,
      Placamae
    ];
  }
}