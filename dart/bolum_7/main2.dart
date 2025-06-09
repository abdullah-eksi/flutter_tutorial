void main() {
  String? soyad = null;
  print(soyad); // null olur, ama çökmeyiz
  soyad = 'Yılmaz';
  print(soyad); // Yılmaz olur, artık null değil
}
