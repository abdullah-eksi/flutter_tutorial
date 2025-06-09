class BankaHesabi {
  double _bakiye = 1000;

  double bakiyeGoster() => _bakiye;
}

void main(){

BankaHesabi hesap = BankaHesabi();
print('Bakiyeniz: ${hesap.bakiyeGoster()} TL'); // Bakiyeniz: 1000 TL
// Hesap sınıfının _bakiye özelliğine doğrudan erişim yok, sadece bakiyeGoster() ile erişilebilir

}