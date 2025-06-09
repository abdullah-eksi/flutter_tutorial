void veriGetir(Function onTamamlandi) {
  print('Veri getiriliyor...');

  // Simülasyon: 2 saniye sonra veri geldiğini varsayalım
  // Bu, asenkron bir işlem gibi davranır.
  Future.delayed(Duration(seconds: 2), () {
    print('Veri geldi!'); // Veri geldiğinde callback fonksiyonunu çağırıyoruz
    onTamamlandi(); // çağır!
  });
}

void tamam() {
  print('İşlem tamamlandı.');
}

void main() {
  print('İşlem başlatılıyor...');
  veriGetir(tamam); // tamam fonksiyonunu callback olarak gönderiyoruz
  print('İşlem devam ediyor...');
}