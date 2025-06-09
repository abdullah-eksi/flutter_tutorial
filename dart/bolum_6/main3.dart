void info(String ad, [int? yas]) {
  print('Ad: $ad');
  if (yas != null) print('Yaş: $yas');
}

// Bu fonksiyon, ad ve isteğe bağlı olarak yaş parametrelerini alır.
// Eğer yaş parametresi sağlanmamışsa, sadece ad bilgisi yazdırılır.

void kisi({required String ad, int yas = 0}) {
  print('Ad: $ad, Yaş: $yas');
}

void main() {
  info('Ali', 30); // Ad: Ali, Yaş: 30
  info('Ayşe'); // Ad: Ayşe

  kisi(ad: 'Mehmet', yas: 25); // Ad: Mehmet, Yaş: 25
  kisi(ad: 'Zeynep'); // Ad: Zeynep, Yaş: 0
  kisi(ad: 'Can', yas: 18); // Ad: Can, Yaş: 18
}
