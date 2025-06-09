

# 🚀 Flutter’a İlk Adım

---

## 1) Flutter Nedir Kanka?

Flutter, Google’un çatır çatır mobil, web ve masaüstü uygulama yapmamızı sağlayan süper kütüphanesi.
**Dart dilini kullanır**, hızlıdır, Hot Reload’u var, anında değişikliği görürsün.

**Avantajları:**

* Tek kodla iOS & Android’e uygulama yaparsın, zengin UI var.
* Performans uçuyor, native gibi.
* Topluluk fena değil, sürekli gelişiyor.

---

## 2) Flutter Widget Nedir?

Flutter’daki her şey bir **widget**dır. Ekranı oluşturan yapı taşları, butonlar, yazılar, kutucuklar, hepsi widget.

İki tür widget var:

* **StatelessWidget:** Değişmeyen, sabit yapı. Mesela: Logo, sabit yazı.
* **StatefulWidget:** İçinde değişiklik olabilen, mesela: Butona basınca değişen metin, sayaç.

---

## 3) Basit Bir Flutter Uygulaması (Hello World!)

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Merhaba Flutter'),
        ),
        body: Center(
          child: Text('Selam Kanka! Flutter’a hoşgeldin!'),
        ),
      ),
    );
  }
}
```

**Ne yaptık?**

* `MaterialApp` → Google’ın tasarım dili Material Design için.
* `Scaffold` → Ekranın ana yapısı (AppBar, Body, BottomBar vs burada)
* `AppBar` → Üstteki çubuk, başlık koyduk.
* `Center` → Ortalamak için.
* `Text` → Yazı widget’ı.

---

## 4) Hot Reload Nedir?

Kanka, kodu yazarken yaptığın değişiklikleri anında görürsün. Uygulamayı kapatıp açmana gerek yok, dakikalarca beklemezsin. Bu özellik süper hızlı geliştirme için can simidi.

---

## 5) Stateless vs Stateful Widget Arasındaki Fark

### StatelessWidget:

* Değişmeyen şeyler için.
* Yapısı sabit, sadece build() fonksiyonu var.

```dart
class StatikYazi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Burası sabit yazı');
  }
}
```

### StatefulWidget:

* İçinde değişen veri var, mesela sayaç gibi.
* `StatefulWidget` ve ona bağlı `State` sınıfı var.

```dart
class Sayaç extends StatefulWidget {
  @override
  _SayaçState createState() => _SayaçState();
}

class _SayaçState extends State<Sayaç> {
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
        Text('Sayaç: $sayi'),
        ElevatedButton(
          onPressed: arttir,
          child: Text('Arttır'),
        ),
      ],
    );
  }
}
```

---

## 6) Widget Ağacı (Widget Tree) Nedir?

Flutter, her şeyi widget olarak algılar, widgetlar iç içe geçer, ağaç gibi yapar. En tepedeki widget `MaterialApp` olur çoğunlukla. İçinde başka widgetlar, onlar da başka widgetlar...

---

## 7) Layout & Tasarım Widget’ları

* `Container` → Kutucuk gibi, renk, margin, padding vs verilir.
* `Row` → Yatayda widgetlar.
* `Column` → Dikeyde widgetlar.
* `Expanded` → Yer kaplamasını yönetir.
* `Padding` → İç boşluk ekler.

---

## Bonus İlk Mini Proje: Sayaç Uygulaması

**Yukardaki StatefulWidget örneği** tam başlangıç.
Kendi telefonda aç, dene, butona basınca sayının artmasını izle! Kafayı yorma, bu işin sırrı burada.


