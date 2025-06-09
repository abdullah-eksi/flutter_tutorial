void main() {
  String ad = 'Abdullah';
  String soyad = 'Ekşi';

  print(ad + ' ' + soyad); // klasik concat
  print('$ad $soyad'); // Dart’ın string interpolation olayı

  print("Metin Özellikleri");
  print(ad.isEmpty); // false
  print(ad.isNotEmpty); // true
  print(ad.startsWith('A')); // true
  print(ad.endsWith('a')); // true
  print(ad.indexOf('d')); // 2. harfin indeksi
  print(ad.indexOf('x')); // -1 (bulunamadı)
  print(ad.lastIndexOf('a')); // son 'a' harfinin indeksi
  print(ad.length); // harf sayısı
  print(ad.toUpperCase()); // büyük harf
  print(ad.contains('dul')); // true
  print(ad.replaceAll('A', '🅰️')); // A'yı değiştir
}
