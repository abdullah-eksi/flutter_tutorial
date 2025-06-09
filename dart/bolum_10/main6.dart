void main(){
  bool kisiEriskinMi = true; // Boolean değişkeni, kişinin erişkin olup olmadığını belirler
// Boolean değişkenler, true veya false değerlerini alabilir.

// Liste Tanımlama
// Dart dilinde liste tanımlamak için köşeli parantezler kullanılır.
// Aşağıdaki örnekte, "yasListesi" adlı bir liste tanımlanmış ve bu listeye 10, 15 ve eğer "kisiEriskin
var yasListesi = [
  10,
  15,
  if (kisiEriskinMi) 18 // Eğer kisiEriskinMi true ise 18 eklenir
];

print(yasListesi); // [10, 15, 18]


// Liste Üretimi
// Dart dilinde liste üretimi için "for" döngüsü kullanılabilir.
// Aşağıdaki örnekte, "sayilar" adlı bir liste tanımlanmış ve bu liste elemanlarının her biri 2 ile çarpılarak yeni bir liste oluşturulmuştur.
//

var sayilar = [1, 2, 3];
var carpimListesi = [
  for (var s in sayilar) s * 2 // Her elemanı 2 ile çarparak yeni bir liste oluşturuyoruz
];

print(carpimListesi); // [2, 4, 6]
}