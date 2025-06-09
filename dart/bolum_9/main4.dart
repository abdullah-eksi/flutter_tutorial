
class Sekil {
  void ciz() {
    print('Şekil çiziliyor...');
  }
}

class Daire extends Sekil { // Daire sınıfı Sekil sınıfından türetiliyor
  // Daire sınıfı Sekil sınıfının bir alt sınıfıdır
  @override // Override anahtar kelimesi ile Sekil sınıfındaki ciz metodunu geçersiz kılıyoruz
  void ciz() {
    print('Daire çiziliyor...');
  }
}

class Kare extends Sekil { // Kare sınıfı Sekil sınıfından türetiliyor
  // Kare sınıfı Sekil sınıfının bir alt sınıfıdır
  @override // Override anahtar kelimesi ile Sekil sınıfındaki ciz metodunu geçersiz kılıyoruz
  void ciz() {
    print('Kare çiziliyor...');
  }
}

void sekliCiz(Sekil s) { // Alt sınıflarını da kabul eder
  // Sekil tipinde bir parametre alır
  s.ciz();
}


void main() {
  sekliCiz(Daire()); // Daire çiziliyor
  sekliCiz(Kare());  // Kare çiziliyor
}