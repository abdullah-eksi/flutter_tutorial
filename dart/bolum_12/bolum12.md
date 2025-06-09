

# 📚 1.16 – Dart Class'lar: A’dan Z’ye, Bakkal Defteri Gibi Anlatım

---

## 📦 1) Sıfırdan Basit Class

```dart
class Insan {
  String isim = '';
  int yas = 0;

  void selamla() {
    print('Selam ben $isim, yaşım $yas');
  }
}

void main() {
  var kisi = Insan();
  kisi.isim = 'Abdullah';
  kisi.yas = 20;
  kisi.selamla(); // Selam ben Abdullah, yaşım 20
}
```

---

## 🧱 2) Constructor (Yapıcı Fonksiyon)



### a)  Kurulum: `this`

```dart
class Araba {
  String marka;
  int modelYili;

  Araba(this.marka, this.modelYili);
}

var araba = Araba('Toyota', 2022);
```

---

## 🧙‍♂️ 3) Named Constructor (İsimli Yapıcılar)

```dart
class Kullanici {
  String isim = '';
  int seviye = 0;

  Kullanici.admin() {
    isim = 'Admin';
    seviye = 10;
  }

  Kullanici.normal(this.isim, this.seviye);
}

var admin = Kullanici.admin();
var normal = Kullanici.normal('Ahmet', 1);
```

---

## 🕵️ 4) Getter & Setter

```dart
class Hesap {
  double _bakiye = 0;

  double get bakiye => _bakiye;

  set bakiyeEkle(double miktar) {
    if (miktar > 0) {
      _bakiye += miktar;
    }
  }
}

var hesap = Hesap();
hesap.bakiyeEkle = 500;
print(hesap.bakiye); // 500
```

---

## 👪 5) Inheritance – Miras Almak

```dart
class Hayvan {
  void sesCikar() => print("Bir ses çıkarır");
}

class Kedi extends Hayvan {
  @override
  void sesCikar() => print("Miyav!");
}

Kedi kedi = Kedi();
kedi.sesCikar(); // Miyav!
```

---

## 🧪 6) Abstract Class – Soyut Sınıf

```dart
abstract class Sekil {
  void alanHesapla(); // soyut
}

class Kare extends Sekil {
  int kenar;

  Kare(this.kenar);

  @override
  void alanHesapla() {
    print('Alan: ${kenar * kenar}');
  }
}
```

---

## 🧬 7) Interface – Sözleşme Gibi

Dart'ta interface ayrı bir yapı değil, class implement edilerek kullanılır:

```dart
class Ucan {
  void uc() => print('Uçuyorum!');
}

class Kus implements Ucan {
  @override
  void uc() => print('Kuş uçuyor');
}
```

---

## 🧪 8) Mixin – Kod Paylaşımı

```dart
mixin Ucma {
  void uc() => print('Uçuyorum!');
}

mixin Kosma {
  void kos() => print('Koşuyorum!');
}

class SuperInsan with Ucma, Kosma {}

var kahraman = SuperInsan();
kahraman.uc(); // Uçuyorum!
kahraman.kos(); // Koşuyorum!
```

---

## 🧠 9) Static Yapılar

```dart
class Ayarlar {
  static String appAdi = 'MyApp';
  static void info() => print('Uygulama: $appAdi');
}

Ayarlar.info(); // Uygulama: MyApp
```



## 🧪 Mini Görev – 12

1. `Ogrenci` adında bir class oluştur.
2. Constructor ile ad, numara ver.
3. `notEkle`, `notOrtalama` gibi fonksiyonlar ekle.
4. Getter ile ortalamayı oku ama dışarıdan değiştirilmesin.
5. Başka bir sınıf oluşturup `Ogrenci` sınıfından miras al.

---

## 📌 Dart Class Haritası

| Özellik      | Açıklama                    |
| ------------ | --------------------------- |
| `class`      | Sınıf tanımı                |
| `extends`    | Miras alma                  |
| `implements` | Interface                   |
| `with`       | Mixin                       |
| `abstract`   | Soyut sınıf                 |
| `static`     | Sınıfa özgü veri/metot      |
| `get/set`    | Özelleştirilmiş okuma/yazma |

