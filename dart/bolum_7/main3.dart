void Main() {
String? sehir = 'İstanbul';
print(sehir!); // İstanbul ✅  ! operatörü ile null kontrolü yapıyoruz
sehir = null; // sehir artık null olabilir
print(sehir); // null olur, çökmeyiz
} 