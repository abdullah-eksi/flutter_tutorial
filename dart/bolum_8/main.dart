//class Telefon { marka, model } → Constructor ile tanımla
//void aramaYap(String numara) metodu ekle
//2 tane telefon nesnesi oluştur, biri Samsung biri Apple
//Class içinde _sifre private alan oluştur, sifreyiGoster() fonksiyonu yaz
//class Kitap oluştur, içindeki Yazar class'ını kullan (Composition)

class Telefon {
  String marka;
  String model;
  String _sifre; // Private alan

  // Constructor
  Telefon(this.marka, this.model, this._sifre);

  // Metot: Arama yap
  void aramaYap(String numara) {
    print('$marka $model ile $numara numarasına arama yapılıyor...');
  }

  // Private alanı gösteren metot
  void sifreyiGoster() {
    print('Şifre: $_sifre');
  }
}

// Kitap ve Yazar sınıfları
class Yazar {
  String ad;
  String soyad;

  // Constructor
  Yazar(this.ad, this.soyad);
}

class Kitap {
  String baslik;
  Yazar yazar; // Composition: Kitap sınıfı Yazar sınıfının bir örneğini içerir

  // Constructor
  Kitap(this.baslik, this.yazar);
}

void main() {
  // Telefon nesneleri
  Telefon telefon1 = Telefon('Samsung', 'Galaxy S21', '1234');
  Telefon telefon2 = Telefon('Apple', 'iPhone 13', '5678');
  print(
    'Telefon 1: ${telefon1.marka} ${telefon1.model}',
  ); // Telefon 1: Samsung Galaxy S21
  print(
    'Telefon 2: ${telefon2.marka} ${telefon2.model}',
  ); // Telefon 2: Apple iPhone 13
  // Arama yapma
  telefon1.aramaYap('555-1234');
  telefon2.aramaYap('555-5678');

  // Şifreyi gösterme
  telefon1.sifreyiGoster();
  telefon2.sifreyiGoster();

  // Kitap ve Yazar nesneleri
  Yazar yazar1 = Yazar('Orhan', 'Pamuk');
  Kitap kitap1 = Kitap(' Benim Adım Kırmızı', yazar1);
  print(
    'Kitap: ${kitap1.baslik}, Yazar: ${kitap1.yazar.ad} ${kitap1.yazar.soyad}',
  ); // Kitap: Benim Adım Kırmızı, Yazar: Orhan Pamuk
}
