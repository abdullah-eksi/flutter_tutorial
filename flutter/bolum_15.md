

# 🔐 Flutter Güvenliği🔐

---

## 1️⃣ **Veri Güvenliği**

### a) Local Storage Güvenliği

* Flutter’da `SharedPreferences` var, kolay ama düz metin saklar, **şifrelenmez**. Sensitive (gizli) veri oraya koyma, atarlar!
* Sensitive datalar için **flutter\_secure\_storage** kullan. Bu kanka, verini cihazın Keychain (iOS) veya Keystore (Android) alanına şifreli saklar.

```dart
final storage = new FlutterSecureStorage();
await storage.write(key: "token", value: "super_secret_token");
String? token = await storage.read(key: "token");
```

### b) Dosya Şifreleme

Eğer dosya sistemi kullanacaksan, mutlaka şifrele (örneğin `encrypt` paketi).

---

## 2️⃣ **API İletişim Güvenliği**

* API çağrılarında **HTTPS** kullan, kanka. Yoksa verilerin arada dinlenir, “aman Allah’ım gizli bilgiler uçtu!”
* HTTP header’larına **authentication token** (JWT, OAuth) ekle, API’yi koru.
* Flutter’da token’ı saklarken yukarıda dediğim `flutter_secure_storage`’ı kullan.

---

## 3️⃣ **Kimlik Doğrulama ve Yetkilendirme**

* Token bazlı authentication yap. Mesela Firebase Auth veya kendi backend’inle JWT kullanabilirsin.
* Token’lar kısa ömürlü olsun, refresh token kullan (yoksa tokendan düşer serverin havası).
* `AuthGuard` gibi middleware’lerle rota koruması yap.

---

## 4️⃣ **Kod Obfuscation ve Minification**

* Flutter’da release build yaparken **code obfuscation** aç. Böylece reverse engineering (kodun çalınması, hacklenmesi) zorlaşır.

```bash
flutter build apk --obfuscate --split-debug-info=/<project-name>/debug-info
```

* Bu kanka, app’ın kodunu karıştırır, düz okunmaz hale getirir.

---

## 5️⃣ **Input Validation (Giriş Doğrulama)**

* Kullanıcı inputlarını backend’de de doğrula, frontend’de de.
* Flutter’da form validasyonunu `Form` ve `TextFormField` ile yap, ama asıl güvenlik backend’de.

---

## 6️⃣ **Platform Güvenliği**

* Rooted/jailbreak yapılmış cihazlarda uygulamayı çalıştırmak risklidir.
* Kanka, `root_detector` gibi paketler var, bunları kullanarak cihaz root/jailbreak’ini tespit edip önlem alabilirsin.

---

## 7️⃣ **Debug Modu Kapat**

* Debug modda sensitive bilgileri konsola yazma, release modda bu bilgiler gitmez.
* `assert` gibi ifadeler debug’a özel, release modda kaldırılır.

---

## 8️⃣ **Güncel Paket ve SDK Kullanımı**

* Hem Flutter SDK, hem de kullandığın paketlerin en güncel sürümünü kullan.
* Eskimiş paketlerde bilinen güvenlik açıkları olabilir, onu kapatmazsan kanka risk.

---

## 9️⃣ **SSL Pinning**

* Extra güvenlik istersen, SSL Pinning yap. Bu, app’in sadece belirlediğin sertifikayla iletişim kurmasını sağlar, MITM (Man in the Middle) saldırılarını engeller.

---

## 1️⃣0️⃣ **Diğer Önemli İpuçları**

* Log’ları kontrol et, sensitive info yazdırma.
* Crash ve hata raporlarını topla ama içinde gizli bilgi olmasın.
* Uygulama içi güvenlik testleri yap, penetration testlerine açık ol.

---

# Özetle Kanka:

* Veriyi güvenli sakla, şifrele
* API iletişiminde HTTPS + Token kullan
* Authentication’u doğru kur, token’ı iyi yönet
* Kodunu obfuscate yap, reverse engineering’i zorlaştır
* Inputları kontrol et, backend’i sağlam tut
* Root/jailbreak tespiti yap, riskli cihazlarda engelle
* Debug modda dikkatli ol, sensitive log koyma
* Güncel kal, güvenlik yamalarını kaçırma
* İstersen SSL pinning ile ekstra koruma al

