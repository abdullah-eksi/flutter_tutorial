void main(){
  var liste1 = [1, 2, 3];
var liste2 = [0, ...liste1, 4];
print("Spread operatörü ile örnek:");
// liste2 = [0, 1, 2, 3, 4] olur 
print(liste2); // [0, 1, 2, 3, 4]


// Eğer liste1 null olursa hata alırız
// bunu cözmek için null güvenli spread kullanabiliriz
print("Null güvenli spread operatörü ile örnek:");
List<int>? sayilar = null;

var yeniListe = [0, ...?sayilar, 5];
print(yeniListe); // [0, 5]

}