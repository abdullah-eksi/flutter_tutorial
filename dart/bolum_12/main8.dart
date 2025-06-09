mixin Ucma { // mixin, Dart'ta bir sınıfın özelliklerini paylaşmak için kullanılır.
  // Mixin'ler, sınıflar arasında kod tekrarını önlemek için kullanılır.
  void uc() => print('Uçuyorum!');
}

mixin Kosma { // Mixin, Dart'ta bir sınıfın özelliklerini paylaşmak için kullanılır.
  // Mixin'ler, sınıflar arasında kod tekrarını önlemek için kullanılır.
  void kos() => print('Koşuyorum!');
}

class SuperInsan with Ucma, Kosma {}
// Bu sınıf, Ucma ve Kosma mixin'lerini kullanarak uçabilen ve koşabilen bir insanı temsil eder.
void main() {
  SuperInsan insan = SuperInsan();
  insan.uc(); // Uçuyorum!
  insan.kos(); // Koşuyorum!

  // Aşağıdaki satır hata verecektir çünkü Ucma ve Kosma mixin'leri SuperInsan'ın özelliklerine sahip değildir.
  // Ucma ucma = Ucma();
}