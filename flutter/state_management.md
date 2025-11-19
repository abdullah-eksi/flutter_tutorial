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


