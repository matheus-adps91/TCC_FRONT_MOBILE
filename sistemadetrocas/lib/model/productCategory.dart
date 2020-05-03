class ProductCategory {

  static const String Categoria ='Categoria';
  static const String Teclado = 'Teclado';
  static const String Mouse = 'Mouse';
  static const String Monitor = 'Monitor';
  static const String Notebook = 'Notebook';
  static const String Memoria =  'Memória';

  static List<String> getAllProductCategories() {
    return <String> [
      Categoria,
      Teclado,
      Mouse,
      Monitor,
      Notebook,
      Memoria
    ];
  }
}