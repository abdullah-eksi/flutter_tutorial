class Hayvan {
  void sesCikar() => print("Bir ses çıkarır");
}

class Kedi extends Hayvan {
  @override
  void sesCikar() => print("Miyav!");
}

void main() {
  var kedi = Kedi();
  kedi.sesCikar(); // Miyav!

  Hayvan hayvan = Kedi(); // Polimorfizm
  hayvan.sesCikar(); // Miyav!

  // Aşağıdaki satır hata verecektir çünkü Hayvan sınıfı Kedi'nin özelliklerine sahip değildir.
  // Kedi kedi2 = Hayvan();
}
