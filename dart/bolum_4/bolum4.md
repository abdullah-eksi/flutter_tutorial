

## 🔁 **1.8 – Döngüler: for, while, do-while, for-in**

> Liste mi var? Sayfa mı gezdircen? Bir şeyleri 30 kere mi yapman lazım?
> Hadi döndürelim ortalığı...

---

### 📍 **for Döngüsü**

```dart
for (int i = 0; i < 5; i++) {
  print('Sayı: $i');
}
```

📌 `i++` yerine `i += 2` de olur, kafana göre döndür.

---

### ⛓️ **while Döngüsü**

```dart
int sayi = 0;

while (sayi < 3) {
  print('while → $sayi');
  sayi++;
}
```

> Kontrollü, garantici döngü. “Önce kontrol et, sonra döndür.”

---

### 🌀 **do-while Döngüsü**

```dart
int s = 0;

do {
  print('do-while → $s');
  s++;
} while (s < 3);
```

> “Önce döndür, sonra kontrol et.” En az bir kez çalışır garantili.

---

### 🧾 **for-in Döngüsü (Listeleri dön)**

```dart
List<String> sehirler = ['İstanbul', 'Ankara', 'İzmir'];

for (var sehir in sehirler) {
  print('Şehir: $sehir');
}
```

> Liste dönmenin en elit, en sade hali. 💎

---

### 🧠 **forEach Alternatifi (Fonksiyonel takılır)**

```dart
sehirler.forEach((sehir) {
  print('ForEach ile şehir: $sehir');
});
```

> Dart biraz "cool" takılırsa bunu atar ortaya. 🔥

---

## 🧪 **Mini Görev – 4**

Bir liste tanımla:

```dart
List<int> sayilar = [2, 4, 6, 8, 10];
```

Bu sayıları `for`, `while`, `for-in`, `forEach` ile sırayla yazdır.
Hepsini dene, hangisini sevdiğine karar ver. 😎

---

## ⚡ Bonus: Range Taklidi

Dart’ta Python’daki `range()` yok ama böyle yapabilirsin:

```dart
for (int i = 1; i <= 10; i++) {
  print(i);
}
```

Ya da list oluştur:

```dart
List<int> range = List.generate(10, (index) => index + 1);
print(range); // [1, 2, 3, ...]
```

