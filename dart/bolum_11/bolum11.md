

# 🔥 1.15 – Dart Fonksiyonlar: Temelden İleriye Her Şey!

---

## 🧪 1) Basit Fonksiyon

```dart
void selamVer() {
  print('Selam kanka!');
}

selamVer(); // Selam kanka!
```

---

## 🎯 2) Parametre Alan Fonksiyon

```dart
void selamla(String isim) {
  print('Selam $isim!');
}

selamla('Abdullah'); // Selam Abdullah!
```

---

## 🔁 3) Return Değer Döndüren Fonksiyon

```dart
int topla(int a, int b) {
  return a + b;
}

int sonuc = topla(3, 5); // 8
```

---

## ✨ 4) Lambda / Arrow Function (`=>`)

> Tek satırlık işlemleri kısaca yazmak için birebir.

```dart
int carp(int a, int b) => a * b;
print(carp(2, 3)); // 6
```

---

## 🎩 5) Opsiyonel Parametreler

### a) Sırasız ve Opsiyonel Parametreler: `[]`

```dart
void bilgiVer(String ad, [int? yas]) {
  print('Ad: $ad');
  if (yas != null) print('Yaş: $yas');
}

bilgiVer('Ahmet'); // Sadece ad yazar
bilgiVer('Mehmet', 30); // Ad + Yaş yazar
```

---

### b) Named (isimli) Parametreler: `{}`

```dart
void bilgi({required String ad, int? yas}) {
  print('Ad: $ad');
  if (yas != null) print('Yaş: $yas');
}

bilgi(ad: 'Zeynep', yas: 20); // Named parametreyle
```

---

### Varsayılan değer verilebilir:

```dart
void selam({String isim = 'Ziyaretçi'}) {
  print('Selam $isim');
}

selam(); // Selam Ziyaretçi
selam(isim: 'Hakan'); // Selam Hakan
```

---

## 🧠 6) Anonymous Function (İsimsiz Fonksiyon)

```dart
var liste = ['a', 'b', 'c'];

liste.forEach((eleman) {
  print('Eleman: $eleman');
});
```

---

## 📦 7) Higher-Order Functions (Fonksiyon döndüren / alan)

> Fonksiyonları **parametre** olarak gönderebilir veya döndürebilirsin.

```dart
void fonkCalistir(Function f) {
  print("Fonksiyon çalıştırılıyor:");
  f(); // gönderilen fonksiyonu çalıştırır
}

void neYapalım() {
  print("Ben geldim!");
}

fonkCalistir(neYapalım); // output: Fonksiyon çalıştırılıyor + Ben geldim!
```

---

## 🎮 8) Callback Fonksiyon

```dart
void veriGetir(Function onTamamlandi) {
  print('Veri getiriliyor...');
  Future.delayed(Duration(seconds: 2), () {
    print('Veri geldi!');
    onTamamlandi(); // çağır!
  });
}

void tamam() {
  print('İşlem tamamlandı.');
}

veriGetir(tamam);
```

---

## 🧪 Mini Görev – 11

1. Bir fonksiyon yaz, isim ve yaş parametreleri alsın, yazdırsın
2. Fonksiyon default parametre kullansın
3. Bir liste içinde forEach ile elemanları yazdır
4. Bir fonksiyonu parametre olarak başka bir fonksiyona gönder
5. Lambda kullanarak iki sayıyı çarp
6. Callback mantığıyla bir işlem taklidi yap (veri getir → işleme başla → tamamla)

---

## 📚 Özet Tabelası:

| Yapı       | Anlamı              | Örnek                |
| ---------- | ------------------- | -------------------- |
| `void`     | Geri dönüşsüz fonk. | `void selam() {}`    |
| `=>`       | Lambda kısa yazımı  | `int a() => 5;`      |
| `[]`       | Opsiyonel parametre | `f(x, [y])`          |
| `{}`       | Named parametre     | `f({x: 1})`          |
| `Function` | Fonksiyon tipi      | `Function callback`  |
| `()=>`     | Lambda function     | `() => print("Hey")` |

---
