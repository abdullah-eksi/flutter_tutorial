class Insan {
  String isim = '';
  int yas = 0;

  void selamla() {
    print('Selam ben $isim, yaşım $yas');
  }
}

void main() {
  var kisi = Insan();
  kisi.isim = 'Abdullah';
  kisi.yas = 20;
  kisi.selamla(); // Selam ben Abdullah, yaşım 20
}