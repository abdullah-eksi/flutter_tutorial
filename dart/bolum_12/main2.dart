class Araba {
  String marka;
  int modelYili;

  Araba(this.marka, this.modelYili);
}

void main() {
  var araba1 = Araba('Toyota', 2020);
  var araba2 = Araba('Ford', 2018);

  print('Araba 1: ${araba1.marka}, Model Yılı: ${araba1.modelYili}');
  print('Araba 2: ${araba2.marka}, Model Yılı: ${araba2.modelYili}');
}