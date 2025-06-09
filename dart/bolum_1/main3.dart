void main() {
  String? ad; // null olabilir
  ad = 'Abdullah';

  print(ad.length); // ⚠️ Hata verir
  print(ad ?? 'İsim girilmedi'); // ad null ise 'İsim girilmedi' yazdırır
}
