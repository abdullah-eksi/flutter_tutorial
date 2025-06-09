class Hayvan {
  void sesCikar() {
    print('Hayvan sesi');
  }
}

class Kopek extends Hayvan {
  @override // Override anahtar kelimesi ile metodu geçersiz kılıyoruz
  // Bu, Hayvan sınıfındaki sesCikar metodunu geçersiz kılar
  void sesCikar() {
    print('Hav hav');
  }
}

void main() {
  Kopek k = Kopek();
  k.sesCikar(); // Hav hav
}