
# ⚡ Flutter Animasyon Performansı — Sıfır Tıkanma Kanka Rehberi ⚡

---

## 1️⃣ **Vsync ile Senkronizasyon:**

Animasyon kontrolcülerinde `vsync` parametresi olmazsa, animasyonlar gereksiz CPU harcar, performans katili olur. `TickerProviderStateMixin` kullanıp `vsync: this` verirsin.

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,  // Bu parametre CPU’yu yormamayı sağlar
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

---

## 2️⃣ **`const` Kullanımı — Flutter’ın Turbo Modu**

Widget’ları `const` olarak işaretlersen, Flutter onları cache’ler, rebuild olmazlar, CPU rahatlar, performans tavan yapar.

```dart
const Text('Selam Kanka!');
```

Animasyonlarda da mümkün olan yerlerde `const` kullan.

---

## 3️⃣ **AnimatedBuilder & AnimatedWidget:**

Animasyon değiştiğinde sadece gereken widget yeniden çizilir, komple widget ağacı değil. Bu da CPU’ya yazık etmemek demek.

```dart
AnimatedBuilder(
  animation: _controller,
  builder: (context, child) {
    return Transform.rotate(
      angle: _controller.value * 2 * pi,
      child: child,
    );
  },
  child: Icon(Icons.refresh, size: 50),
),
```

Burada `child` değişmediği için tekrar tekrar çizilmiyor.

---

## 4️⃣ **Rebuild’leri Minimize Et**

`setState` çok tehlikelidir kanka, gereksiz kullanma. Mümkünse:

* `ValueListenableBuilder`,
* `StreamBuilder`,
* `Provider`, `Bloc` gibi state yönetim paketlerini kullan.

Yoksa her `setState` ile tüm widget ağacı yeniden çizilir, CPU ağlar.

---

## 5️⃣ **Layout’a Dikkat**

Animasyon yaptığın widget çok kompleks olursa performans düşer. Özellikle:

* Çok karmaşık `CustomPaint` kullanıyorsan,
* Büyük listelerde animasyon varsa,
* Çok sayıda overlap (üst üste bindirme) varsa.

Bu durumda, animasyonu daha lokal yapmaya çalış, gereksiz büyük area’ları avoid et.

---

## 6️⃣ **FPS Takibi ve Debugging**

Flutter’da FPS’yi takip etmek için:

```dart
WidgetsBinding.instance!.addTimingsCallback((timings) {
  for (final frameTiming in timings) {
    print('Frame build time: ${frameTiming.buildDuration}');
  }
});
```

Ya da `Flutter Performance Overlay` aç, frame drop’ları takip et, nerede tıkanıyorsun öğren.

---

## 7️⃣ **Hardware Acceleration & Layer Kullanımı**

Animasyonlarda GPU kullanımı için `RepaintBoundary` widget’ını animasyon yaptığın yere koy. Böylece sadece o alan GPU’ya devredilir.

```dart
RepaintBoundary(
  child: AnimatedContainer(...),
);
```

---

## 8️⃣ **Animasyon Süresini Optimize Et**

Çok uzun süren animasyonlar gereksiz enerji ve CPU harcar. Gerekirse süresini optimize et, smooth ve hızlı olsun.

---

## 9️⃣ **Isolate Kullanımı (Gelişmiş)**

Eğer animasyon veya ağır işlemler UI thread’ini bloke ediyorsa, `Isolate` ile paralel işleme alabilirsin. Ancak Flutter animasyonları zaten GPU tarafında çalışıyor, çoğu zaman gerek yok.

---

## Sonuç Kanka:

* `vsync` = Zorunlu, olmazsa yanarsın
* `const` = Dostun
* `AnimatedBuilder` = Performansın kalkanı
* Rebuild’leri azalt = CPU kalbin
* `RepaintBoundary` = GPU’yu yakala

