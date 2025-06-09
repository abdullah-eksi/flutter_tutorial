class Kullanici {
  String isim = '';
  int seviye = 0;

  Kullanici.admin() {
    isim = 'Admin';
    seviye = 10;
  }

  Kullanici.normal(this.isim, this.seviye);
}

void main() {
  var adminKullanici = Kullanici.admin();
  print(
    'Admin Kullanıcı: ${adminKullanici.isim}, Seviye: ${adminKullanici.seviye}',
  ); // Admin Kullanıcı: Admin, Seviye: 10

  var normalKullanici = Kullanici.normal('Ahmet', 5);
  print(
    'Normal Kullanıcı: ${normalKullanici.isim}, Seviye: ${normalKullanici.seviye}',
  ); // Normal Kullanıcı: Ahmet, Seviye: 5
}
