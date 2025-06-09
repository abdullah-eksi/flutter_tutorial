
void fonkCalistir(Function f) {
  print("Fonksiyon çalıştırılıyor:");
  f(); // gönderilen fonksiyonu çalıştırır
}

void exec() {
  print("Ben geldim!");
}

void main(){


fonkCalistir(exec); 
}