void main(){

  List<int> sayilar = [10, 20, 30, 40];
   sayilar.add(50);
   sayilar.remove(20);
   
   for (var sayi in sayilar) {
     print('Sayı: $sayi');
   }

   Set<String> meyveler = {'elma', 'armut', 'elma'};
   print(meyveler); // {elma, armut} → tekrarları atar

   Map<String, dynamic> kullanici = {'ad': 'Ayşe', 'yas': 25};
   print('Ad: ${kullanici['ad']}, Yaş: ${kullanici['yas']}');



   
}