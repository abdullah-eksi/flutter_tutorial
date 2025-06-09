class Hesap {
  double _bakiye = 0;

  double get bakiye => _bakiye;

  set bakiyeEkle(double miktar) {
    if (miktar > 0) {
      _bakiye += miktar;
    }
  }
}

void main() {
  var hesap = Hesap();
hesap.bakiyeEkle = 500;
print(hesap.bakiye); // 500
hesap.bakiyeEkle = -100; // Negatif miktar eklenmez
  
}
