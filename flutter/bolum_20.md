
# Flutter’da Şifreleme ve Kullanıcı Taraflı Zafiyetleri Engelleme

---

### 1️⃣ Şifreleme - Flutter tarafında ne yapabiliriz?

* **Şifreyi asla düz metin olarak tutma!**
  Ama unutma, gerçek güvenlik backend tarafında olur. Flutter’da sadece geçici hafızada şifreyi tut, kesinlikle localstorage, SharedPreferences gibi yerlere düz metin şifre yazma!

* **`flutter_secure_storage` kullan**
  Şifre gibi hassas bilgileri cihazda güvenli bir şekilde saklamak için:

  ```yaml
  dependencies:
    flutter_secure_storage: ^8.0.0
  ```

  Bu paket Android’de Keystore, iOS’da Keychain kullanır.

* **Şifreyi hash’leme frontend’de çok mantıklı değil** çünkü hash’leme backend işidir ama arada parola kurallarını kontrol etmek için geçici hash veya temel kodlama yapılabilir.

* **Dart şifreleme için:**
  `crypto` paketi ile SHA, HMAC vs yapabilirsin ama bu backend ile koordineli olmalı.

---

### 2️⃣ Kullanıcı Taraflı Zafiyetler ve Koruma

* **Input Validation (Girdi Kontrolü):**
  Kullanıcıdan gelen veriyi frontend’de mutlaka doğrula.
  *E-posta formatı, şifre uzunluğu, özel karakter kontrolü vs.*
  Ama bu sadece ön bilgi, asıl kontrol backend’de yapılmalı.

* **SQL Injection, XSS gibi saldırılara karşı:**
  Bunlar backend ile alakalıdır ama frontend’de de risk var.

* **Flutter web kullanıyorsan:**
  XSS, CSRF gibi saldırılar için ekstra önlemler almalısın.

  * Kullanıcı girdisini DOM’a doğrudan yazma.
  * `flutter_html` gibi paketler kullandığında sanitize et.

* **Token güvenliği:**
  API çağrılarında kullanılan token’ları `flutter_secure_storage` gibi güvenli yerlerde tut.
  Asla SharedPreferences gibi basit yerde tutma.

* **SSL / HTTPS Zorunluluğu:**
  API çağrıları mutlaka HTTPS üzerinden yapılmalı. HTTP ile gönderilen veri snifflenebilir.

---

### 3️⃣ Flutter’da Örnek: `flutter_secure_storage` ile Token Saklama

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

// Token kaydetme
await storage.write(key: 'token', value: '123abcXYZ');

// Token okuma
String? token = await storage.read(key: 'token');

// Token silme
await storage.delete(key: 'token');
```

---

### 4️⃣ Şifre Güvenliği için Kullanıcıya Öneriler

* En az 8-12 karakter
* Büyük harf, küçük harf, rakam ve özel karakter kullan
* Şifre tekrar kullanma (backend kontrolü)

---

### 5️⃣ Backend ile İşbirliği Önemli!

* Şifreler backend’de mutlaka **bcrypt** veya benzeri algoritma ile hash’lenmeli.
* JWT veya OAuth gibi güvenli kimlik doğrulama protokolleri kullan.
* Rate limiting (brute force saldırılarına karşı) uygulanmalı.

---

### Özet Kanka:

Flutter’da frontend güvenliği, backend kadar sağlam değil ama senin yapman gereken:

* Hassas bilgileri güvenli saklamak (flutter\_secure\_storage)
* Kullanıcı girdisini kontrol etmek ve temizlemek
* API ile güvenli HTTPS iletişim kurmak
* Şifre vs bilgiyi localde düz metin tutmamak
* Backend ile iyi anlaşıp güvenli protokoller kullanmak

