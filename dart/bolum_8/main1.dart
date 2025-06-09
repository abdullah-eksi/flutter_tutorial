class Hamburger {
  String ekmekTuru = 'Susamlı';
  bool peynirVarMi = true;

  void hazirla() {
    print('Hamburger hazırlandı!');
  }
}

void main(){

   Hamburger burger1 = Hamburger(); // NESNE ÜRETİLDİ
  burger1.hazirla(); // Hamburger hazırlandı!
  print(burger1.ekmekTuru); // Susamlı
}