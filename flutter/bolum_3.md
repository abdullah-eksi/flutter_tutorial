

# 🎨 Flutter’da **Custom Widget** ve **Reusability** (Yeniden Kullanılabilirlik)

Flutter’ın olayı **her şeyin widget** olması kanka. Kafanı karıştırmasın: buton da widget, metin de widget, kart da widget, komple sayfa bile widget.

## 🔧 Neden Custom Widget Kullanırız?

* Kod tekrarı olmasın.
* Parçalara ayır, yönetmesi kolay olsun.
* Reusable (yeniden kullanılabilir) olsun.
* Okunabilirlik uçsun.

---

### 💡 Örnek: Özel Buton Widget’ı

```dart
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
```

### 🔥 Kullanım:

```dart
CustomButton(
  text: "Giriş Yap",
  onPressed: () {
    print("Giriş yapıldı!");
  },
)
```

> Bak görüyo musun? Her sayfaya custom buton yazar gibi widget çakıyoruz. Mükemmel modülerlik!

---

# 🎨 Tema Sistemi (ThemeData)

Uygulaman evrensel bir tasarıma sahip olsun istiyorsan işte çözüm: **Tema**!

### 📦 Tema Tanımı:

```dart
MaterialApp(
  title: "Benim App",
  theme: ThemeData(
    primarySwatch: Colors.indigo,
    textTheme: TextTheme(
      bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  ),
  home: AnaSayfa(),
)
```

Artık her buton indigo gelir. 😎
Kendi yazı fontunu bile ekleyebilirsin!

---

# 🧾 Formlar ve Form Doğrulama

Giriş formları yazarken `TextField` değil, `TextFormField` kullan. Form’a kontrol eklemek için `GlobalKey<FormState>` kullanılır.

### 📌 Basit Form Örneği:

```dart
final _formKey = GlobalKey<FormState>();
String email = '';

Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        decoration: InputDecoration(labelText: 'E-posta'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'E-posta girin!';
          }
          return null;
        },
        onSaved: (value) => email = value!,
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            print('Email: $email');
          }
        },
        child: Text('Gönder'),
      ),
    ],
  ),
)
```

---

# ⚡ Navigation (Named Routes + Arguments)

Büyüyen uygulamada `MaterialPageRoute` her yerde olmaz, onun yerine **Named Route** kullanılır.

### Tanım:

```dart
void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => AnaSayfa(),
      '/profil': (context) => ProfilSayfa(),
    },
  ));
}
```

### Gitmek:

```dart
Navigator.pushNamed(context, '/profil');
```

### Veri Göndermek:

```dart
Navigator.pushNamed(
  context,
  '/profil',
  arguments: 'Abdullah',
);
```

Ve karşı tarafta al:

```dart
final isim = ModalRoute.of(context)!.settings.arguments as String;
```

---

# 📱 Responsive Tasarım (Tüm Ekranlara Uyumlu)

Telefonda ayrı, tablette ayrı, geniş ekranda ayrı tasarım istiyorsan:

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 600) {
      return MobilLayout();
    } else {
      return TabletLayout();
    }
  },
);
```

Yani tek widget’ta 2 farklı UI çizersin: mobil vs. geniş ekran.
