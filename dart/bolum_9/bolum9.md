

# 🧬 1.13 – Dart’ta Inheritance, `super`, `override`, Polymorphism

---

## 👑 **Inheritance (Kalıtım)**

> Bir sınıfın özelliklerini başka sınıfa **aktarabilme olayıdır.**
> Yani bir "ana sınıf" var → Diğer sınıflar onu **miras alıyor**.

### 👨‍👩‍👧‍👦 Örnek:

```dart
class Hayvan {
  void sesCikar() {
    print('Bir hayvan ses çıkardı.');
  }
}

class Kedi extends Hayvan {
  void miyavla() {
    print('Miyav!');
  }
}
```

### 🧪 Kullanım:

```dart
void main() {
  Kedi tekir = Kedi();
  tekir.sesCikar(); // Ana sınıftan geldi
  tekir.miyavla();  // Kendi metodu
}
```

🎯 `extends` kelimesi = miras alma

---

## 🚀 `super` Kelimesi

> Alt sınıftan üst sınıfa ulaşmamızı sağlar.
> Yani `super` ile **parent class**'taki constructor veya method'lara ulaşırız.

### 📦 Constructor örneği:

```dart
class Calisan {
  String isim;
  Calisan(this.isim);
}

class Mudur extends Calisan {
  Mudur(String isim) : super(isim); // üst sınıfa yolla
}
```

---

## ✍️ `@override` – Üstteki fonksiyonu ezmek

> Aynı isimde fonksiyon varsa **kendi versiyonumuzu** yazmak istersek `@override` kullanırız.

```dart
class Hayvan {
  void sesCikar() {
    print('Hayvan sesi');
  }
}

class Kopek extends Hayvan {
  @override
  void sesCikar() {
    print('Hav hav');
  }
}
```

```dart
void main() {
  Kopek k = Kopek();
  k.sesCikar(); // Hav hav
}
```

🎯 `@override` yazmazsan override olur ama IDE uyarı vermez. Yaz, tertemiz kod olsun.

---

## 🧛‍♂️ Polymorphism (Çok Biçimlilik)

> Üst sınıfı kullanarak alt sınıfın davranışını gösterebilme

### 📦 Örnek:

```dart
class Sekil {
  void ciz() {
    print('Şekil çiziliyor...');
  }
}

class Daire extends Sekil {
  @override
  void ciz() {
    print('Daire çiziliyor...');
  }
}

class Kare extends Sekil {
  @override
  void ciz() {
    print('Kare çiziliyor...');
  }
}

void sekliCiz(Sekil s) {
  s.ciz();
}
```

### 💥 Kullanımı:

```dart
void main() {
  sekliCiz(Daire()); // Daire çiziliyor
  sekliCiz(Kare());  // Kare çiziliyor
}
```

> Aynı fonksiyonu farklı sınıflar farklı davranışla çalıştırır. Polymorphism budur kanka!

---

## 👻 `abstract class` – Şablon sınıf

> Nesne oluşturulamaz! Sadece miras alınır.
> İçinde normal method da olabilir, sadece başlık olan `abstract method` da olabilir.

```dart
abstract class Sekil {
  void ciz(); // implement edilmesi zorunlu
}

class Ucgen extends Sekil {
  @override
  void ciz() {
    print('Üçgen çizildi');
  }
}
```

---

## 🎭 `interface` – Dart’ta interface nasıl yapılır?

Dart’ta özel `interface` keyword yok.
Ama **her class, interface gibi kullanılabilir**.

### Örnek:

```dart
class Calistirilabilir {
  void calistir();
}

class Motor implements Calistirilabilir {
  @override
  void calistir() {
    print('Motor çalıştı.');
  }
}
```

🎯 `implements` kullanınca her şeyi **baştan override etmek zorundasın.**

---

## 🧪 Mini Görev – 9

1. `class Ulasim` oluştur, `hareketEt()` fonksiyonu yaz
2. `class Araba`, `class Bisiklet` → Ulasim'dan kalıtım al
3. `Araba` içinde `hareketEt()` override et → "Vruummm!"
4. `Bisiklet` içinde override et → "Pedal çevrildi!"
5. Polymorphism ile `hareketTest(Ulasim u)` fonksiyonu yaz

---

## 📚 Özet Tabela:

| Konu             | Ne işe yarar?                  |
| ---------------- | ------------------------------ |
| `extends`        | Miras alma                     |
| `super`          | Üst sınıfa erişim              |
| `@override`      | Fonksiyonu ezmek               |
| `abstract class` | Şablon sınıf, nesne üretilemez |
| `implements`     | Interface gibi kullanım        |
| Polymorphism     | Aynı arayüz, farklı davranış   |

