

# 🧠 Bölüm 2: State Management (Durum Yönetimi) - Flutter'ın Kalp Atışı ❤️

---

## 🧩 Flutter’da “State” Ne Demek?

State = **Veri + Görünüm.**
Yani bir değişkenin değeri değişince, o veriye bağlı UI’nin de güncellenmesi lazım. Mesela:

```dart
int sayac = 0;
```

Bu değişince ekrandaki yazı da değişecek. İşte bu “state”.

---

## 🧠 Neden State Management’a İhtiyacımız Var?

Küçük projede `setState()` yetiyor ama iş büyüyünce karmaşa başlıyor. Sayfalar arası veri paylaşımı, API verisi, form verisi, vs... derken kafalar yanıyor.

**Çözüm?**
Durumu merkezi olarak yöneten sistemler:

* `setState()` (basit)
* `Provider`
* `Riverpod`
* `Bloc`
* `Cubit`
* `GetX`
* `MobX`
* `Redux`

---

## 🔹 Temel `setState()` ile State Yönetimi

Küçük uygulamalarda şahane. Basit sayaç örneği:

```dart
class Sayac extends StatefulWidget {
  @override
  _SayacState createState() => _SayacState();
}

class _SayacState extends State<Sayac> {
  int sayi = 0;

  void arttir() {
    setState(() {
      sayi++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Sayı: $sayi'),
        ElevatedButton(
          onPressed: arttir,
          child: Text('Arttır'),
        ),
      ],
    );
  }
}
```

Ama mesela **2 ekran var**, sayfa değişince veri uçtu. O zaman `Provider` gibi yapılar şart.

---

## 🔸 `Provider` ile State Yönetimi (Kapsamlı)

Flutter ekibinin desteklediği “resmi” state yönetim paketi.
Veriyi sağlayan bir sınıf tanımlıyorsun, widget’lar bu veriyi dinliyor.

### 1. Paket Kurulumu:

`pubspec.yaml` içine:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1
```

### 2. Model Sınıfı Oluştur:

```dart
import 'package:flutter/foundation.dart';

class SayacModel with ChangeNotifier {
  int _sayi = 0;

  int get sayi => _sayi;

  void arttir() {
    _sayi++;
    notifyListeners(); // UI'yi yenile!
  }
}
```

### 3. Uygulamanın tepesine provider sar:

```dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SayacModel(),
      child: MyApp(),
    ),
  );
}
```

### 4. Kullanım (Consumer):

```dart
Consumer<SayacModel>(
  builder: (context, sayac, child) => Column(
    children: [
      Text('Sayı: ${sayac.sayi}'),
      ElevatedButton(
        onPressed: sayac.arttir,
        child: Text('Artır'),
      ),
    ],
  ),
)
```

🔥 Artık ekranın neresinden istersen `sayi` değerine ulaşır, kontrol edersin!

---

## 🤘 Flutter’da Routing (Sayfalar Arası Geçiş)

### Sayfa Oluştur:

```dart
class AnaSayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => IkinciSayfa()),
            );
          },
          child: Text("İkinci Sayfaya Git"),
        ),
      ),
    );
  }
}
```

### Yeni Sayfa:

```dart
class IkinciSayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Burası ikinci sayfa"),
      ),
    );
  }
}
```

---

## 🧠 Flutter Proje Yapısı Nasıl Olmalı?

Proje büyüdükçe her şey `main.dart`ta yazılmaz kanka.
Kod yapısını modüler yapalım:

```
lib/
 ┣ models/          → Veri sınıfları
 ┣ screens/         → Ekranlar (Sayfalar)
 ┣ widgets/         → Ortak bileşenler
 ┣ providers/       → State sınıfları
 ┗ main.dart        → Ana giriş
```

---

## 📦 Flutter Paket Kullanımı (3. Parti Güçler)

Her derde deva pub.dev var:

```yaml
dependencies:
  http: ^0.13.5
  provider: ^6.1.1
  shared_preferences: ^2.2.0
  url_launcher: ^6.2.1
```

Kur, `flutter pub get` de, anında kullan!

