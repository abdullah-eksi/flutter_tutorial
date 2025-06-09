

# ⚙️ **1.10 – Fonksiyonlar (Functions) A'dan Z'ye**

> “Kodları fonksiyonla parça parça yaz, kafan rahat etsin.”
> Flutter’da her şey bir fonksiyondur, widget bile!

---

## 🧠 Temel Fonksiyon Yazımı

```dart
void selamVer() {
  print('Selam kanka!');
}
```

📞 Çağırmak:

```dart
selamVer();
```

---

## 📦 Parametreli Fonksiyon

```dart
void yaz(String mesaj) {
  print('Gelen Mesaj: $mesaj');
}

yaz('Flutter çok iyi!');
```

---

## 🔁 Geri Değer Döndüren Fonksiyon

```dart
int kareAl(int sayi) {
  return sayi * sayi;
}

print(kareAl(5)); // 25
```

---

## 🌟 Opsiyonel Parametreler

### 1. Positional (köşeli parantez)

```dart
void info(String ad, [int? yas]) {
  print('Ad: $ad');
  if (yas != null) print('Yaş: $yas');
}
```

---

### 2. Named (süslü parantez & isimli)

```dart
void kisi({required String ad, int yas = 0}) {
  print('Ad: $ad, Yaş: $yas');
}

kisi(ad: 'Abdullah', yas: 19);
```

---

## ⚡ Lambda (Anonim) Fonksiyonlar – Tek Satırda Kod

```dart
var topla = (int a, int b) => a + b;

print(topla(3, 4)); // 7
```

> Ok gibi syntax: `=>` (fat arrow)

---

## 🔥 Fonksiyonları Fonksiyonlara Parametre Geçirme

```dart
void calistir(Function fonk) {
  fonk();
}

void mesaj() => print('Fonksiyon gönderildi!');

calistir(mesaj);
```

> Dart’ta fonksiyonlar “first-class citizen”, yani başka fonksiyona yollanabilir.

---

## 🧪 Mini Görev – 6

🧪 1. `void yazAd(String ad)` fonksiyonu yaz → adı yazdır
🧪 2. `int carp(int a, int b)` → iki sayıyı çarp
🧪 3. `void selam({required String kisi, int yas = 18})` → selamla
🧪 4. Bir `List<int>` ver, her elemanı 2 ile çarpan `map()` fonksiyonu yaz
🧪 5. Lambda fonksiyonla toplama işlemi yap

---
