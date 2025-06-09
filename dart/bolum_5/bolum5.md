

# 🧺 **1.9 – Koleksiyonlar (List, Set, Map)**

> Flutter’da veri tutmanın 3 atlısı: **List**, **Set**, **Map**.
> Uygulamanın beynini oluştururlar. Hafıza, yapı, güç 💪

---

## 🧾 **List – Sıralı Veri Dizisi**

```dart
List<String> isimler = ['Ahmet', 'Mehmet', 'Zeynep'];

print(isimler[0]); // Ahmet
isimler.add('Can');
isimler.remove('Mehmet');
print(isimler.length); // 3
```

### 🔄 Dönmek?

```dart
for (var isim in isimler) {
  print('İsim: $isim');
}
```

---

## 🧮 **Set – Tekillik Krallığı (Unique Veriler)**

```dart
Set<int> sayilar = {1, 2, 3, 2, 1};
print(sayilar); // {1, 2, 3} → tekrarları atar
sayilar.add(5);
```

> Liste gibi ama tekrar yok! “Ben orijinalim” diyen koleksiyon.

---

## 🗺️ **Map – Anahtar & Değer (Key-Value)**

```dart
Map<String, String> kullanici = {
  'ad': 'Abdullah',
  'sehir': 'İstanbul',
};

print(kullanici['ad']); // Abdullah
kullanici['yas'] = '19';
```

### 🔄 Map’i Dönmek:

```dart
kullanici.forEach((key, value) {
  print('$key: $value');
});
```

---

## 🧪 Mini Görev – 5

🧪 1. Bir `List<int>` oluştur: `[10, 20, 30, 40]`
🧪 2. İçine `50` ekle, sonra `20`yi sil
🧪 3. Bu listeyi for-in ile yazdır

🧪 4. `Set<String>` oluştur: `{'elma', 'armut', 'elma'}` → yazdır
🧪 5. `Map<String, dynamic>` oluştur: `{'ad': 'Ayşe', 'yas': 25}` → ad ve yaşı yazdır

---

## 🚀 Bonus: Listelerde Filtreleme & Mapleme

```dart
List<int> sayilar = [1, 2, 3, 4, 5];
var ciftler = sayilar.where((s) => s % 2 == 0).toList(); // [2, 4]
var kareler = sayilar.map((s) => s * s).toList(); // [1, 4, 9, 16, 25]
```

