

# 📦 1.14 – Dart’ta Koleksiyonlar (List, Map, Set, Spread, Collection if/for)

---

## 🧾 1) `List` – Dizi Yapısı

> Birden fazla veriyi **sıralı şekilde** tutan yapılardır.

### Basit Liste:

```dart
List<String> isimler = ['Ali', 'Veli', 'Zeynep'];
```

### Elemanlara erişim:

```dart
print(isimler[0]); // Ali
print(isimler.length); // 3
```

### Listeye ekleme:

```dart
isimler.add('Ayşe');
```

### Listeyi döngüyle gezmek:

```dart
for (String isim in isimler) {
  print(isim);
}
```

---

## 🔑 2) `Map` – Anahtar-Değer (key-value)

> Key → Value eşleşmesi yapılır.
> Tıpkı sözlük gibi.

### Örnek:

```dart
Map<String, dynamic> kisi = {
  'isim': 'Ahmet',
  'yas': 25,
  'meslek': 'Developer'
};
```

### Erişim:

```dart
print(kisi['isim']); // Ahmet
```

### Değer değiştirme:

```dart
kisi['yas'] = 30;
```

---

## 🌀 3) `Set` – Tekrarsız Veri Listesi

> List'e benzer ama **aynı veri birden fazla olamaz!**

```dart
Set<String> sehirler = {'İstanbul', 'Ankara', 'İzmir', 'İstanbul'};
print(sehirler); // {İstanbul, Ankara, İzmir}
```

🎯 Sıra önemli değildir, elemanlar **benzersizdir.**

---

## 🧩 4) Spread Operator (`...`, `...?`)

> Listeleri veya map'leri **birleştirmek / parçalamak** için kullanılır.

### List örneği:

```dart
var liste1 = [1, 2, 3];
var liste2 = [0, ...liste1, 4];

print(liste2); // [0, 1, 2, 3, 4]
```

### Null güvenli spread:

```dart
List<int>? sayilar = null;

var yeniListe = [0, ...?sayilar, 5];
print(yeniListe); // [0, 5]
```

---

## 🧠 5) Collection `if`

> List içinde `if` kullanmak.
> Yani şartlı eleman ekleme.

```dart
bool kisiEriskinMi = true;

var yasListesi = [
  10,
  15,
  if (kisiEriskinMi) 18
];

print(yasListesi); // [10, 15, 18]
```

---

## 🔁 6) Collection `for`

> List içinde `for` kullanımı.

```dart
var sayilar = [1, 2, 3];
var carpimListesi = [
  for (var s in sayilar) s * 2
];

print(carpimListesi); // [2, 4, 6]
```

---

## 🧪 Mini Görev – 10

Aşağıdaki görevleri yap:

1. Bir `List<String>` oluştur → İçinde birkaç arkadaş ismi olsun
2. Listeye yeni isim ekle
3. `Map<String, dynamic>` ile bir kişi tanımla (isim, yaş, meslek)
4. `Set` ile tekrarsız hayvanlar listesi oluştur
5. `Collection-if` ile yaşa göre bir değer ekle
6. `Spread` ile 2 listeyi birleştir

---

## 📚 Özet Tabelası:

| Koleksiyon | Ne işe yarar?    | Ek Özellik                    |
| ---------- | ---------------- | ----------------------------- |
| `List`     | Sıralı veriler   | `add()`, `[i]` ile erişim     |
| `Map`      | Key-value yapısı | `['key']` ile erişim          |
| `Set`      | Tekrarsız liste  | Sıralama yok, tekrar yok      |
| `...`      | Spread           | Listeyi içine yayar           |
| `...?`     | Null kontrolü    | null olursa hata vermez       |
| `if`       | Collection-if    | Koşullu eleman ekleme         |
| `for`      | Collection-for   | Liste içinde döngü ile üretim |

---

> ☄️ Artık **Dart Koleksiyonları** senin köpeğin oldu kankam.
> Bundan sonraki bölüme geçiyoruz:

