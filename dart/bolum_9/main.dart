class Ulasim {
  // Ulasim sınıfı, ulaşım araçlarını temsil eder
  // Ulasim sınıfı, ulaşım araçlarının temel özelliklerini ve davranışlarını tanımlar
  void hareketEt() {
    print('Ulaşım aracı hareket ediyor.');
  }
}

class Araba extends Ulasim {
  // Araba sınıfı Ulasim sınıfından türetiliyor
  // Araba sınıfı Ulasim sınıfının bir alt sınıfıdır
  @override
  void hareketEt() {
    print('Vruummm!');
  }
}

class Bisiklet extends Ulasim {
  @override // Override anahtar kelimesi ile metodu geçersiz kılıyoruz
  // Bu, Ulasim sınıfındaki hareketEt metodunu geçersiz kılar
  void hareketEt() {
    print('Pedal çevrildi!');
  }
}

void hareketTest(Ulasim u) {
  // Polimorfizm: Ulasim türünden bir nesne alır
  // Bu fonksiyon Ulasim sınıfının alt sınıflarını da kabul eder
  u.hareketEt();
}

void main() {
  Ulasim araba = Araba();
  Ulasim bisiklet = Bisiklet();

  hareketTest(araba); // Vruummm!
  hareketTest(bisiklet); // Pedal çevrildi!
}
