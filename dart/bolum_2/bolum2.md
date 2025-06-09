

## ⚔️ **1.6 – Operatörler & String İşlemleri**

> Matematik burada, mantık burada, Dart burada! Hazırsan başlıyoruz.

---

## ➕➖ **Aritmetik Operatörler**

```dart
int x = 10;
int y = 3;

print(x + y); // toplama → 13
print(x - y); // çıkarma → 7
print(x * y); // çarpma → 30
print(x / y); // bölme → 3.333..
print(x ~/ y); // TAM bölme → 3
print(x % y); // kalan → 1
```

---

## 🧠 **Atama Operatörleri**

```dart
int a = 5;
a += 2; // a = a + 2 → 7
a *= 3; // a = a * 3 → 21
```

---

## 🤔 **Karşılaştırma Operatörleri**

```dart
print(x == y);  // eşit mi? → false
print(x != y);  // eşit değil mi? → true
print(x > y);   // büyük mü? → true
print(x < y);   // küçük mü? → false
print(x >= y);  // büyük eşit mi?
print(x <= y);  // küçük eşit mi?
```

---

## 🔗 **Mantıksal Operatörler**

```dart
bool a = true;
bool b = false;

print(a && b); // ve → false
print(a || b); // veya → true
print(!a);     // değil → false
```

---

## 💬 **String İşlemleri**

```dart
String ad = 'Abdullah';
String soyad = 'Ekşi';

print(ad + ' ' + soyad); // klasik concat
print('$ad $soyad');     // Dart’ın string interpolation olayı
```

### 🔹 `length`, `toUpperCase()`, `contains()`, `replaceAll()`

```dart
print(ad.length);             // harf sayısı
print(ad.toUpperCase());      // büyük harf
print(ad.contains('dul'));    // true
print(ad.replaceAll('A', '🅰️')); // A'yı değiştir
```

---

## 🧪 **Mini Görev – 2**

Kullanıcıdan ad, soyad, yaş al. Aşağıdaki gibi bastır:

```
Merhaba Abdullah Ekşi! 19 yaşındasın, yani 6840 gün yaşadın. 🧓
```

İpucu: yaş \* 365 = gün sayısı

```dart
void main() {
  String ad = '...';
  String soyad = '...';
  int yas = ...;

  // yazdır
}
```

