void main(){

  String? not; // 🧪 1. String? not değişkeni oluştur ve null ata
  late int puan; // 🧪 2. late int puan tanımla → sonra 100 ata → yazdır
  puan = 100;
  print(puan);

  String? mesaj = null; // 🧪 3. String? mesaj = null → yazdır ama ?? ile "Boş mesaj" gelsin
  print(mesaj ?? "Boş mesaj");

  // 🧪 4. Fonksiyon yaz: void bildir({required String mesaj})
  void bildir({required String mesaj}) {
    print('Bildirim: $mesaj');
  }
  
  // 🧪 5. String? isim; → if ile null değilse yazdır, değilse "Anonim" de
  String? isim;
  if (isim != null) { // null kontrolü yapıyoruz
    // Eğer isim null değilse bu blok çalışır
    print('Hoş geldin $isim');
  } else {
    print('Anonim');
  }

}