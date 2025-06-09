// interface nedir ? interface, bir sınıfın hangi metotları içermesi gerektiğini tanımlar.
// Dart dilinde interface, bir sınıfın hangi metotları içermesi gerektiğini tanımlar.

class Calistirilabilir {
  void calistir() {}
}

// 🎯 implements kullanınca her şeyi baştan override etmek zorundasın.
class Motor implements Calistirilabilir {
  @override
  void calistir() {
    print('Motor çalıştı.');
  }
}

class ElektrikMotoru implements Calistirilabilir {
  @override
  void calistir() {
    print('Elektrik motoru çalıştı.');
  }
}

void main() {
  Motor motor = Motor();
  motor.calistir(); // Motor çalıştı.

  ElektrikMotoru elektrikMotoru = ElektrikMotoru();
  elektrikMotoru.calistir(); // Elektrik motoru çalıştı.
}
