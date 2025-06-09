void main() {
  List <Map<String, dynamic>> kisi = [
  
  {
    'isim': 'Ahmet',
    'yas': 25,
    'meslek': 'Developer',
  
  }];
  
  kisi.add({
    'isim': 'Ayşe',
    'yas': 30,
    'meslek': 'Designer',
  });
  kisi.add({
    'isim': 'Mehmet',
    'yas': 28,
    'meslek': 'Manager',
  });
  kisi.add({
    'isim': 'Fatma',
    'yas': 22,
    'meslek': 'Analyst',
  });
  kisi.add({
    'isim': 'Zeynep',
    'yas': 27,
    'meslek': 'Tester',
  });

  // Liste elemanlarını yazdırma
  print('Kişi Listesi:');
  for (Map<String, dynamic> kisiBilgi in kisi) {
    print('İsim: ${kisiBilgi['isim']}, Yaş: ${kisiBilgi['yas']}, Meslek: ${kisiBilgi['meslek']}');
  }
  // Liste elemanlarını filtreleme
  List<Map<String, dynamic>> filtreliKisi = kisi.where((k) => k['yas'] > 25).toList();
  print('\n25 yaşından büyük kişiler:');
  for (Map<String, dynamic> kisiBilgi in filtreliKisi) {
    print('İsim: ${kisiBilgi['isim']}, Yaş: ${kisiBilgi['yas']}, Meslek: ${kisiBilgi['meslek']}');
  }
  // Liste elemanlarını sıralama
  kisi.sort((a, b) => a['yas'].compareTo(b['yas']));
  print('\nYaşa göre sıralanmış kişi listesi:');
  for (Map<String, dynamic> kisiBilgi in kisi) {
    print('İsim: ${kisiBilgi['isim']}, Yaş: ${kisiBilgi['yas']}, Meslek: ${kisiBilgi['meslek']}');
  }

}
