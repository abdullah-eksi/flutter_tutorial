void main() {
  // 1️⃣ Fonksiyon: isim ve yaş alıyor, yazdırıyor + default parametreli
  void kisiBilgi({String isim = 'İsimsiz', int yas = 18}) {
    print('Ad: $isim, Yaş: $yas');
  }

  kisiBilgi(isim: 'Abdullah', yas: 20);
  kisiBilgi(); // default kullanımı

  // 2️⃣ Bir listeyi forEach ile yazdırma
  List<String> sehirler = ['İstanbul', 'Ankara', 'İzmir'];
  sehirler.forEach((sehir) => print('Şehir: $sehir'));

  // 3️⃣ Bir fonksiyonu başka fonksiyona parametre olarak gönderme
  void selamla(String isim) {
    print('Selam $isim!');
  }

  void fonksiyonuCalistir(Function func, String veri) {
    func(veri);
  }

  fonksiyonuCalistir(selamla, 'Kanka');

  // 4️⃣ Lambda ile iki sayıyı çarp
  int carp(int a, int b) => a * b;
  print('Çarpım: ${carp(4, 5)}'); // 20

  // 5️⃣ Callback mantığıyla işlem taklidi
  void veriGetir(Function onBasla, Function onTamamla) {
    print('📡 Veri getiriliyor...');
    onBasla();
    // Simülasyon
    Future.delayed(Duration(seconds: 1), () {
      print('📁 Veri işleniyor...');
      onTamamla();
    });
  }

  veriGetir(
    () => print('🚀 İşlem başladı...'),
    () => print('✅ İşlem tamamlandı!'),
  );
}

// Bu kod, Dart dilinde fonksiyonlar, lambda ifadeleri ve callback mantığını gösteren basit bir örnek.
// Fonksiyonlar, listeler ve callback'ler ile Dart'ın temel özelliklerini kullanarak
