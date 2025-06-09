
void bilgiVer(String ad, [int? yas]) {
  print('Ad: $ad');
  if (yas != null) print('Yaş: $yas');
}
void bilgi({required String ad, int? yas}) {
  print('Ad: $ad');
  if (yas != null) print('Yaş: $yas');
}

void selam({String isim = 'Ziyaretçi'}) {
  print('Selam $isim');
}


void main (){

//Sırasız ve Opsiyonel Parametreler: []
bilgiVer('Ahmet'); // Sadece ad yazar
bilgiVer('Mehmet', 30); // Ad + Yaş yazar


/*bilgi fonksiyonu ve bilgiVer fonksiyonu arasındaki fark şudur bilgiVer fonksiyonunda 
ad ve yaş parametreleri sırayla yazılırken, bilgi fonksiyonunda ad ve yaş parametreleri isimlendirilmiş parametrelerdir. Bu nedenle bilgi fonksiyonunu çağırırken ad ve yaş parametrelerini istediğimiz sırada verebiliriz.
*/

// Named (isimli) Parametreler: {}
bilgi(ad: 'Zeynep', yas: 20); // Named parametreyle ad ve yaş yazar

// Varsayılan parametreli fonksiyon
selam(); // Selam Ziyaretçi
selam(isim: 'Hakan'); // Selam Hakan

}