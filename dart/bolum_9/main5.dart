

//Nesne oluşturulamaz! Sadece miras alınır. İçinde normal method da olabilir, sadece başlık olan abstract method da olabilir.

abstract class Sekil {
  void ciz(); // implement edilmesi zorunlu
} 

class Ucgen extends Sekil {
  @override
  void ciz() {
    print('Üçgen çizildi');
  }
}

class Daire extends Sekil {
  @override
  void ciz() {
    print('Daire çizildi');
  }
}

void main(){

  Sekil sekil1 = Ucgen();
  Sekil sekil2 = Daire();

  sekil1.ciz(); // Üçgen çizildi
  sekil2.ciz(); // Daire çizildi
}