# Flutter'da State Management

## 1. State Management Nedir? (Flutter'da neden önemli?)

**State (Durum)**, bir uygulamanın belirli bir andaki verilerini ve kullanıcı arayüzünün o anki görünümünü tanımlar. Örneğin, bir kullanıcının giriş yapmış olması, bir listeye öğe eklenmesi, bir butona tıklanması gibi her türlü etkileşim state'i değiştirebilir.

**State Management** ise bu durumu yönetme, güncelleme ve uygulamanın farklı bölümlerine iletme sürecidir. Flutter, reaktif bir framework olduğu için state değiştiğinde, bu state'e bağlı olan widget'lar otomatik olarak yeniden oluşturulur (rebuild). Bu, kullanıcı arayüzünün state ile senkronize kalmasını sağlar.

### Neden Önemli?

- **Tutarlılık**: State yönetimi, uygulamanın farklı kısımlarında aynı verilerin tutarlı olmasını sağlar.
- **Performans**: Etkili state yönetimi, gereksiz widget yeniden oluşturmalarını önleyerek performansı artırır.
- **Test Edilebilirlik**: İyi yönetilen state, birim testlerini kolaylaştırır.
- **Bakım**: Kodun düzenli ve anlaşılır olmasını sağlar, özellikle büyük projelerde.

## State Türleri

Flutter'da state iki ana kategoriye ayrılır:

### Ephemeral State (Geçici Durum)
- Sadece bir widget içinde kullanılan ve diğer widget'lar tarafından paylaşılmayan state.
- Genellikle `setState` ile yönetilir.
- Örnek: Bir TextField'ın içeriği, bir Checkbox'ın işaretli olup olmaması.

### App State (Uygulama Durumu)
- Birden fazla widget tarafından paylaşılan state.
- Örnek: Kullanıcı oturumu, alışveriş sepeti, tema tercihi.

Ayrıca, state yönetiminde aşağıdaki kategoriler de düşünülebilir:

- **Local State**: Sadece bir widget veya birkaç widget arasında paylaşılan state.
- **Global State**: Uygulamanın her yerinden erişilebilen state.

## 2. MVC (Model-View-Controller) Yapısı ve State Management

MVC, yazılım mühendisliğinde kullanılan bir tasarım desenidir. Flutter'da state management ile MVC arasında benzerlikler vardır.

- **Model**: Uygulamanın veri yapısını ve iş kurallarını temsil eder. State'in kendisi modelde saklanır.
- **View**: Kullanıcı arayüzüdür. Flutter'da widget'lar view olarak düşünülebilir.
- **Controller**: Model ve view arasındaki etkileşimi yönetir. Kullanıcı girdilerini alır, modeli günceller ve view'ın güncellenmesini sağlar.

Flutter'da state management çözümleri (Provider, Riverpod, Bloc) aslında controller rolünü üstlenir. Modeli yönetir ve view'ın (widget'lar) modeldeki değişikliklere tepki vermesini sağlar.

## 3. Provider

### Temel Kavramlar

Provider, Flutter ekibi tarafından önerilen ve InheritedWidget'ı sarmalayarak kullanımı kolaylaştıran bir state yönetim paketidir. Provider, state'i (modeli) widget ağacının üst seviyelerinde sağlar (provide) ve alt seviyelerdeki widget'ların bu state'e erişmesine ve değişiklikleri dinlemesine olanak tanır.

Provider'ın temel bileşenleri:

- **ChangeNotifier**: State'in değiştiğini dinleyicilere bildiren sınıf. `notifyListeners` metodu çağrıldığında, dinleyen widget'lar yeniden oluşturulur.
- **ChangeNotifierProvider**: ChangeNotifier sınıfını widget ağacına sağlayan widget.
- **Consumer**: Provider'dan değer alan ve değişikliklerde yeniden oluşturulan widget.
- **Provider.of** veya **context.watch**: Provider'a erişim ve dinleme için kullanılan yöntemler.

### Örnek Senaryo: Sayaç Uygulaması

#### Adım 1: Model (Counter sınıfı)

```dart
import 'package:flutter/material.dart';

class Counter extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // Dinleyicilere değişiklik bildirimi
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
}
```

**Açıklama:**
- `Counter` sınıfı `ChangeNotifier`'ı extend ediyor. Bu, `notifyListeners` metodunu kullanabilmesini sağlar.
- `_count` private değişkeni, sayaç değerini tutar.
- `increment` ve `decrement` metodları `_count` değerini değiştirir ve `notifyListeners` çağırır. Bu, bu sınıfı dinleyen widget'ların yeniden oluşturulmasını sağlar.

#### Adım 2: Uygulamanın Kökünde Provider'ı Sağlama

```dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Demo',
      home: MyHomePage(),
    );
  }
}
```

**Açıklama:**
- `ChangeNotifierProvider`, `Counter` sınıfını widget ağacına sağlar.
- `create` parametresi, `Counter` örneğini oluşturur.
- `MyApp` widget'ı, `ChangeNotifierProvider`'ın altında olduğu için `Counter` sınıfına erişebilir.

#### Adım 3: State'i Tüketme (Consuming)

```dart
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Provider Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have pushed the button this many times:'),
            Consumer<Counter>(
              builder: (context, counter, child) {
                return Text(
                  '${counter.count}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<Counter>(context, listen: false).increment();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
```

**Açıklama:**
- `Consumer<Counter>` widget'ı, `Counter` sınıfındaki değişiklikleri dinler ve `builder` metodunu yeniden çalıştırır.
- `builder` metodu, `counter` parametresi olarak `Counter` örneğini alır ve `counter.count` değerini gösterir.
- `FloatingActionButton`'ın `onPressed` metodunda `Provider.of<Counter>(context, listen: false)` kullanılarak `Counter` sınıfına erişilir ve `increment` metodu çağrılır. `listen: false` because we only need to read the value and don't want to rebuild when the counter changes.

Alternatif olarak, `context.watch` ve `context.read` kullanılabilir:

```dart
// Dinleme için
final counter = context.watch<Counter>().count;

// Sadece okuma için
context.read<Counter>().increment();
```

### Provider'ın Avantajları ve Dezavantajları

#### Avantajları:
- Kolay öğrenilir ve kullanılır.
- Resmi olarak Flutter ekibi tarafından önerilir.
- Küçük ve orta ölçekli uygulamalar için idealdir.

#### Dezavantajları:
- Büyük uygulamalarda çok sayıda provider karmaşık hale gelebilir.
- Hatalar çalışma zamanında ortaya çıkabilir (örneğin, provider bulunamazsa).

## 4. Riverpod

### Provider'dan Farkları

Riverpod, Provider'ın yaratıcısı tarafından geliştirilmiş ve Provider'ın sınırlamalarını gidermeyi hedefleyen bir state yönetim kütüphanesidir. Temel farklar:

- **Widget ağacından bağımsız**: Provider, InheritedWidget'a dayandığı için widget ağacına bağımlıdır. Riverpod ise sağlayıcıları (providers) widget ağacından bağımsız olarak tanımlar.
- **Derleme zamanı güvenliği**: Riverpod, sağlayıcıların derleme zamanında kontrol edilmesini sağlar. Eksik sağlayıcılar derleme hatası verir.
- **Daha fazla özellik**: Family, autoDispose, ScopedProvider gibi özelliklerle daha gelişmiş senaryoları destekler.

### Örnek Senaryo: Sayaç Uygulaması

#### Adım 1: Paket Ekleme

`pubspec.yaml` dosyasına `flutter_riverpod` ekleyin.

#### Adım 2: ProviderScope

```dart
void main() {
  runApp(ProviderScope(child: MyApp()));
}
```

`ProviderScope`, Riverpod'ın çalışması için gereklidir ve uygulamanın köküne eklenir.

#### Adım 3: Sağlayıcı (Provider) Tanımlama

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier kullanımı için model ve notifier sınıfları
class CounterModel {
  final int count;
  CounterModel(this.count);
}

class CounterNotifier extends StateNotifier<CounterModel> {
  CounterNotifier() : super(CounterModel(0));

  void increment() {
    state = CounterModel(state.count + 1);
  }

  void decrement() {
    state = CounterModel(state.count - 1);
  }
}

// StateNotifierProvider tanımlama
final counterProvider = StateNotifierProvider<CounterNotifier, CounterModel>((ref) {
  return CounterNotifier();
});
```

**Açıklama:**
- `CounterModel`, state'in yapısını tanımlar.
- `CounterNotifier`, state'i yöneten sınıftır. `StateNotifier`'ı extend eder ve state'i günceller.
- `counterProvider`, `StateNotifierProvider` tipinde bir sağlayıcıdır. `CounterNotifier` örneğini oluşturur.

#### Adım 4: Tüketme (Consuming)

```dart
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Riverpod Example')),
      body: Center(
        child: Text(
          '${counter.count}',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier).increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
```

**Açıklama:**
- `ConsumerWidget`, build metoduna `WidgetRef ref` parametresini ekler. Bu `ref`, sağlayıcılara erişim sağlar.
- `ref.watch(counterProvider)` ile `counterProvider` dinlenir ve değer alınır.
- `ref.read(counterProvider.notifier)` ile `CounterNotifier` örneğine erişilir ve `increment` metodu çağrılır.

### Riverpod'ın Avantajları ve Dezavantajları

#### Avantajları:
- Derleme zamanı güvenliği.
- Widget ağacından bağımsız.
- Test edilebilirlik.
- Family, autoDispose gibi gelişmiş özellikler.

#### Dezavantajları:
- Öğrenme eğrisi Provider'a göre daha yüksek.
- Nispeten yeni bir kütüphane.

## 5. Bloc

### Event-State Yapısı

BLoC (Business Logic Component) deseni, iş mantığını UI'dan ayırmak için kullanılır. BLoC, event'leri (olay) state'lere (durum) dönüştürür. UI, event'leri BLoC'ye gönderir, BLoC state'leri yayınlar ve UI da bu state'lere göre güncellenir.

Bloc paketinin iki varyasyonu vardır:

- **Bloc**: Event-state yapısını kullanır. Her event için bir state dönüşümü vardır.
- **Cubit**: Daha basittir, event kullanmaz. Metodlar çağrılarak state değiştirilir.

### Örnek Senaryo: Sayaç Uygulaması (Bloc Kullanarak)

#### Adım 1: Event ve State Tanımlama

```dart
// Events
abstract class CounterEvent {}

class Increment extends CounterEvent {}

class Decrement extends CounterEvent {}

// State
class CounterState {
  final int count;
  CounterState(this.count);
}
```

**Açıklama:**
- `CounterEvent` abstract sınıfı, event'leri temsil eder. `Increment` ve `Decrement` event'leri.
- `CounterState`, state'i temsil eder. `count` değişkeni mevcut sayıyı tutar.

#### Adım 2: Bloc Sınıfı

```dart
import 'package:bloc/bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<Increment>((event, emit) {
      emit(CounterState(state.count + 1));
    });
    on<Decrement>((event, emit) {
      emit(CounterState(state.count - 1));
    });
  }
}
```

**Açıklama:**
- `CounterBloc`, `Bloc<CounterEvent, CounterState>` sınıfını extend eder.
- Constructor'da başlangıç state'i `CounterState(0)` olarak verilir.
- `on<Increment>` ve `on<Decrement>` event handler'ları tanımlanır. Her event geldiğinde, mevcut state'e göre yeni state oluşturulur ve `emit` ile yayınlanır.

#### Adım 3: BlocProvider ve BlocBuilder

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CounterBloc(),
        child: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bloc Example')),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Text(
              '${state.count}',
              style: Theme.of(context).textTheme.headline4,
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(Increment());
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(Decrement());
            },
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
```

**Açıklama:**
- `BlocProvider`, `CounterBloc` örneğini widget ağacına sağlar.
- `BlocBuilder<CounterBloc, CounterState>`, `CounterBloc`'u dinler ve state değiştiğinde `builder` metodunu çalıştırır.
- `FloatingActionButton`'lar, `context.read<CounterBloc>().add(Increment())` ile event'i Bloc'e gönderir.

### Cubit Kullanımı

Cubit, Bloc'in daha basit halidir. Event yerine doğrudan metodlar kullanılır.

#### Cubit Sınıfı:

```dart
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
```

**Açıklama:**
- `CounterCubit`, `Cubit<int>` sınıfını extend eder. State tipi `int` olarak belirlenmiştir.
- `increment` ve `decrement` metodları `emit` ile state'i günceller.

#### Kullanımı:

```dart
class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cubit Example')),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Text(
              '$state',
              style: Theme.of(context).textTheme.headline4,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterCubit>().increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
```

**Açıklama:**
- `BlocBuilder<CounterCubit, int>` ile `CounterCubit` dinlenir ve state (int) kullanılır.
- `context.read<CounterCubit>().increment()` ile Cubit'in metodu çağrılır.

### Bloc'un Avantajları ve Dezavantajları

#### Avantajları:
- İş mantığı ile UI tamamen ayrılmıştır.
- Test edilebilirlik çok yüksektir.
- Büyük ve karmaşık uygulamalar için idealdir.

#### Dezavantajları:
- Öğrenme eğrisi yüksektir.
- Küçük uygulamalar için fazla karmaşık olabilir.
- Boilerplate kod çoktur.

## 6. Hangisi Ne Zaman Kullanılır?

- **Provider**: Küçük ve orta ölçekli uygulamalar, hızlı prototipleme, öğrenmesi kolay bir çözüm istendiğinde.
- **Riverpod**: Orta ve büyük ölçekli uygulamalar, derleme zamanı güvenliği, test edilebilirlik ve modern bir çözüm istendiğinde.
- **Bloc/Cubit**: Büyük ve karmaşık uygulamalar, iş mantığının UI'dan tamamen ayrılması, test güdümlü geliştirme istendiğinde.

## 7. Özet Karşılaştırma Tablosu

| Özellik | Provider | Riverpod | Bloc/Cubit |
|---------|----------|----------|------------|
| Temel Model | InheritedWidget | Dart değişkenleri | Event-State veya direkt metod |
| Widget Ağacına Bağımlılık | Evet | Hayır | Evet (BlocProvider ile) |
| Derleme Zamanı Güvenliği | Hayır | Evet | Evet |
| Boilerplate | Az | Orta | Çok (Bloc), Az (Cubit) |
| Öğrenme Eğrisi | Kolay | Orta | Zor (Bloc), Orta (Cubit) |
| Test Edilebilirlik | Orta | Yüksek | Çok Yüksek |
| Büyük Uygulamalar | Sınırlı | Uygun | Çok Uygun |

## 8. Öğrenme Yol Haritası

1. Temel Flutter Kavramları: Widget'lar, setState, Stateless ve Stateful widget'lar.
2. Provider: Basit state yönetimi için.
3. Riverpod: Daha gelişmiş ve güvenli state yönetimi için.
4. Bloc/Cubit: Karmaşık iş mantığı ve test için.

## 9. Sonuç

State management, Flutter'da uygulamanın ölçeğine ve karmaşıklığına göre seçilmelidir. Küçük uygulamalar için Provider yeterli olabilirken, büyük uygulamalar için Riverpod veya Bloc tercih edilebilir. Her bir çözümün kendi avantaj ve dezavantajları vardır. Önemli olan proje ihtiyaçlarına en uygun olanı seçmektir.


Flutter'da State Management rehberini daha kapsamlı ve detaylı hale getirerek genişletelim. Her kavramı, state türlerini ve örnekleri detaylı açıklamalarla ele alalım.

## 1. State Management Nedir? (Detaylı Açıklama)

### State (Durum) Kavramının Derinlemesine İncelenmesi

**State**, bir uygulamanın belirli bir andaki "hafızasıdır". Bu hafıza şu bileşenleri içerir:

```dart
// Uygulama State'inin anatomisi
class AppState {
  // 1. VERİ STATE'I
  final List<Product> products;        // Ürün listesi
  final User? currentUser;            // Giriş yapan kullanıcı
  final Map<String, dynamic> settings; // Uygulama ayarları

  // 2. UI STATE'I
  final bool isLoading;               // Yükleme durumu
  final int selectedTab;              // Seçili sekme
  final String searchQuery;           // Arama metni
  final bool isDarkMode;              // Karanlık mod

  // 3. İŞ MANTIĞI STATE'I
  final Cart cart;                    // Alışveriş sepeti
  final Order? currentOrder;          // Geçerli sipariş
  final List<Notification> notifications; // Bildirimler

  // 4. OTURUM STATE'I
  final bool isLoggedIn;              // Giriş durumu
  final DateTime lastActivity;        // Son etkinlik zamanı
}
```

### Neden State Management Gereklidir?

**Problem Senaryoları:**

1. **Widget Ağacı Karmaşıklığı:**
```dart
// STATE'SIZ YAKLAŞIM - KARMAŞIK
class ProductDetailPage extends StatefulWidget {
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Product? product;
  bool isLoading = true;
  String error = '';
  List<Review> reviews = [];
  bool isFavorite = false;
  int quantity = 1;

  // 10+ farklı state değişkeni ve metodları...
  // Kod karmaşık ve bakımı zor
}
```

2. **Veri Tutarsızlığı:**
```dart
// YANLIŞ - Aynı veri birden fazla yerde
class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context).products;
    // products değiştiğinde tüm widget rebuild oluyor
  }
}

class CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartCount = Provider.of<CartProvider>(context).itemCount;
    // Sadece cart count değiştiğinde rebuild olmalı
  }
}
```

## 2. State Türleri ve Kategorizasyon

### 2.1. Ephemeral State (Geçici Durum) - Detaylı

**Tanım:** Tek bir widget'a özgü, kısa ömürlü state.

```dart
class _LoginFormState extends State<LoginForm> {
  // EPHEMERAL STATE ÖRNEKLERİ
  String _email = '';                    // Email input
  String _password = '';                 // Şifre input
  bool _obscurePassword = true;          // Şifreyi gizle/göster
  bool _rememberMe = false;              // Beni hatırla
  FormState _formState = FormState.idle; // Form durumu

  // Geçici state metodları
  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _onEmailChanged(String value) {
    setState(() {
      _email = value;
      _validateForm();
    });
  }

  bool get _isFormValid {
    return _email.isNotEmpty &&
           _password.length >= 6 &&
           _email.contains('@');
  }
}
```

### 2.2. App State (Uygulama Durumu) - Detaylı

**Tanım:** Uygulama genelinde paylaşılan, kalıcı state.

```dart
// APP STATE YÖNETİMİ - DETAYLI
class AppStateManager with ChangeNotifier, DiagnosticableTreeMixin {
  // KULLANICI STATE'I
  User? _currentUser;
  UserProfile? _userProfile;
  List<Address> _userAddresses = [];

  // ÜRÜN STATE'I
  List<Product> _allProducts = [];
  List<Product> _featuredProducts = [];
  List<Product> _searchResults = [];

  // SEPET STATE'I
  List<CartItem> _cartItems = [];
  double _cartTotal = 0.0;

  // AYARLAR STATE'I
  AppTheme _currentTheme = AppTheme.light;
  Locale _currentLocale = Locale('tr', 'TR');
  bool _notificationsEnabled = true;

  // GETTER'LAR
  User? get currentUser => _currentUser;
  List<Product> get cartItems => _cartItems;
  double get cartTotal => _cartTotal;
  bool get isLoggedIn => _currentUser != null;

  // STATE DEĞİŞİKLİK METODLARI
  Future<void> login(String email, String password) async {
    try {
      _currentUser = await AuthService.login(email, password);
      _userProfile = await UserService.getProfile(_currentUser!.id);
      await _loadUserData();
      notifyListeners();
    } catch (error) {
      throw AuthException('Giriş başarısız: $error');
    }
  }

  void addToCart(Product product, {int quantity = 1}) {
    final existingItem = _cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity > 0) {
      existingItem.quantity += quantity;
    } else {
      _cartItems.add(CartItem(product: product, quantity: quantity));
    }

    _calculateCartTotal();
    notifyListeners();

    // Yerel depolamaya kaydet
    StorageService.saveCart(_cartItems);
  }

  void _calculateCartTotal() {
    _cartTotal = _cartItems.fold(0.0, (total, item) {
      return total + (item.product.price * item.quantity);
    });
  }

  // DEBUG BİLGİLERİ
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<User?>('currentUser', _currentUser));
    properties.add(IterableProperty<Product>('cartItems', _cartItems));
    properties.add(DoubleProperty('cartTotal', _cartTotal));
  }
}
```

## 3. Provider - Detaylı Kullanım ve Pattern'ler

### 3.1. MultiProvider ile Kompleks Uygulama Yapısı

```dart
// UYGULAMA BAŞLANGICI - MULTI PROVIDER
void main() {
  runApp(
    MultiProvider(
      providers: [
        // AUTHENTICATION PROVIDER
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
          lazy: false, // Hemen oluştur
        ),

        // PRODUCT PROVIDER
        ChangeNotifierProxyProvider<AuthProvider, ProductProvider>(
          create: (context) => ProductProvider(),
          update: (context, authProvider, productProvider) {
            return productProvider!..initialize(authProvider);
          },
        ),

        // CART PROVIDER
        ChangeNotifierProvider<CartProvider>(
          create: (_) => CartProvider(),
        ),

        // THEME PROVIDER
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),

        // LOCALIZATION PROVIDER
        ChangeNotifierProvider<LocalizationProvider>(
          create: (_) => LocalizationProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localizationProvider = Provider.of<LocalizationProvider>(context);

    return MaterialApp(
      title: 'E-Ticaret App',
      theme: themeProvider.currentTheme,
      locale: localizationProvider.currentLocale,
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          // Kullanıcı durumuna göre yönlendirme
          if (authProvider.isLoading) {
            return SplashScreen();
          } else if (authProvider.isLoggedIn) {
            return HomePage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
```

### 3.2. Select ve Consumer ile Performans Optimizasyonu

```dart
// PERFORMANS ODAKLI WIDGET YAPISI
class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ürünler'),
        actions: [
          // SADECE SEPET SAYISI DEĞİŞTİĞİNDE YENİDEN ÇİZ
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Badge(
                count: cart.itemCount,
                child: child!,
              );
            },
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => CartPage())),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Arama çubuğu - sadece arama değiştiğinde yeniden çiz
          Consumer<ProductProvider>(
            builder: (context, productProvider, child) {
              return SearchBar(
                onSearch: (query) => productProvider.searchProducts(query),
                initialValue: productProvider.searchQuery,
              );
            },
          ),

          // Ürün listesi - sadece ürünler değiştiğinde yeniden çiz
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
                if (productProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (productProvider.hasError) {
                  return ErrorWidget(
                    message: productProvider.errorMessage!,
                    onRetry: productProvider.loadProducts,
                  );
                }

                return ProductGridView(
                  products: productProvider.visibleProducts,
                  onProductTap: (product) {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (_) =>
                        ChangeNotifierProvider.value(
                          value: productProvider,
                          child: ProductDetailPage(product: product),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

## 4. Riverpod - İleri Seviye Pattern'ler

### 4.1. Family ve AutoDispose Kullanımı

```dart
// RIVERPOD İLE DETAYLI STATE YÖNETİMİ

// 1. MODEL SINIFLARI
class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });
}

class ProductState {
  final Product product;
  final bool isLoading;
  final String? error;
  final int quantity;

  const ProductState({
    required this.product,
    this.isLoading = false,
    this.error,
    this.quantity = 1,
  });

  ProductState copyWith({
    Product? product,
    bool? isLoading,
    String? error,
    int? quantity,
  }) {
    return ProductState(
      product: product ?? this.product,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      quantity: quantity ?? this.quantity,
    );
  }
}

// 2. STATE NOTIFIER
class ProductNotifier extends StateNotifier<ProductState> {
  final String productId;
  final Ref ref;

  ProductNotifier(this.productId, this.ref) : super(
    ProductState(
      product: Product(
        id: productId,
        name: '',
        price: 0.0,
        imageUrl: '',
        description: '',
      ),
      isLoading: true,
    ),
  ) {
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final product = await ref.read(productRepositoryProvider)
          .getProduct(productId);

      state = state.copyWith(
        product: product,
        isLoading: false,
      );
    } catch (error) {
      state = state.copyWith(
        error: 'Ürün yüklenemedi: $error',
        isLoading: false,
      );
    }
  }

  void increaseQuantity() {
    state = state.copyWith(quantity: state.quantity + 1);
  }

  void decreaseQuantity() {
    if (state.quantity > 1) {
      state = state.copyWith(quantity: state.quantity - 1);
    }
  }

  Future<void> addToCart() async {
    try {
      await ref.read(cartRepositoryProvider).addToCart(
        productId: state.product.id,
        quantity: state.quantity,
      );

      // Başarı mesajı göster
      ref.read(toastProvider).showSuccess('Ürün sepete eklendi');
    } catch (error) {
      ref.read(toastProvider).showError('Sepete eklenemedi: $error');
    }
  }
}

// 3. PROVIDER'LAR
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepository();
});

// Family + AutoDispose: Her ürün için ayrı state ve otomatik temizlik
final productProvider = StateNotifierProvider.autoDispose
  .family<ProductNotifier, ProductState, String>((ref, productId) {
  return ProductNotifier(productId, ref);
});

// 4. WIDGET KULLANIMI
class ProductDetailPage extends ConsumerWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productProvider(productId));

    return Scaffold(
      appBar: AppBar(title: Text('Ürün Detayı')),
      body: productState.isLoading
          ? Center(child: CircularProgressIndicator())
          : productState.error != null
            ? ErrorWidget(
                message: productState.error!,
                onRetry: () => ref.refresh(productProvider(productId)),
              )
            : _buildProductDetail(productState),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(productProvider(productId).notifier).addToCart(),
        child: Icon(Icons.shopping_cart),
      ),
    );
  }

  Widget _buildProductDetail(ProductState state) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(state.product.imageUrl),
          SizedBox(height: 16),
          Text(state.product.name, style: TextStyle(fontSize: 24)),
          Text('${state.product.price} TL', style: TextStyle(fontSize: 20)),
          SizedBox(height: 16),
          Text(state.product.description),
          SizedBox(height: 16),
          _buildQuantitySelector(),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Consumer(
      builder: (context, ref, child) {
        final quantity = ref.watch(
          productProvider(productId).select((state) => state.quantity)
        );

        return Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => ref.read(productProvider(productId).notifier)
                  .decreaseQuantity(),
            ),
            Text('$quantity', style: TextStyle(fontSize: 18)),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => ref.read(productProvider(productId).notifier)
                  .increaseQuantity(),
            ),
          ],
        );
      },
    );
  }
}
```

## 5. Bloc/Cubit - İleri Seviye Mimari

### 5.1. Bloc ile Kompleks İş Akışı

```dart
// BLOK İLE DETAYLI STATE YÖNETİMİ

// 1. STATE HIERARCHY
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  final String token;

  AuthSuccess({required this.user, required this.token});
}

class AuthError extends AuthState {
  final String message;
  final AuthErrorType errorType;

  AuthError({required this.message, required this.errorType});
}

class AuthValidationError extends AuthState {
  final String emailError;
  final String passwordError;

  AuthValidationError({this.emailError = '', this.passwordError = ''});
}

// 2. EVENT HIERARCHY
abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;

  LoginRequested({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });
}

class LogoutRequested extends AuthEvent {}

class ValidateCredentials extends AuthEvent {
  final String email;
  final String password;

  ValidateCredentials({required this.email, required this.password});
}

// 3. BLOK SINIFI
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final StorageRepository storageRepository;

  AuthBloc({
    required this.authRepository,
    required this.storageRepository,
  }) : super(AuthInitial()) {

    // EVENT HANDLER'LAR
    on<ValidateCredentials>(_onValidateCredentials);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  void _onValidateCredentials(
    ValidateCredentials event,
    Emitter<AuthState> emit,
  ) {
    final emailError = _validateEmail(event.email);
    final passwordError = _validatePassword(event.password);

    if (emailError.isNotEmpty || passwordError.isNotEmpty) {
      emit(AuthValidationError(
        emailError: emailError,
        passwordError: passwordError,
      ));
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      // Credential validation
      final emailError = _validateEmail(event.email);
      final passwordError = _validatePassword(event.password);

      if (emailError.isNotEmpty || passwordError.isNotEmpty) {
        emit(AuthValidationError(
          emailError: emailError,
          passwordError: passwordError,
        ));
        return;
      }

      // API call
      final authResponse = await authRepository.login(
        email: event.email,
        password: event.password,
      );

      // Save token and user data
      if (event.rememberMe) {
        await storageRepository.saveToken(authResponse.token);
        await storageRepository.saveUser(authResponse.user);
      }

      emit(AuthSuccess(
        user: authResponse.user,
        token: authResponse.token,
      ));

    } on AuthException catch (e) {
      emit(AuthError(
        message: e.message,
        errorType: AuthErrorType.credentials,
      ));
    } on NetworkException catch (e) {
      emit(AuthError(
        message: 'Ağ hatası: ${e.message}',
        errorType: AuthErrorType.network,
      ));
    } catch (e) {
      emit(AuthError(
        message: 'Beklenmeyen hata: $e',
        errorType: AuthErrorType.unknown,
      ));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await authRepository.logout();
      await storageRepository.clearAll();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(
        message: 'Çıkış yapılamadı: $e',
        errorType: AuthErrorType.unknown,
      ));
    }
  }

  String _validateEmail(String email) {
    if (email.isEmpty) return 'Email gereklidir';
    if (!EmailValidator.validate(email)) return 'Geçerli bir email girin';
    return '';
  }

  String _validatePassword(String password) {
    if (password.isEmpty) return 'Şifre gereklidir';
    if (password.length < 6) return 'Şifre en az 6 karakter olmalıdır';
    return '';
  }
}

// 4. WIDGET KULLANIMI
class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        authRepository: context.read<AuthRepository>(),
        storageRepository: context.read<StorageRepository>(),
      ),
      child: Scaffold(
        appBar: AppBar(title: Text('Giriş Yap')),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                // Giriş başarılı - ana sayfaya yönlendir
                Navigator.pushReplacementNamed(context, '/home');
              } else if (state is AuthError) {
                // Hata mesajını göster
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: Column(
              children: [
                _EmailInput(controller: emailController),
                _PasswordInput(controller: passwordController),
                _LoginButton(
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                _ValidationMessages(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  final TextEditingController controller;

  const _EmailInput({required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) =>
        current is AuthValidationError || current is AuthInitial,
      builder: (context, state) {
        String errorText = '';
        if (state is AuthValidationError) {
          errorText = state.emailError;
        }

        return TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: errorText.isNotEmpty ? errorText : null,
          ),
          onChanged: (email) {
            context.read<AuthBloc>().add(ValidateCredentials(
              email: email,
              password: context.read<AuthBloc>().state is AuthValidationError
                ? (context.read<AuthBloc>().state as AuthValidationError).passwordError.isNotEmpty
                  ? ''
                  : controller.text
                : '',
            ));
          },
        );
      },
    );
  }
}
```

## 6. State Management Pattern'leri ve Best Practices

### 6.1. Immutable State Pattern

```dart
// IMMUTABLE STATE YÖNETİMİ
@immutable
class AppState {
  final User? user;
  final List<Product> products;
  final Cart cart;
  final AppTheme theme;
  final bool isLoading;
  final String? error;

  const AppState({
    this.user,
    this.products = const [],
    required this.cart,
    required this.theme,
    this.isLoading = false,
    this.error,
  });

  AppState copyWith({
    User? user,
    List<Product>? products,
    Cart? cart,
    AppTheme? theme,
    bool? isLoading,
    String? error,
  }) {
    return AppState(
      user: user ?? this.user,
      products: products ?? this.products,
      cart: cart ?? this.cart,
      theme: theme ?? this.theme,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      other is AppState &&
      runtimeType == other.runtimeType &&
      user == other.user &&
      listEquals(products, other.products) &&
      cart == other.cart &&
      theme == other.theme &&
      isLoading == other.isLoading &&
      error == other.error;
  }

  @override
  int get hashCode {
    return Object.hash(user, products, cart, theme, isLoading, error);
  }
}
```

### 6.2. Repository Pattern ile State Management

```dart
// REPOSITORY PATTERN
abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProduct(String id);
  Future<List<Product>> searchProducts(String query);
  Future<void> addProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String id);
}

class ProductRepositoryImpl implements ProductRepository {
  final ProductApi api;
  final ProductDao dao;

  ProductRepositoryImpl({required this.api, required this.dao});

  @override
  Future<List<Product>> getProducts() async {
    try {
      // Önce cache'den dene
      final cachedProducts = await dao.getCachedProducts();
      if (cachedProducts.isNotEmpty) {
        return cachedProducts;
      }

      // Cache yoksa API'den çek
      final products = await api.fetchProducts();

      // Cache'e kaydet
      await dao.cacheProducts(products);

      return products;
    } catch (e) {
      throw ProductRepositoryException('Ürünler yüklenemedi: $e');
    }
  }
}
```


