class Hayvan {
  void sesCikar() {
    print('Bir hayvan ses çıkardı.');
  }
}

class Kedi extends Hayvan {
  void miyavla() {
    print('Miyav!');
  }
}

void main() {
  Kedi tekir = Kedi();
  tekir.sesCikar(); // Ana sınıftan geldi
  tekir.miyavla();  // Kendi metodu
}