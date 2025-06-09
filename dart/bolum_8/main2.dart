class Araba {
  String marka;
  int modelYili;

  // Constructor
  Araba(this.marka, this.modelYili);
}
void main() {
  Araba araba1 = Araba('BMW', 2022);
  print('${araba1.marka} - ${araba1.modelYili}');
}