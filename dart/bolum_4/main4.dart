void main() {
  List<String> sehirler = ['İstanbul', 'Ankara', 'İzmir'];

  for (var sehir in sehirler) {
    print('Şehir: $sehir');
  }

  print('Döngü bitti!');
}
// for-in döngüsü, koleksiyonlar üzerinde iterasyon yapmak için kullanılır.
// Bu kod, sehirler listesindeki her bir şehri yazdırır ve ardından "Döngü bitti!" mesajını gösterir.