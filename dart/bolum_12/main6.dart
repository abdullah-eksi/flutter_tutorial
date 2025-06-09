abstract class Sekil {
  void alanHesapla(); // soyut
}

class Kare extends Sekil {
  int kenar;

  Kare(this.kenar);

  @override
  void alanHesapla() {
    print('Alan: ${kenar * kenar}');
  }
}
void Main() {
  var kare = Kare(5);
  kare.alanHesapla(); // Alan: 25

  Sekil sekil = Kare(10); // Polimorfizm
  sekil.alanHesapla(); // Alan: 100
} 