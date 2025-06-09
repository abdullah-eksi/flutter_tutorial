

## 🌐 FLUTTER'DA İNTERNET BAĞLANTISI KONTROLÜ VE OFFLINE/ONLINE YÖNETİMİ

---

### Niye Bu Kadar Önemli?

Kanka, net yoksa kullanıcıya “dostum internetin yok” demek, ya da varsa anında güncel veriyi çekmek lazım. Yoksa kullanıcı bi bok anlamaz, app çöker, “abi sen yapmadın mı ya?” diye söyler 😂

---

## 1️⃣ Internet Bağlantısını Kontrol Etme: `connectivity_plus`

İlk iş paketimizi projemize ekleyelim:

```yaml
dependencies:
  connectivity_plus: ^4.0.1
```

---

## 2️⃣ Internet Durumunu Dinleme

```dart
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Stream<ConnectivityResult> get connectivityStream => _connectivity.onConnectivityChanged;

  Future<bool> checkConnection() async {
    var result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
```

---

## 3️⃣ Uygulamada Kullanımı

```dart
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ConnectivityService _connectivityService = ConnectivityService();
  bool isOnline = true;

  @override
  void initState() {
    super.initState();
    _connectivityService.checkConnection().then((value) {
      setState(() {
        isOnline = value;
      });
    });

    _connectivityService.connectivityStream.listen((result) {
      setState(() {
        isOnline = result != ConnectivityResult.none;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isOnline ? 'Online Mod' : 'Offline Mod'),
        backgroundColor: isOnline ? Colors.green : Colors.red,
      ),
      body: Center(
        child: isOnline
            ? Text('Net var, veriler güncelleniyor 🕺')
            : Text('Offline mod, lokal veriler gösteriliyor 😴'),
      ),
    );
  }
}
```

---

## 4️⃣ Offline Veri Kaydetme

**SharedPreferences** ya da **Hive** ile offline data saklayabilirsin.

---

### Basit SharedPreferences Örneği:

```yaml
dependencies:
  shared_preferences: ^2.1.1
```

---

### Veri Kaydetme ve Okuma

```dart
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveData(String data) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('cachedData', data);
}

Future<String?> getData() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('cachedData');
}
```

---

### Offline Kullanım Mantığı:

* İnternet varsa: API’den veriyi çek → Ekrana yaz → Aynı veriyi **SharedPreferences**’a kaydet
* İnternet yoksa: SharedPreferences içindeki veriyi oku → Ekrana yaz

---

## Örnek Mantık:

```dart
void fetchAndCachePosts() async {
  bool connected = await _connectivityService.checkConnection();

  if (connected) {
    final posts = await fetchPosts();
    final jsonString = jsonEncode(posts.map((e) => e.toJson()).toList());
    await saveData(jsonString);
    // Ekrana posts göster
  } else {
    final cached = await getData();
    if (cached != null) {
      final List<dynamic> jsonData = jsonDecode(cached);
      final posts = jsonData.map((e) => Post.fromJson(e)).toList();
      // Ekrana posts göster
    } else {
      // Offline ve data yok, kullanıcıyı bilgilendir
    }
  }
}
```

---

## 🔥 Bonus: `toJson()` Metodu Modeline Ekle

```dart
class Post {
  // Mevcut yapın aynı

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "id": id,
      "title": title,
      "body": body,
    };
  }
}
```

---

## 🎯 Özet:

* **connectivity\_plus** ile internet var mı yok mu anlık öğren
* Offline durumunda **SharedPreferences** ile önceden çekilmiş veriyi göster
* Online olunca veriyi çek, göster ve cache’e kaydet
* Böylece app’in hem online hem offline modu oluyor, kullanıcıya stabil deneyim sunuyoruz

