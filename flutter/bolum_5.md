

# 💾 FLUTTER’DA LOCAL VERİ SAKLAMA YÖNTEMLERİ

## 1️⃣ SharedPreferences – Basit Anahtar-Değer Depolama

Küçük veriler için birebir: tema seçimi, kullanıcı adı, token vs.

### 🔧 Kurulum

```yaml
dependencies:
  shared_preferences: ^2.2.0
```

```bash
flutter pub get
```

---

### 📦 Kullanım

```dart
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveName() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', 'Abdullah');
}

Future<void> readName() async {
  final prefs = await SharedPreferences.getInstance();
  final name = prefs.getString('username');
  print('Hoş geldin $name');
}
```

✅ Desteklediği türler: `String`, `int`, `double`, `bool`, `List<String>`

---

## 2️⃣ Hive – Hızlı ve Hafif NoSQL Veritabanı

Sözlük gibi çalışır, json çevirme yok, hem kolay hem aşırı performanslı!

### 🔧 Kurulum

```yaml
dependencies:
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  path_provider: ^2.1.1
```

```bash
flutter pub get
```

---

### 🚀 Başlatma (main.dart içinde)

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.openBox('verilerim');
  runApp(MyApp());
}
```

---

### 🧪 CRUD İşlemleri (Box kullanımı)

```dart
var box = Hive.box('verilerim');

// KAYDET
box.put('isim', 'Abdullah');

// OKU
String isim = box.get('isim', defaultValue: 'Boş');

// SİL
box.delete('isim');
```

✅ En kral yanları:

* Type cast yok
* Offline çalışır
* Performans yüksek

---

## 3️⃣ SQLite (sqlflite paketi) – Veritabanı uzmanıysan

Büyük uygulamalarda lazım olur, tablolu çalışır. İlişkisel veriler için güzel ama daha karışık.

> SQLite anlatımı istersen ayrıca dev bir bölümde işleyelim.

---

## 💡 Hangisi Ne Zaman?

| İhtiyaç              | Kullanım            |
| -------------------- | ------------------- |
| Küçük ayarlar        | `SharedPreferences` |
| Orta boyutlu veriler | `Hive`              |
| Kompleks ilişkili DB | `SQLite (sqflite)`  |

---

## 🔥 Sonraki Duraklar

İstersen sıradaki durakları söyleyeyim reis:

1. ✅ Widget yapısını daha derin işleyebiliriz
2. 🔥 Custom Widget yazımı
3. 🔒 Form Doğrulama + TextField kullanımı
4. 🎨 Animasyonlar
5. 🧠 State Management (Provider, Riverpod, Bloc farkları)
6. 💻 Firebase Auth / Firestore / Realtime DB
7. 📦 Flutter’da Dosya Okuma/Yazma
8. 🖥️ Flutter Web/Desktop olayları
9. 📱 Responsive UI ve MediaQuery kullanımı

