void main() {
  var sehirler = ['İstanbul', 'Ankara', 'İzmir'];
  // for-in döngüsü ile şehirleri yazdırma
  sehirler.forEach((sehir) {
    print('ForEach ile şehir: $sehir');
  });
  print('Döngü bitti!');
}
// forEach metodu, koleksiyonlar üzerinde iterasyon yapmak için kullanılır.
// Bu kod, sehirler listesindeki her bir şehri forEach ile yazdırır ve ardından "Döngü bitti!" mesajını gösterir.