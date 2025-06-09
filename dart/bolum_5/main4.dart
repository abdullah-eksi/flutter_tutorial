void main() {
  Map<String, String> kullanici = {'ad': 'Abdullah', 'sehir': 'İstanbul'};

  print(kullanici['ad']); // Abdullah
  kullanici['yas'] = '19';
  kullanici.forEach((key, value) {
    print('$key: $value');
  });
}
// Map, anahtar-değer çiftlerini depolamak için kullanılır.
// Bu kod, kullanici adlı bir Map oluşturur ve anahtar-değer çiftlerini içerir.