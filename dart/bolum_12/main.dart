// 🔰 Ogrenci sınıfı
class Ogrenci {
  String ad;
  int numara;
  List<double> _notlar = [];

  // 🎯 Constructor
  Ogrenci(this.ad, this.numara);

  // 📌 Not ekleme fonksiyonu
  void notEkle(double not) {
    if (not >= 0 && not <= 100) {
      _notlar.add(not);
      print('$ad öğrencisine $not notu eklendi.');
    } else {
      print('Geçersiz not! ($not)');
    }
  }

  // 📊 Ortalama hesaplayan fonksiyon (internal)
  double _notOrtHesapla() {
    if (_notlar.isEmpty) return 0;
    return _notlar.reduce((a, b) => a + b) / _notlar.length;
  }

  // ✅ Getter: Ortalamayı oku ama değiştiremezsin
  double get ortalama => _notOrtHesapla();

  // 🧾 Bilgi yazdırma
  void bilgiYazdir() {
    print('Ad: $ad | Numara: $numara | Ortalama: ${ortalama.toStringAsFixed(2)}');
  }
}

// 👨‍🏫 Miras alan sınıf: MezunOgrenci
class MezunOgrenci extends Ogrenci {
  int mezuniyetYili;

  MezunOgrenci(String ad, int numara, this.mezuniyetYili) : super(ad, numara);

  void mezunBilgisi() {
    print('$ad öğrencisi $mezuniyetYili yılında mezun olmuştur.');
  }
}

void main() {
  // 🧑‍🎓 Normal öğrenci
  var ogr1 = Ogrenci('Abdullah', 123);
  ogr1.notEkle(85);
  ogr1.notEkle(90);
  ogr1.notEkle(70);
  ogr1.bilgiYazdir();

  print('Ortalama dışardan okundu: ${ogr1.ortalama}');
  // ogr1.ortalama = 100; ❌ bunu yapamazsın, setter yok!

  // 🎓 Mezun öğrenci
  var mezun = MezunOgrenci('Ayşe', 456, 2024);
  mezun.notEkle(95);
  mezun.notEkle(100);
  mezun.bilgiYazdir();
  mezun.mezunBilgisi();
}
