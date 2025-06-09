
## 🌐 FORM VERİSİNİ REST API’YE POST ETME

---

### 🔧 GEREKLİLER:

1. `http` paketi (network işlemleri için)
2. Form yapısı (önceki derslerde öğrendik)
3. API URL’in (örnek vereceğim)
4. Hata kontrolü (try/catch, statusCode vs.)

---

### 🛠️ http Paketini Projeye Ekle

`pubspec.yaml` dosyasında:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.6
```

Terminal’de:

```bash
flutter pub get
```

---

### 🧠 Varsayalım şöyle bir API’miz var:

```
POST https://example.com/api/register
```

Payload (gönderilecek veri):

```json
{
  "name": "Abdullah",
  "email": "abdullah@example.com",
  "password": "123456"
}
```

---

### ✅ Form Kodunu Yazalım

```dart
final _formKey = GlobalKey<FormState>();
final TextEditingController _name = TextEditingController();
final TextEditingController _email = TextEditingController();
final TextEditingController _password = TextEditingController();
```

---

### 🚀 Veri Gönderme Fonksiyonu

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> formuGonder() async {
  final url = Uri.parse("https://example.com/api/register");

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "name": _name.text,
        "email": _email.text,
        "password": _password.text,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Kayıt başarılı!");
      print("Sunucu yanıtı: ${response.body}");
    } else {
      print("Hata oluştu! Kod: ${response.statusCode}");
      print("Yanıt: ${response.body}");
    }
  } catch (e) {
    print("Bağlantı hatası: $e");
  }
}
```

---

### 💾 Form Submit Butonu

```dart
ElevatedButton(
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      formuGonder();
    }
  },
  child: Text("Kaydol"),
),
```

---

### 🎯 Bonus: Yükleniyor Göstergesi

```dart
bool _isLoading = false;

ElevatedButton(
  onPressed: _isLoading ? null : () async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await formuGonder();
      setState(() => _isLoading = false);
    }
  },
  child: _isLoading ? CircularProgressIndicator() : Text("Kaydol"),
),
```

