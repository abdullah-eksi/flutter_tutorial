

# 🎬 Flutter Animasyonları: A’dan Z’ye Kanka Style

---

## 1️⃣ Animasyon Türleri

* **Implicit Animations (Gizli Animasyonlar):** Kolay, az kod, hazır animasyonlar. Mesela `AnimatedContainer`, `AnimatedOpacity`, `AnimatedCrossFade`
* **Explicit Animations (Açık Animasyonlar):** Daha detaylı, kontrol sende. `AnimationController`, `Tween`, `Animation` kullanılır
* **Physics-based Animations:** Gerçek fizik kurallarına göre hareket (mesela sürtünme, yay, ağırlık)
* **Hero Animations:** Sayfalar arası geçişlerde elementin büyüyüp küçülmesi gibi (örn: görsel zoom efekti)

---

## 2️⃣ Implicit Animations ile Başlayalım

Bir kutunun rengi, boyutu veya opaklığı yumuşak şekilde değişsin, tek satırda hallolur:

```dart
class MyAnimatedBox extends StatefulWidget {
  @override
  _MyAnimatedBoxState createState() => _MyAnimatedBoxState();
}

class _MyAnimatedBoxState extends State<MyAnimatedBox> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => selected = !selected),
      child: AnimatedContainer(
        width: selected ? 200 : 100,
        height: selected ? 200 : 100,
        color: selected ? Colors.red : Colors.blue,
        alignment: selected ? Alignment.center : Alignment.topCenter,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
        child: FlutterLogo(size: 75),
      ),
    );
  }
}
```

**Ne oldu?** Kutunun rengi, boyutu ve hizalaması yavaşça değişiyor.

---

## 3️⃣ Explicit Animations’a Geçiş

Artık “ben ne yapıyorum, tam kontrol benim elimde” diyorsun.

### Örnek: Basit bir Opacity Fade Animation

```dart
class FadeDemo extends StatefulWidget {
  @override
  _FadeDemoState createState() => _FadeDemoState();
}

class _FadeDemoState extends State<FadeDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this, // performansı artırmak için lazım
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // belleği boşalt, kral
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Center(child: Text('Selam Flutter!')),
    );
  }
}
```

Burada:

* `AnimationController` animasyonun süresi ve durumu
* `Tween` değer aralığını belirler (0’dan 1’e opaklık)
* `FadeTransition` widget’ı animasyonu ekrana yansıtır

---

## 4️⃣ Tween’ler ve Eğriler (Curves)

* `Tween` ile değerleri 0-1 arası, renk, pozisyon gibi aralıklarla tanımlarsın
* `Curves` ile animasyonun hızını ayarlarsın (easeIn, easeOut, bounce, elastic gibi)

Mesela:

```dart
_animation = Tween<double>(begin: 0, end: 300).animate(
  CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceOut,
  ),
);
```

Bu, hareketin zıplayarak bitmesini sağlar, süper bi’ şey.

---

## 5️⃣ Hero Animations — Sayfalar Arası Geçiş Şovu

Mesela resme tıklayınca yeni sayfada büyüyerek açılması.

```dart
// Sayfa 1
Hero(
  tag: 'logo',
  child: FlutterLogo(size: 50),
),

// Sayfa 2
Hero(
  tag: 'logo',
  child: FlutterLogo(size: 200),
),
```

`tag` aynı olmalı, Flutter arka planda animasyonu yapıyor.

---

## 6️⃣ Physics Based Animations — Fizik Kral

`SpringSimulation`, `FrictionSimulation` gibi sınıflarla gerçek hayattaki hareketleri modelleyebilirsin. Mesela bi obje yay gibi zıplıyor.

---

## 7️⃣ Bonus: Animasyon Performansı İçin İpucu

* Gereksiz rebuild’lerden kaçın,
* `const` kullan,
* `AnimatedBuilder` ile sadece gereken widget’ı rebuild et,
* `vsync` parametresi ile enerji tasarrufu sağla.

