void main() {
  late String mesaj;
  mesaj = 'Hoş geldin!';
  print(mesaj); // Çalışır
  // mesaj = null; // ❌ HATA VERİR! late değişkenler null olamaz
  mesaj = 'Hoş geldin, Abdullah!';
  print(mesaj); // Çalışır
}
