  void yazAd(String ad) {
    print('Ad: $ad');
  }
// yazAd fonksiyonu, verilen ismi ekrana yazdırır
  // Bu fonksiyon, Dart dilinde basit bir fonksiyon tanımlama örneğidir.
  int carp(int a, int b) {
    return a * b;
  }
// carp fonksiyonu iki sayıyı çarpar ve sonucu döner
  void selam({required String kisi, int yas = 18}) {
    print('Selam $kisi, yaşınız: $yas');
  }
// selam fonksiyonu, isim ve isteğe bağlı yaş parametresi alır. Eğer yaş verilmezse varsayılan olarak 18 kullanılır.
// Bu fonksiyonlar, Dart dilinde temel fonksiyon tanımlama ve kullanma örnekleridir.
void main(){


  List<int> sayilar = [1, 2, 3, 4, 5];
  List<int> ciftler = sayilar.map((sayi) => sayi * 2).toList();
// Çift sayılar: [2, 4, 6, 8, 10] 
 // Map fonksiyonu ile her sayıyı 2 ile çarparak yeni bir liste oluşturduk
  int toplam = sayilar.reduce((a, b) => a + b);

  // Fonksiyonları test et
  yazAd('Ahmet');
  print('Çarpım: ${carp(3, 4)}');
  selam(kisi: 'Ayşe', yas: 25);
  
  print('Çift sayılar: $ciftler');
  print('Toplam: $toplam');


}