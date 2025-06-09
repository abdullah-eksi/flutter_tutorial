class Ayarlar {
  static String appAdi = 'MyApp';
  static void info() => print('Uygulama: $appAdi');
}

void main() {
  // Ayarlar sınıfının statik özelliğine erişim
  print(Ayarlar.appAdi); // MyApp

  // Ayarlar sınıfının statik metodunu çağırma
  Ayarlar.info(); // Uygulama: MyApp

  // Statik özellik ve metotlar, sınıfın örneği oluşturulmadan erişilebilir.
}
