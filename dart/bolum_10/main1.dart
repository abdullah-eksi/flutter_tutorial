void main() {
  List<String> isimler = ['Ali', 'Veli', 'Zeynep'];

  print(isimler[0]); // Ali
  print(isimler.length); // 3

  // List'in sonuna eleman ekleme
  isimler.add('Ayşe');

  // List'in başına eleman ekleme
  isimler.insert(0, 'Fatma');
  // List'ten eleman silme
  isimler.remove('Veli');

  // List'in tüm elemanlarını yazdırma
  print('Liste elemanları:');
  for (String isim in isimler) {
    print(isim);
  }
}
