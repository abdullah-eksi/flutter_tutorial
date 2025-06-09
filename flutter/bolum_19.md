

# Flutter + Firebase Authentication Basit Login & Register Kanka Versiyonu

---

### 1️⃣ Firebase Projesi Aç ve Yapılandır

1. [https://console.firebase.google.com/](https://console.firebase.google.com/) adresine git.
2. Yeni proje oluştur, istersen "flutter\_auth\_app" falan koy.
3. Proje oluşturunca **Android** ve/veya **iOS** için uygulamanı ekle.
4. Android için `android/app/google-services.json` dosyasını, iOS için `ios/Runner/GoogleService-Info.plist` dosyasını indirip projenin ilgili klasörüne koy.

---

### 2️⃣ Flutter Projene Firebase Bağlantısı Kur

`pubspec.yaml` dosyana ekle:

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.14.0
  firebase_auth: ^4.4.0
```

Sonra terminalde:

```bash
flutter pub get
```

---

### 3️⃣ Android & iOS Ayarları (Özet)

* Android: `android/build.gradle` ve `android/app/build.gradle` dosyalarına [Firebase kurulum dokümanına](https://firebase.flutter.dev/docs/overview) göre kod ekle.
* iOS: `ios/Runner/Info.plist` içinde Firebase için izinleri tanımla.

Bu ayarları Firebase dokümanlarından tek tek takip et derim, kısa kesince bir sürü detaya takılabilirsin.

---

### 4️⃣ Flutter Kodu: Firebase ile Login & Register

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Demo',
      home: AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  bool isLogin = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String message = '';

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
      message = '';
      emailController.clear();
      passwordController.clear();
    });
  }

  void submit() async {
    if (!_formKey.currentState!.validate()) return;

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      if (isLogin) {
        // Giriş yap
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
        setState(() {
          message = 'Hoşgeldin, ${userCredential.user?.email}!';
        });
      } else {
        // Kayıt ol
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        setState(() {
          message = 'Kayıt başarılı, hoşgeldin ${userCredential.user?.email}!';
          isLogin = true;
          emailController.clear();
          passwordController.clear();
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        message = e.message ?? 'Bir hata oluştu!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Giriş Yap' : 'Kayıt Ol'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'E-posta'),
                validator: (val) => val == null || val.isEmpty || !val.contains('@') ? 'Geçerli bir e-posta gir!' : null,
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Şifre'),
                obscureText: true,
                validator: (val) => val == null || val.length < 6 ? 'Şifre en az 6 karakter olmalı' : null,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: submit,
                child: Text(isLogin ? 'Giriş Yap' : 'Kayıt Ol'),
              ),
              TextButton(
                onPressed: toggleForm,
                child: Text(isLogin ? 'Hesabın yok mu? Kayıt ol' : 'Zaten hesabın var mı? Giriş yap'),
              ),
              SizedBox(height: 20),
              Text(
                message,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

### 5️⃣ Özet & İpuçları

* Firebase, senin kullanıcı yönetimini server tarafında, güvenli ve sağlam yapıyor. Şifre hash’le falan uğraşmana gerek kalmaz, adamlar hallediyor.
* Email doğrulama, şifre resetleme, sosyal login (Google, Facebook vs) gibi daha gelişmiş özellikleri Firebase ile rahatça ekleyebilirsin.
* Firebase Console’dan kullanıcılarını rahatlıkla görebilir, yönetebilirsin.


