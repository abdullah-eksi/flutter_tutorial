
void yaz(String mesaj) {
  print('Gelen Mesaj: $mesaj');
}

// yaz fonksiyonu, bir mesajı konsola yazdırır. parametre olarak bir String alır.

int kareAl(int sayi) {
  return sayi * sayi; // geri döndürme ifadesi
}


// kareAl fonksiyonu, bir tamsayı alır ve bu sayının karesini hesaplayarak geri döndürür.


void main(){
  yaz('Flutter çok iyi!');
  print(kareAl(5)); // 25

}