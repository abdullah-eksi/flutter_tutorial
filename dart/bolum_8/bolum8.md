

# 🧱 **1.12 – Dart’ta Class, Object, Constructor – OOP Başlangıç**

> Kanka bu işin özü şu:
> **Sınıf (class)** = Kalıp
> **Nesne (object)** = O kalıptan çıkan gerçek ürün

---

## 📦 1. **Class Nedir?**

> Class, içine özellikler ve fonksiyonlar koyduğumuz bir şablondur.
> Yani **"Bir şeyin nasıl olacağını" tanımlar.**

### 🍔 Örnek:

```dart
class Hamburger {
  String ekmekTuru = 'Susamlı';
  bool peynirVarMi = true;

  void hazirla() {
    print('Hamburger hazırlandı!');
  }
}
```

🧠 Bu sınıf sadece tarif. Henüz **hamburger üretmedik**!

---

## 🧍‍♂️ 2. **Object (Nesne) Nedir?**

> Bir class’tan oluşturduğumuz **gerçek örnektir.**

### 🍔 Hamburger üretelim:

```dart
void main() {
  Hamburger burger1 = Hamburger(); // NESNE ÜRETİLDİ
  burger1.hazirla(); // Hamburger hazırlandı!
  print(burger1.ekmekTuru); // Susamlı
}
```

🔁 Her nesne bağımsızdır:

```dart
Hamburger burger2 = Hamburger();
burger2.ekmekTuru = 'Tam buğday';
```

---

## 🚪 3. **Constructor Nedir?**

> Class’tan nesne üretirken, başlangıç verisi vermek istiyorsak **Constructor** kullanırız.

### 🧱 Temel Constructor:

```dart
class Araba {
  String marka;
  int modelYili;

  // Constructor
  Araba(this.marka, this.modelYili);
}
```

### 🧪 Kullanımı:

```dart
void main() {
  Araba araba1 = Araba('BMW', 2022);
  print('${araba1.marka} - ${araba1.modelYili}');
}
```

---

## ⚙️ 4. **Named Constructor (Adlandırılmış Kurucu)**

```dart
class Oyuncu {
  String isim;
  int seviye;

  Oyuncu(this.isim, this.seviye);

  Oyuncu.baslangic() : isim = 'Isimsiz', seviye = 1;
}
```

```dart
Oyuncu o1 = Oyuncu('Abdullah', 99);
Oyuncu o2 = Oyuncu.baslangic();
```

---

## 🎩 5. **Method (Fonksiyonlar Class İçinde)**

```dart
class HesapMakinesi {
  int topla(int a, int b) {
    return a + b;
  }

  void yaz() {
    print('Hesap makinesi hazır.');
  }
}
```

---

## 📌 6. **this Anahtar Kelimesi**

> Sınıfın kendi içindeki değişkenlere referans verir.

```dart
class Kisi {
  String ad;

  Kisi(this.ad); // this.ad = ad
}
```

---

## 🔐 7. **Private Özellikler (\_)**

> `_` ile başlayan özellikler sadece tanımlandığı dosyada kullanılır.
> Flutter'da `_controller`, `_formKey` falan gördüysen işte bu yüzden!

```dart
class BankaHesabi {
  double _bakiye = 1000;

  double bakiyeGoster() => _bakiye;
}
```

---

## 🧱 8. **Sınıf İçinde Nesne Kullanımı (Composition)**

```dart
class Adres {
  String sehir;
  Adres(this.sehir);
}

class Kisi {
  String ad;
  Adres adres;
  Kisi(this.ad, this.adres);
}

void main() {
  var ev = Adres('İstanbul');
  var kanka = Kisi('Abdullah', ev);
}
```

---

## 🧪 Mini Görev – 8

1. `class Telefon { marka, model }` → Constructor ile tanımla
2. `void aramaYap(String numara)` metodu ekle
3. 2 tane telefon nesnesi oluştur, biri Samsung biri Apple
4. Class içinde `_sifre` private alan oluştur, `sifreyiGoster()` fonksiyonu yaz
5. `class Kitap` oluştur, içindeki `Yazar` class'ını kullan (Composition)

---

## 🚀 Sonraki Durak:

🔄 **1.13 – Inheritance (Kalıtım), Polymorphism, Super, Override**

> OOP babaları burada devreye giriyor. Miras alıcaz, override yapıcaz, kafayı sıyırıcaz 🤯

---
