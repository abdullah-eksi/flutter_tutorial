class HesapMakinesi {
  int topla(int a, int b) {
    return a + b;
  }

  int cikar(int a, int b) {
    return a - b;
  }

  int carp(int a, int b) {
    return a * b;
  }

  double bol(int a, int b) {
    if (b == 0) {
      throw Exception('Bölme işlemi için ikinci sayı sıfır olamaz.');
    }
    return a / b;
  }

  void yazdir(String mesaj) {
    print(mesaj);
  }
}

void main() {
  HesapMakinesi hesap = HesapMakinesi();

  int toplam = hesap.topla(5, 3);
  hesap.yazdir('Toplam: $toplam'); // Sonuc :Toplam: 8

  int fark = hesap.cikar(10, 4);
  hesap.yazdir('Fark: $fark'); // Sonuc :Fark: 6

  int carpim = hesap.carp(7, 6);
  hesap.yazdir('Çarpım: $carpim'); // Sonuc :Çarpım: 42

  try {
    double bolum = hesap.bol(20, 0);
    hesap.yazdir('Bölüm: $bolum');
  } catch (e) {
    print(e); // Bölme işlemi için ikinci sayı sıfır olamaz.
  }
}
