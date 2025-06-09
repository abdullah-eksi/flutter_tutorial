void main() {
  List<int> sayilar = [2, 4, 6, 8, 10];
  for (var sayi in sayilar) {
    print('Sayı: $sayi');
  }

  print('Döngü bitti!');
  // Bu kod, sayilar listesindeki her bir sayıyı yazdırır ve ardından "Döngü bitti!" mesajını gösterir.

  print("Lste Oluşturma ve Aralık Oluşturma");
  List<int> range = List.generate(10, (index) => index + 1);
  print(range); // [1, 2, 3, ...]
  // List.generate, belirli bir aralıkta sayılar oluşturmak için kullanılır.
  // Bu kod, 1'den 10'a kadar olan sayıları içeren bir liste oluşturur ve yazdırır.
}
// Bu kod, sayilar listesindeki her bir sayıyı yazdırır.
// for-in döngüsü, koleksiyonlar üzerinde iterasyon yapmak için kullanılır.