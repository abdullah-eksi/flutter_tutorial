

# 🧾 FLUTTER FORM YAPISI (BİREYSEL ÖĞRENCİ FORMS MASTERCLASSS)

## 🔧 FormElement Temelleri

```dart
Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(),
      ElevatedButton(onPressed: () {}, child: Text('Gönder'))
    ],
  ),
);
```

🛠️ Burda önemli 2 şey var:

* `Form` → Form kapsayıcısı (validatorlar çalışsın diye)
* `_formKey` → GlobalKey ile kontrol ediyoruz (formu valid mi diye)

---

## 🔑 FormKey Tanımlama

```dart
final _formKey = GlobalKey<FormState>();
```

---

## 🧼 TextField ve Controller Tanımı

```dart
final _adController = TextEditingController();
```

```dart
TextFormField(
  controller: _adController,
  decoration: InputDecoration(labelText: 'Adınız'),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Bu alan boş bırakılamaz!';
    }
    return null;
  },
),
```

💡 `validator` sayesinde form gönderilmeden önce içerik kontrolü yapılır. Hatalıysa geri döner.

---

## 🚨 Butonla Kontrol Etme

```dart
ElevatedButton(
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      print('Adınız: ${_adController.text}');
    } else {
      print('Form geçersiz 😒');
    }
  },
  child: Text('Gönder'),
)
```

---

## 🎯 Örnek: Basit Form Uygulaması

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: FormOrnegi()));
}

class FormOrnegi extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _isimController = TextEditingController();
  final _yasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Örneği')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _isimController,
                decoration: InputDecoration(labelText: 'İsim'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Boş bırakılmaz!' : null,
              ),
              TextFormField(
                controller: _yasController,
                decoration: InputDecoration(labelText: 'Yaş'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Boş bırakma!';
                  final yas = int.tryParse(value);
                  if (yas == null || yas < 1) return 'Geçerli yaş gir!';
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print('İsim: ${_isimController.text}, Yaş: ${_yasController.text}');
                  }
                },
                child: Text('Kaydet'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 🎁 BONUS: `TextInputType`’lar

| Tip                          | Açıklama         |
| ---------------------------- | ---------------- |
| `TextInputType.text`         | Normal metin     |
| `TextInputType.emailAddress` | Mail inputu      |
| `TextInputType.number`       | Sayı klavyesi    |
| `TextInputType.phone`        | Telefon numarası |

---

