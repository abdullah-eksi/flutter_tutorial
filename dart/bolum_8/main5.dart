
//Sınıfın kendi içindeki değişkenlere referans verir. this anahtar kelimesi kullanılır.
class Kisi {
  String ad;

  Kisi(this.ad); // this.ad = ad
}
void main() {
  Kisi kisi = Kisi('Abdullah');
  print('Kişi adı: ${kisi.ad}'); // Sonuç: Kişi adı: Abdullah

  // this anahtar kelimesi kullanımı
  kisi.ad = 'Mehmet';
  print('Güncellenmiş kişi adı: ${kisi.ad}'); 
}