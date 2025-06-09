

## 🧱 **1.1 – Dart Nedir, Neden Öğreniyoruz?**

**Dart**, Google tarafından geliştirilen, Flutter’ın resmi dilidir.
➡️ Mobil, web, masaüstü ve server-side projelerde kullanabilirsin.
➡️ Null safety, modern OOP, asenkron yapı desteğiyle tam developer dostu.

---

## 🛠️ **1.2 – Gerekli Kurulumlar**

### ✅ Dart SDK (Sadece Dart için)

* dart.dev sitesinden kurabilirsin.
* VS Code ya da Android Studio + Dart eklentisi yeterli.

### ✅ Flutter varsa zaten Dart içinde gelir.

* `flutter doctor` komutu: her şey yolundaysa “doctor” sana yeşil ışık yakar 🚦

---

## 📦 **1.3 – İlk Dart Dosyam**

Bir dosya aç: `main.dart`
Şununla başlıyoruz:

```dart
void main() {
  print('Selam Dart! Kod yazmaya başladık!');
}
```

`void main()` → Dart’ın başlangıç fonksiyonu
`print()` → Konsola mesaj basar

---

## 🧠 **1.4 – Değişkenler & Veri Tipleri**

```dart
void main() {
  var isim = 'Abdullah'; // otomatik String
  int yas = 19;
  double maas = 14500.50;
  bool aktifMi = true;
  dynamic karisik = 'Merhaba'; // her şey olur: String, int, Map, List...

  print('$isim $yas yaşında, maaşı $maas TL, aktif: $aktifMi');
}
```

### 🔹 `var`: Türü otomatik algılar

### 🔹 `final`: Sonradan değişmez (runtime)

### 🔹 `const`: Compile-time sabit

### 🔹 `late`: Sonradan atamak için ama **null olamaz**

---

## 🚧 **1.5 – Null Safety Olayı (!? ??)**

Dart null güvenli bir dil. `null` tehlikelidir kanka, app patlatır.

```dart
String? ad; // null olabilir
ad = 'Abdullah';

print(ad.length); // ⚠️ Hata verir
print(ad?.length); // ✅ Null ise null döner
```

### `!` → ben garanti veriyorum, null değil

### `??` → null ise şunu kullan

```dart
print(ad ?? 'İsim girilmedi'); // ad null ise 'İsim girilmedi' yazdırır
```

---

## 🧪 **Mini Görev – 1**

Aşağıdaki bilgileri değişkenlerle tanımla ve tek satırda yazdır:

* Adın
* Yaşın
* En sevdiğin yemek
* Yazılımda hedeflediğin seviye

```dart
// BURAYI DOLDUR
void main() {
  // ...
  print('Benim adım ... yaşım ... en sevdiğim yemek ... hedefim ...');
}
