
# 🚀 Flutter’da State Management: A’dan Z’ye

---

## 1️⃣ Nedir Bu State Management?

**State** = Uygulamadaki değişen veri, yani ekranın göstereceği bilgi. Mesela kullanıcının seçtiği buton, API’den gelen liste, formdaki yazdığın metin vs.

**State Management** = Bu veriyi nasıl kontrol edeceğin, güncelleyeceğin, UI ile senkronize edeceğin.

---

## 2️⃣ Neden Önemli?

* Küçük app’lerde basit setState yeter
* Ama büyük app, çok sayfa, çok kullanıcı etkileşimi olunca bi bok anlamıyor setState, performans düşüyor, kod karmaşıklaşıyor
* İşte bu yüzden state management paketleri var, kodu toparlıyor, performansı artırıyor, yönetimi kolaylaştırıyor

---

## 3️⃣ En Çok Kullanılan State Management Yöntemleri

* **setState()** — En basiti, Flutter’ın kendi temel mekanizması
* **Provider** — Google destekli, en popüler, kullanımı kolay
* **Riverpod** — Provider’ın gelişmişi, daha güvenli ve esnek
* **Bloc/Cubit** — Reactive ve güçlü, ama biraz fazla resmi, büyük projeye uygun
* **GetX** — Çok hızlı, az kod, tam pragmatik
* **MobX** — Reactive ve otomatik takip
* Daha neler neler var… ama biz sırasıyla Provider ve sonra da Bloc’a dalalım, olur mu?

---

## 4️⃣ Basit State Management Örneği — setState()

```dart
class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('setState Örneği')),
      body: Center(child: Text('Sayaç: $_counter')),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
```

---

## 5️⃣ Provider’a Giriş

### Adım 1: Paket ekle

```yaml
dependencies:
  provider: ^6.0.5
```

---

### Adım 2: Model oluştur (state)

```dart
import 'package:flutter/foundation.dart';

class CounterModel extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // Dinleyicilere haber verir, UI güncellenir
  }
}
```

---

### Adım 3: Provider’ı app’e ekle

```dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CounterModel(),
      child: MyApp(),
    ),
  );
}
```

---

### Adım 4: State’i kullan

```dart
import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Provider Örneği')),
      body: Center(child: Text('Sayaç: ${counter.count}')),
      floatingActionButton: FloatingActionButton(
        onPressed: counter.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
```

---

## 6️⃣ Neden Provider?

* setState’e göre daha temiz ve organize
* Küçük, orta çaplı projeler için biçilmiş kaftan
* App’i bileşenlere böl ve sadece ihtiyacı olan widget’lar güncellensin
* Performans artar, kod okunur olur

---

## 7️⃣ Biraz Daha İleri: Selector, Consumer vs.

* **Consumer** widget, sadece sarmaladığın widget’ı dinler, rebuild optimize
* **Selector** ise provider içinden sadece belli alanı dinler, daha hassas kontrol

---

## 8️⃣ Kanka, İstersen Provider’la Küçük Bir Proje Yapalım?

Mesela Todo App falan...

* Listeyi göster
* Yeni todo ekle
* Sil
* İşaretle (tamamlandı gibi)

Bu gerçek dünya örneği ile tam oturur Provider mantığı.
