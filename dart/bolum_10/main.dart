void main() {
  // 1️⃣ Bir List<String> oluştur → İçinde birkaç arkadaş ismi olsun
  List<String> arkadaslar = ['Ahmet', 'Zeynep', 'Mehmet'];
  print('Arkadaşlar: $arkadaslar');


  // 2️⃣ Listeye yeni isim ekle
  arkadaslar.add('Elif');
  print('Yeni arkadaş eklendi: $arkadaslar');


  // 3️⃣ Map<String, dynamic> ile bir kişi tanımla (isim, yaş, meslek)
  Map<String, dynamic> kisi = {
    'isim': 'Burak',
    'yas': 25,
    'meslek': 'Yazılımcı',
  };
  print('Kişi: $kisi');



  // 4️⃣ Set ile tekrarsız hayvanlar listesi oluştur
  Set<String> hayvanlar = {'kedi', 'köpek', 'kuş', 'kedi'};
  print('Hayvanlar (tekrarsız): $hayvanlar');

  // 5️⃣ Collection-if ile yaşa göre bir değer ekle
  int yas = kisi['yas'];


  List<String> mesajlar = [
    'Hoş geldin!',
    if (yas > 18) '18+ içeriğe erişimin var 😎'
  ];
  
  print('Mesajlar: $mesajlar');

  // 6️⃣ Spread ile 2 listeyi birleştir
  List<String> ekstraArkadaslar = ['Fatma', 'Kerem'];
  List<String> tumArkadaslar = [...arkadaslar, ...ekstraArkadaslar];
  print('Tüm arkadaşlar: $tumArkadaslar');
}
