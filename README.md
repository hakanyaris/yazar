# yazar

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
1=> main oluşturuyoruz
2=> view klasörü ve içinde kitaplar_sayfasi.dart oluşuruyoruz.   
3=> mainde MaterialApp(home: KitaplarSayfasi()); diyoruz.
4=> (Görsel olarak  kitaplarSayfasi ni tasarlıyoruz)Appbar ve FlotatingActionButton yerleştriyoruz.Buton onPress fonk _kitapEkle fonsinon tanımlıyoruz + simgesi veriyoruz
5=> KiapEkle fonksiyonunun içinde de _pencereAc() fonksinyonu tanımladık.
6=> pencereAc Fonsiyonn içine ShowDialog  onun da içine AlertDialog fonk. koyuyoruz Alert dilaloga kitap eklemek için bir TextField()  ,iki tane buton koyuyoruz(TextButton) koyuyoruz iptal ve kaydet 
7=> Texfiel yazılan değeri String sonuc  değerine eşitlerdik sonuc değerini  return showDilog<String> diyerek  ve  Future<String>?>  _pencereAc  diyerek fonsiyoru geriye String döndürür şekilde ayarladık.
8=> Kitap Sınıfı oluşturuyoruz Model klasörü açıp içine Kitap sınıfı oluşturuyoruz. int? id,Sring isim ,DateTime olusturulmaTarihi ve kurucu metot;
9=>_kitapEkle() FONKSİYONUN içine  yeni birkitap nesenesi oluştrup _pencereAc dan gelen sonuc (kitap adı) değerini kitap adı olarak veriyoruz.
-------------SQFLİTE EKLEME------------
10=> db Browser for sqLite windows versionunu indiriyoruz bu sql kodarını otomatik olarak oluşturur.sqflite eklentisi  telfon hafızasına veri kaydetmeye yarar
    not(sqLite kodu almak için bu programı kuruyoruz sqlite kodu elimizde varsa bu programı kurmamıza gerek yok kodları direkt visula stidio kodda kullanabiliriz.)
11=> Yeni Bir veritabanı oluşturmak için New Database tıklıyoruz uygulamanın ismini Veri tabanına veriyoruz.otomatik olarak  tablo adı verme çıkıyor kitaplar  diyoruz ekleye tıklayıcna kitaplar içindeki verileri id isim yazar sayfaSayisi ilkBasimYili  EKLİYOROZ İd ,sayfaSayisi ve ilkbasimYili int diğerleri text  türünde olacak aşağıdaki kolanda bizim verilerin sql kodunu otomatik oluşturuyor.
12=> Tablodaki NN(NOT NULL) checkPoint i örneğin id için seçiliyse tabloya id gelmezse bu kitap veritanına eklenmez. id ve isim için kullanıyoruz
13=>Biricil anahtar(Primary key)  esas anahtar.id için bunu seçiyoruz
14=> Otomatik Arttırma(Auto Implement)= otomatik arttırılan id gibi alanlarda kullanılır
15=> Benzersiz(Unique) verildiği satırda girilen değer başka satırda girilemez genelde id kullanılır
16=> aşağı kolonda oluşan kodu kopyalıyoruz  (istersek veya ok basıp taboyu oluşturuyoruz)
17=> üst menüde Execute SQL  tıklayıp kopyaladığımız veriyi buraya yapıştırıyoruz.  Play (çalıştır ) butonunu tıklayınca tablomuz oluşuyor.
18=> üst menüde BrowseData tıkladığımızda  kitaplar tablosunu oluştuğunu görüyoruz. 
19=> sqlite kodlarının düzgün çalıştığını gördüğümüzde üst menüde execute SQL TIKLAYIP kodları kopyalıyoruz.
 --------------Yerel Veri Tabanı(yerel_veri_tabani.dart)-----------------
20=> YerelVeriTabani(yerel_veri_tabani.dart) sınıfı oluşturuyoruz.
21=> Sınıftan oluşturulan tüm nesneler(new) aynı nesne dönmesi için singletion desenenin YerelVeriTabani sınıfına uyguluyoruz.
22=> sqflite eklentisi projemize dahil ediyoruz.pub dev adresine gidip sqflite yazıp eklentiyi ekliyoruz
23=> YerelVeriTabani sınıfına Database nesnesi oluştruyoruz(Database? veriTabani;) böylece 
import 'package:sqflite/sqflite.dart'; otomatik eklenir
24=> Telefon hafızasında veretabanı oluşturan veya oluşturulmuşsa geriye oluşturulan veri tabanını geri dönderen bir fonksiyon yazıyoruz  Future<Datbase?> _veritabaniGetir()async{};
25=> _veriTabaniGetir fonksiyonunun içine  dosyaYolu(getDatabasesPath()) ardından veritananın  cep telefonu hafızasında oluşturması veya mevcutsa açması için  openDatabase(veriTabaiYolu,version:1,onCreate: ,onUpgrade:)   fonk çağırıyoruz onCreate fonk veritabanı oluşturulmamışsa tabloları oluşturacak fonksiyounu atayacağız   
26=> oncreate : (Database db,int version)  db ve version parametrelerini alıyor future döndürüyor.
27=> oncreate içine { db.execute("""   """) } ekliyoruz . execute yani oluşturulacak tablonun sql kodlarını(19 adımdaki) kopyalayıp buraday yapıştırıyoruz.üç tane tırnak arasına yapıştırılan her şey string olarak algılanır bu da string istiyor bizden  
28=> tabloadı id ,isim ,olusturulmaTarihi gibi verilerin adlarını silip   _veriTabaniGetir fonksiyorun içinde String  olarak tutuyoruz. String _kitaplarTabloAdi="Kitaplar; Stirng _kiplarId ="id"; gibi
------------CRUD Create (Create,Read,Upgrade,Delete)
29=> Tabloya kitap eklemek için Create fonksiyonu oluşturuyoruz. Future<int> createKİtap(Kitap kitap) 
burada db.insert(tabloADI, Map<String,dynamic>) kitap verilerini map a çevirmek için  Kitap sınıfı içinde 
Map<String,object> toMap  fonsiyonu yazıyoruz  kitap.toMap  ekliyoruz .insert fonksiyonu geriye eklenen verinin id döndürülüyor
------------createKİtap Fonksiyonunu _kitapEkle()fonksiyounda çağırmak
30=>  KitaplarSayfasi() gidip  Yerel veri tabanı sınıfı nesnesine ulaşmak için 
YerelVeriTabani yerelVeriTabani=YerelVeriTabani(); ekliyoruz 
31=> KitaplarSayfasi() nda _kitapEkle() fonksiyonu içinde çağırdığımız createKİtap(Kitap kitap) fonksiyonuna showdialogdan gelen kitap Adi ile bir kitap nesnesi oluşturup bunu  gönderiyoruz
32=> 






