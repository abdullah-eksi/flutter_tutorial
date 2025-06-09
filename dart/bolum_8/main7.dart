class Adres {
  String sehir;
  Adres(this.sehir);
}

class Kisi {
  String ad;
  Adres adres;
  Kisi(this.ad, this.adres);
}

void main() {
  var ev = Adres('İstanbul');
  var abdullah = Kisi('Abdullah', ev); // Kisi sınıfı, Adres sınıfının bir örneğini alır


  print('Kişi adı: ${abdullah.ad}'); // Kişi adı: Abdullah
  print('Şehir: ${abdullah.adres.sehir}'); // Şehir: İstanbul
}
