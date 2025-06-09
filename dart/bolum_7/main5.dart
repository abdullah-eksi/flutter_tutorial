
  void selamla({required String isim}) {
  print('Selam $isim');
}

void main(){

selamla(isim: 'Zeynep'); // ✅
selamla(); // ❌ hata!

}