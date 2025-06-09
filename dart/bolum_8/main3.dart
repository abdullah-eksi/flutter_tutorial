class Oyuncu {
  String isim;
  int seviye;

  Oyuncu(this.isim, this.seviye);

  Oyuncu.baslangic() : isim = 'Isimsiz', seviye = 1;
}
void main() {
Oyuncu o1 = Oyuncu('Abdullah', 99);
Oyuncu o2 = Oyuncu.baslangic();


print('${o1.isim} - ${o1.seviye}'); // Abdullah - 99
print('${o2.isim} - ${o2.seviye}'); // Isimsiz - 1
}