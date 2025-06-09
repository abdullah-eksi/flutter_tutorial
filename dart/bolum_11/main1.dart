void selamVer() {
  print('Selamlar!');
}
void selamla(String isim) {
  print('Selam $isim!');
}
int topla(int a, int b) {
  return a + b;
}




void main() {
selamVer(); // Selam kanka!
selamla('Abdullah'); // Selam Abdullah!

int sonuc = topla(10, 10); // 20
print('Toplama sonucu: $sonuc'); // Toplama sonucu: 20
}