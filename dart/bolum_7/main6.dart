void main(){
  String? ad;

if (ad != null) {
  print('Hoş geldin $ad');
} else {
  print('Ad girilmedi');
}
// bu kod null kontrolü yapar eğer ad null ise else bloğu çalışır ve hata vermez.
// Eğer ad null değilse if bloğu çalışır ve ad değişkeni kullanılır.
} 