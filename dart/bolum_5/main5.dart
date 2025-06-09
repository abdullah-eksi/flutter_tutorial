void main() {
  List<int> sayilar = [1, 2, 3, 4, 5];
  var ciftler = sayilar.where((s) => s % 2 == 0).toList(); // [2, 4]
  var kareler = sayilar.map((s) => s * s).toList(); // [1, 4, 9, 16, 25]

  print('Çift sayılar: $ciftler'); // Çift sayılar: [2, 4]
  print('Kareler: $kareler'); // Kareler: [1, 4, 9, 16, 25]

  sayilar.forEach((s) => print('Sayı: $s')); // Sayı: 1, Sayı: 2, Sayı: 3, Sayı: 4, Sayı: 5
  var toplam = sayilar.reduce((a, b) => a + b); // 1
  print('Toplam: $toplam'); // Toplam: 15

  var maxSayi = sayilar.reduce((a, b) => a > b ? a : b); // 5
  print('En büyük sayı: $maxSayi'); // En büyük sayı: 5

  var minSayi = sayilar.reduce((a, b) => a < b ? a : b); // 1
  print('En küçük sayı: $minSayi'); // En küçük sayı: 1

  var ilkCift = sayilar.firstWhere((s) => s % 2 == 0, orElse: () => -1); // 2
  print('İlk çift sayı: $ilkCift'); // İlk çift sayı: 2

  var sonCift = sayilar.lastWhere((s) => s % 2 == 0, orElse: () => -1); // 4
  print('Son çift sayı: $sonCift'); // Son çift sayı: 4

  var tumCiftler = sayilar.where((s) => s % 2 == 0).toList(); // [2, 4]
  print('Tüm çift sayılar: $tumCiftler'); // Tüm çift sayılar: [2, 4]

  var tumTekler = sayilar.where((s) => s % 2 != 0).toList(); // [1, 3, 5]
  print('Tüm tek sayılar: $tumTekler'); // Tüm tek sayılar: [1, 3, 5]

  var sayiVarMi = sayilar.any((s) => s == 3); // true
  print('3 sayısı var mı? $sayiVarMi'); // 3 sayısı var mı? true
  
  var tumSayilar = sayilar.every((s) => s > 0); // true
  print('Tüm sayılar pozitif mi? $tumSayilar'); // Tüm sayılar pozitif mi? true

}
