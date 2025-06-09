
## 💡 ÖZEL (CUSTOM) TEXT FIELD WIDGET OLUŞTURMA

Her form alanı için tekrar tekrar `TextFormField` yazmak delilik!
Kod tekrarı varsa, akıllı yazılımcı `Widget` yazar.

---

### 🧱 Temel Custom InputField Oluşturma

```dart
class CustomInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomInputField({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label),
      validator: validator,
    );
  }
}
```

---

### ⚙️ Kullanımı

```dart
CustomInputField(
  label: "E-posta",
  controller: _emailController,
  validator: (value) {
    if (value == null || value.isEmpty) return 'E-posta boş bırakılamaz!';
    if (!value.contains('@')) return 'Geçerli e-posta girin!';
    return null;
  },
  keyboardType: TextInputType.emailAddress,
),
```

Bu kadar temiz. Eklersin 50 tane form alanı, tertemiz widget’la paşa paşa yazarsın.

---

## 🔐 ŞİFRE GÖSTER / GİZLE - GÖZ İKONU OLAYI

```dart
bool _obscure = true;

TextFormField(
  controller: _passwordController,
  obscureText: _obscure,
  decoration: InputDecoration(
    labelText: 'Şifre',
    suffixIcon: IconButton(
      icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
      onPressed: () {
        setState(() {
          _obscure = !_obscure;
        });
      },
    ),
  ),
)
```

Bu yapı, formun güvenliğini ve kullanıcı deneyimini artırır.
Kullanıcı hem şifresini yazabilir, hem de görmek isterse göz ikonuna tıklar.

---

## ✅ Checkbox / RadioButton / Dropdown Eklemek

### ☑️ Checkbox Kullanımı

```dart
bool _kabulEdildi = false;

CheckboxListTile(
  title: Text('Şartları kabul ediyorum'),
  value: _kabulEdildi,
  onChanged: (value) {
    setState(() {
      _kabulEdildi = value!;
    });
  },
),
```

### 🧿 Radio Button

```dart
enum Cinsiyet { erkek, kadin }
Cinsiyet? _cinsiyet = Cinsiyet.erkek;

RadioListTile(
  title: Text('Erkek'),
  value: Cinsiyet.erkek,
  groupValue: _cinsiyet,
  onChanged: (Cinsiyet? value) {
    setState(() {
      _cinsiyet = value;
    });
  },
),
```

---

### 📂 DropdownButton Kullanımı

```dart
String? secilenSehir;
List<String> sehirler = ['İstanbul', 'Ankara', 'İzmir'];

DropdownButtonFormField(
  value: secilenSehir,
  items: sehirler.map((sehir) {
    return DropdownMenuItem(
      value: sehir,
      child: Text(sehir),
    );
  }).toList(),
  onChanged: (value) {
    setState(() {
      secilenSehir = value as String;
    });
  },
  decoration: InputDecoration(labelText: 'Şehir Seç'),
),
```

---

## 🗂️ BİTTİ Mİ? TABİ Kİ HAYIR

Bunları öğrendik ama asıl yetenek:

🧠 Form verisini **Model Class**'a aktarmak
🔄 Provider, Riverpod veya Bloc ile **form state** yönetimi
📤 **REST API POST** işlemleri ile veriyi gönderip kayıt oluşturmak
📦 **Hive / SharedPreferences** gibi local DB'ye form verisi kaydetmek

