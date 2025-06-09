class Calisan {
  String isim;
  Calisan(this.isim);
}

class Mudur extends Calisan {
  Mudur(String isim) : super(isim); // üst sınıfa yolla
}

void main() {
  Mudur m1 = Mudur('Ahmet');
  print(m1.isim); // Ahmet

  // Calisan c1 = Mudur('Ayşe'); // Bu da çalışır
  Calisan c2 = Calisan('Fatma');
  print(c2.isim); // Fatma

  //Mudur m2 = Calisan('Ali'); // ❌ HATA! Calisan, Mudur değildir

  Mudur m3 = Mudur('Zeynep');
  print(m3.isim); // Zeynep

  Calisan c3 = Mudur('Elif'); // Bu da çalışır
  print(c3.isim); // Elif
}
