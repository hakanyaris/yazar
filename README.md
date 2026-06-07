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
------- kitapEkle flotainActionButton
5=> KiapEkle fonksiyonunun içinde de _pencereAc() fonksinyonu tanımladık.
6=> pencereAc Fonsiyonn içine ShowDialog  onun da içine AlertDialog fonk. koyuyoruz Alert dilaloga kitap eklemek için bir TextField()  ,iki tane buton koyuyoruz(TextButton) koyuyoruz iptal ve kaydet 
7=> Texfiel yazılan değeri _pecereAc içinde  String sonuc  değerine eşitlerdik sonuc değerini  return showDilog<String> diyerek  ve  Future<String>?>  _pencereAc  diyerek fonsiyoru geriye String döndürür şekilde ayarladık.
8=> Kitap Sınıfı oluşturuyoruz Model klasörü açıp içine Kitap sınıfı oluşturuyoruz. int? id,Sring isim ,DateTime olusturulmaTarihi ve kurucu metot;(id null olabilir yaptık çünkü id kullanıcdan almıyoruz(kurucu mettotta) veritabanı otomatik atıyor)
9=>_kitapEkle() FONKSİYONUN içine  yeni birkitap nesenesi oluştrup _pencereAc dan gelen sonuc (kitap adı) değerini kitap adı olarak veriyoruz.işlem bitince boş bir setState(){} oluşturuyoruz ki yeni eklenen kitap ekranda gösterilsin
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
"id" yerine String  _idKitaplar="id" şeklinde YerelVeriTabani içinde tanımlayıp  sql kodlarında "id" yerine  _idKitaplar kullanıyoruz.
28=> tabloadı id ,isim ,olusturulmaTarihi gibi verilerin adlarını silip   _veriTabaniGetir fonksiyorun içinde String  olarak tutuyoruz. String _kitaplarTabloAdi="Kitaplar; Stirng _kiplarId ="id"; gibi
------------ Kitaplar CRUD Create (Create,Read,Upgrade,Delete)
29=> Tabloya kitap eklemek için Create fonksiyonu oluşturuyoruz. Future<int> createKİtap(Kitap kitap) 
burada db.insert(tabloADI, Map<String,dynamic>) kitap verilerini map a çevirmek için  Kitap sınıfı içinde 
Map<String,object> toMap  fonsiyonu yazıyoruz  kitap.toMap fonksiyona ekliyoruz .insert fonksiyonu geriye eklenen verinin id döndürüyor.
------------createKİtap Fonksiyonunu _kitapEkle()fonksiyounda çağırmak
30=>  KitaplarSayfasi() gidip  Yerel veri tabanı sınıfı nesnesine ulaşmak için 
YerelVeriTabani yerelVeriTabani=YerelVeriTabani(); ekliyoruz 
31=> KitaplarSayfasi() nda _kitapEkle() fonksiyonu içinde çağırdığımız createKİtap(Kitap kitap) fonksiyonuna showdialogdan gelen kitap Adi ile bir kitap nesnesi oluşturup bunu  gönderiyoruz
------------Read
32=> Veritabanına eklenen kitapları listelemek için Future<List<Kitap>> _readTumKitaplar() fonksiyounun  oluşturuyotuz.db.query fonksiyonunu kullanıyoruz bu map türünde bir liste döndürür.
List<Map<String,dynamic>>> kitaplarMap= await db.query(tabloadi)
33=> Geriye map tipinde bir liste döndüğü için bu map listesini Kitap modeline çeviren Kitap sınıfı içinde 
 isimlendirilmiş kurucu metot:
 Kitap.fromMap(Map<String,dynamic> map){.......} oluşturuyoruz. sonra readTumKitaplar() metotu içinde for döngüsü ile map içindeki tüm kitapları gezip tek tek kitap nesnesine dönüştürüp bir kitap listesi içine koyup listeyi return ile geri döndürüyoruz.

 34=> KitaplarSayfasi() nda Future<void> tumKitaplariGetir()async{} fonksiyonu ile tüm kitapları veritabanından çeken bir fonk. oluşturuyoruz ve içinde readTumKitaplar() fonk. kullanıyoruz . KitaplarSayfasi() içinde  bir Kitap listesi olşturuyoruz.  gelen kitap listesini bu listeye atıyoruz.
 ---------_buildBody()
 35=> Listelenen kitapları ekranda göstermek için _buildBody oluşturuyoruz.
  Liste gelene kadar initState kullanmak yerine FutureBuilder(future: , builder:) kullanıyoruz. futureye atadığımız fonk(verileri çekme işlemi tumKitaplarıGetir()) bitince buildere atadığmız (ekranı çizme ) fonk. çalışır.ListView.builder kullanacağız ve ekranı çizdireceğiz.
-----------update
35=> Kitapları güncellemek için  Future<int> updateKitap(Kitap kitap){} oluşturuyoruz içinde db.update(tablo adı,Map<String, Object?> values)  kullanıyoruz. Güncellenecek kitabı alır geriye güncellenen sütun kadar int değeri döndürür.güncelleme olmazsa geriye 0 değeri biz döndürürüz. 
36=>db.update(tablo adı,kitap.toMap, where "_idKitaplar = ?",whereArgs:[kitap.id]) burada where yani kitap tablosunun id sütunu;  ? ise bir bilinmeyen değere eşitle, whereArgs ise bilimeyen değere karşılık gelen sütunu seçiyoruz liste alır birden fazla soru işareti olursa birden fazla değer alır.(wheere kullanmazsak bütün kitaplar güncellenir.)
37=> listedeki elemanları güncelleme yapmak için listView.builder içinde  List.tile içine iconButton koyuyoruz.onPresed  içine void _kitapGUncelleme(context,index) fonk tanımlıyoruz.index o anki kitap id listView.builder den alıyoruz context ise mevcut _pencereAc(BuildContext context) fonk. içindeki showDialog için alıyoruz.
38=> _kitapGUncelleme(context,index) fonk içinde yeni bir Kitap nesnesi oluşturup onu indeks ile listview.builderden dönen kitapa eşitliyoruz. 
39=> _pencereAc fonk dönen yeni kitap adını Kitap nesnesinin adına eşitliyoruz
40=> bu kitabı Future<int> updateKitap(Kitap kitap) fonsiyonuna gönderiyoruz. fonk. dönüş degeri int 0 büyükse setState çalıştır fonk. yazıyoruz. ekranı yeniden çizdiriyoruz
-------------------Delete
41=> Future<int> deleteKitap(Kitap kitap){} fonk. oluşturuyOruz geriye silinen satır sayısını döndürecek . db.delete(tablo adı, where "_idKitaplar = ?",whereArgs:[kitap.id])  içine tanımlıyoruz. where de id si where args da verilen kitabı sil . db boşsa o döndür.(where kullanmazsak bütün kitaplar silinir.)
42=> listTile içinde Bir iconButton daha oluşturuyoruz. Butona tıklanınca void _kisapSil(int index) fonk koyuyoruz(onpress içine) Bir kitap nesnesi oluşturup index ile gelen kitaba eşitliyoruz.
43=> _Future<int> deleteKitap(Kitap kitap) fonk çağırıp kitap nesnesini buraya gönderiyoruz
44=> Future<int> deleteKitap(Kitap kitap) dönüş değeri 0 büyükse setState çalıştırıp ekranı yeniden çizdiriyoruz.
----------BölümModel Sınıfı(ilişkili tablolar)
45=> Kitaplara ait bölüm atayacağız bunu için faklı aynı sql dosyası içinde bölüm adında bir tablo olşturacağız ve bu tabloları ilişkili hale getireceğiz.
46=> Bolum clası oluşturuyoruz.önki nokta burada bir kitapId kullancağız çünkü her bölümün bir kitabı vardır.
47=> int? id , int kitapId, String baslik ,String icerik 
48=>kurucu metotta kitapId ve baslık alacağız içerik ise boş string atayacağız bolum ilk oluşturulunca içeriği boş isyitoru sonradan içerikDetay sayfasi ile dolduracağız.
49=>  toMap  fonk .ve fromMap kurucu metodu oluşturuyoruz.
--------------Bölüm sınıfı için  sqlite tablo kodu oluşturma
50=> Yine bu sınıfla ilgili tablo kodu almak için bu projemizi emilatörde çalıştırıyoruz.Android stüdyoda bu emülotora ait dosyalara data içinden ulaşıp yazar.db  masaüstüne indirip  program ile çalıştırıyoruz.
51=> Üst menüde Database Structure menüsüne basıp tablo oluştur kısmını tıklıyoruz.
52=> tablo adını bolumler yazıp ekle tıklayıp id  İNT ,kitapId İNT ,baslik TEXT , icerik TEXT ,olusturulmaTarihi TEXT  EKLİYORUZ.
53=>  id içi NN(NOT NULL) , Biricil anahtar(Primary key) ,Otomatik Arttırma(Auto Implement),Benzersiz(Unique)
54=> kitapId NN(NOT NULL), baslik NN(NOT NULL), icerik , 
55=> olusturulma tarihi VARSAYILAN(DEFAULT) kısmına CURRENT_TIMESTAMP yazıyoruz. Bolum sınıfmızda oluşturulma tarihi adından bir değerimiz yok bunu direkt database kendisi otomatik olarak kendi içinde otomatik değer atasın
56=> Tabloları bağlama  kitaplar tablomuz ile bölüm tablomuzu bağlayacağız.
      Yabancı Anahtar(Foreign Key) kitapId satırı kısmını çift tıklıyoruz tablolarda kitapalar tablosu seç
      ikinci seçim alanında id ceçiyorum 
      ( yani kitapId yi kitaplar tablosundaki id ile bağla)
      yanadaki boş satıra ON UPDATE CASCATE ON DELETE CASCATE    yazıyoruz
      (On update cascade mesela kitaplar tablosundaki ekli bir kitabın id 1 iken 15 oldu bölümler tablosundaki 1 kitaba bağlı bölümler de 15 kitaba bağlı olarak güncelle bunu yapmasak bölümler id 1 kalacak  )(on delete cascade ise kitap silinirse o kitaba ait bölümleri de sil)
      aşağıda oluşan kodu kopyalıyoruz
      OK basıp tabloyu oluşturuyoruz
57=> 27 adımdaki gibi  String _idBölümTabloAdi="bolumler"; String  _iBbolumler="id"; baslik icerik olusturulmaTarihi  hepsini Stringte tutuyoruz
58=> 57 adımdaki kopyaladığımız kodları yapıştırıp  değişkenleri 57 adımdaki stringlerle değiştiriyoruz.
------------Bölümler CRUD Create (Create,Read,Upgrade,Delete)  _yerelVereTabani()
59=> kitaplara ait  _yerelVereTabani() tüm create , read ,upgrade, delete fonksiyoları kopyalayıp kitap yazan yerlei bolum diyedeğişitip düzenliyoruz.
60=> bölümleri veritabanında okuyup çekerken kitap  read fonk farklı olarak tüm bölümlere ait bölümleri değil seçilen kitaba ait bölümleri göstermesi için Future<List<Bolum>> readTumBolumler(int kitapId) bir kitap id  istiyoruz.
61=> db.query( tabloadi, where:"$_kiyapIdBolumler= *" whereArgs: [kitapId])  where  ve whereArgs ekleyerek filitreleme yapıp kitapId  ye göre bölmleri çekiyoruz.
-------------Bölümler Sayfası VİEW
62=> view sayfası altında bolumler_Sayfasi.dart açıyoruz Stateful Widget
63=> bu sayfanın kurucu metotunda tıklanan kitap alacağız yani  final Kitap _kitap nesnesi oluşturup bunu kurucu metotta this._kitap ile alıyoruz.
64=> listTile içideki kitabı tıklayınca bölümler açılacağından listTile içine onTap(){_bolumlerSayfasiAc(context ,index)} açıyoruz 
65=>  KitaplarSayfasi içinde void _bolumlerSayfasiAc(BuildContext context, in index){}  metodu ile bolum sayfasında yönlendiriyoruz(MaterialPageRoute  ve Navigator.push).  Bu sayfada BolumlerSayfasi(this.kitap) kitap nesnesi göndermek için index değerini aldık
parantez içide (_kitaplar[index]) kitaplar listesinde  index değerindeki kitabı gönderiyoruz.
65=> kitapSayfasini komple bölüm sayfasında yapıştırıyoruz kitap yazan yerlere bölüm yazıyoruz.
66=> _bolumlerSayfasiniAc() ı _bolumDetaySayfasiniAc() olarak değiştirip bölüm tıklanınca Bölüme ait içerik görüncek bu sayfayı oluşturacağız.
-------------Bolümler tablosu 
   Veri tabanı ilk kez oluşturulduğunda (onCreate) kitap tablosu oluşturulmuştu .Fakat bolümler tablosunu yerel veritabanında oluşturlmamıştı.bolumler tablosunu sonradan veritabanına eklemek için onUpgrade: kısmında ve version: kısmında işlem yapacağız  (.........)
67=>şimdilik cep telefonundan data kısmındaki yazar.db siliyoruz veri tabanı silindiği için sıfırdan yeni bir veritabanı oluşturacak ve veritabanı bolumler tablosunu da oluşturacak
-------------Bölüm Detay sayfası view
    bir kitaba girdikten sonra o kitaba ait bölümler listelendi.Burada herhangi bir bölüme tıkladığımızda  kitabın bölümüne ait yazdığımız içerik görünecek .
68=> view klasörü altında bolum_detay_sayfasi.dart oluşturuyoruz.BolumDetaySayfa()
69=> BolumDetaySayfasi() kurucu metotunda bir tane final Bölüm _bolum; ile this.bolum isteyeceğiz.Hangi bölümün detayını gösterecektek onu alacağız
70=> appbara _bolum.baslik , appbarda bir Iconbuton olacak bolum içeriği kaydetmek için,onpress içinde _icerigiKaydet async() fonk tanımlıyoruz.
71=> body içinde bir textField olacak texfield decoration kısmını düzenliyoruz border deriyoruz. maxLines:1000 ile tam sayfayı kaplamasını sağlıyoruz.
72=> 66 adımdaki_bolumDetaySayfasiniAc() sayfasını düzenleyip listTile tıklanınca bu sayfaya gitmesi için materialPageRoute ile ayarlıyoruz.
73=>  70 adımdaki _icerigiKaydet async () yani buton tıklanınca Bölüm içindeki içerik güncelleneip texfieldde yazdığımız yazılar kaydolacak 
74=> TextEditingController() ile YerelVeriTabani clasını burada oluşturuyoruz.bölüme ait önceli içerik texfield de görünmesi için _icerikControler.text = _bolum.icerik şek. düzenliyoruz 
75=> _bolum.icerik = _icerikController.text;  contoller ile gelen içeriği bolüm nesnesinin icerik kısmına veriyoruz
76=> _yerelVeriTabani.updatebolum(_bolum); yeni güncel bölümü veri tabanında güncellemek için
--------------------Kategori ekleme(Kitaplara) 
Her Kitaba bir kategori ekleyeceğiz Kategori sınıf oluşturmuyoruz bu yüzden kategori tablosunada gerek yok Kitap clası içine kategori diye bir  değişken ekleyeceğiz.

77 => kategori bilgilerini tutan bir sabitler sınıfı oluşturuyoruz. lib altında sabitler.dart clası oluşturduk
78 => satatic const Map<int,String> kategoriler={0:"Genel,1:"Roman....} kategorileri dışarıdan kolayca erişebileceğimiz map listesi oluşturyoruz.
NOT: NEDEN LİSTE DEĞİLDE MAP OLUŞTURUYORUZ?ÇÜNKÜ ileride veritabanında tutlacak değer "genel" değil int 0 rakamı olacak.İleride "genel" i "tümü" diye değiştirisek yapmamız gereken sadece sabitler clası içinde düzeltmek vertabanında tüm kitaplara gidip tek tek kategorileri değişmemize gerek kalmayacak.

78=> Kitap sınıfına gidip int kategori; adında bir alan ekliyoruz. kurucu metotta kategoriyi alıyoruz. toMap ve fromMap a da kategori eklioyuz.
79=> kurucu metotu değiştirdiğimiz için kitap nesnesinin çağrıldığı yerler hata veriyor. kitaplar_sayfasi.dart kategori bilgisini almak için kitap eklenirken  dropdown ile kategori bilgisine de  alacağız 
80=>  _kitaplar_sayfasi.dart içide _pencereAc fonk gidip Texfield i column ile sarmalyıp DropDown koyuyoruz.
81=>  DropDown  menü de yapılan değişikliklerin ekrana yansıması için setState ekliyoruz fakat bu yeterli değil çünkü biz  DropDown ı ShowDialog ile yeni bir açılır menü açtığımız için oraya etki etmiyor.
 Show dialog aslında yeni bir sayfa açıyor ve ayrı bir setStatesi olması gerekiyor.
 Bunun için StatefulBuilder()  widgeti kullanıyoruz geriye widget döndürür .
82=> ShowDialog artık hem kitapadı hem de kategori bilgisi döndürecek .Yani bir liste döndürecek.Bunu düzenlemek için 7. adımda tanımladığımız _pencereAc fonk ve  içindeki ShowDialog  String değil Liste olacak
  return showDilog<List<dynamic>> diyerek  ve  Future<List<dynamic>>?>  _pencereAc  diyerek fonsiyoru geriye List<dynamic> döndürür şekilde ayarladık.

83=> 9. adımda _pencereAc fonk. içine alam kitapEkle() fonk.  _kitapGuncelle()  fonk. düzenliyoruz.
84=> kitapGuncelle fonk bir değişiklik yapacağız. KitapGüncelle butonuna basınca mevcut kitabın adı ve kategorisi ShowDialogda görünmüyordu .Bunu için pencereAc fonk güncelliyoruz ;
 Future<List<dynamic>?>  _pencereAc(
    BuildContext context, {
    String mevcutIsim = "",
    int mevcutKategori = 0,
  })

  yani isteğe bağlı olarak iki değer alıyoruz .

85=> ve textField e isimController oluşturup  ;
 TextEditingController isimController = TextEditingController( text: mevcutIsim, ); geriye sonuc değil 
 isimController.text.trim(); döndürüyoruz

86=> _kitapGuncelle() fonk içindeki _pencereAc fonk düzenliyoruz. _kitapGuncelle() içindeki Kitap.isim ve 
kitap.kategori değerlerini _pencereAc  gönderiyoruz.

87=> KitapGuncelle ile açılan pencerede bilgilde bir değişiklik olmadan onayla butonuna basarsak yine veritabanına gidip gereksiz yere aynı bilgiler yeniden işlencek bunu önlemek için isim veya kategori değişmemişse veritabanına gidilmesin KitapGuncelle içinde mevcut kitap adı ve kategori adı aynıysa  veritabanı güncelleme işlemeri başlamasın if() yazıyoruz.(PERFORMANS DÜZENLEMESİ)
-----------------Kategori satırını  _yerel_veri_tabani.dart (sqlite) ekleme 
     YerelVeriTabanı clasına gidip kategori satırını kitap tablosuna eklemek için düzenlemeler yapacağız
88=> oncreate parametresine atanan  _tabloOlustur fonk içine "kategori" INTEGER DEFAULT 0 ekliyoruz. 
 oncreate kısmı  tablo ilk oluşturulurken çalıştırıldığı için satır veritabanına eklenmeyecektir.
 bu yüzden onUpgrade parametresini kullanmalıyız

89=> onUpgrade: parametresine _tabloGuncelle(Database db ,int oldVersion, int newVersion) fonk. atıyoruz. 
db bizim veritabanı dosyamızi oldVersion veritabanımızdaki version numarası, newVersion şimdi atadığımız version numarası.fonksiyonun içine sql komutu ile kategori satırı eklemek için

90=>await db.execute("ALTER TABLE "Kitaplar" ADD COLUMN "kategori" INTEGER DEFAULT 0" ); DEFAULT 0 Vermemizin nedeni önceden veritabanına eklenen kitaplarda kategori sutunu null olarak çalışırsa program hata verecek bu yüzden önceki kitaplar kategori 1 olacak yani "genel" olacak

bunu eklesek bile tablo yine veritabanına eklenmeyecek çünkü version:1 hala 1  biz burada 2 yapmalıyız ki onUpgrade  tetiklenip çalışsın
Yani onUpgrade çalışması için cihazın veri tabanı ile bizim simdi girdiğimiz version farklı olması gerekiyor aynı olursa çalışmaz.
-----------------------onUpgrade Tabloya kategori dışında başka bir değişken daha eklemek 
91=>YerelVeriTabanı içinde _tabloGuncelle fonk önceden katergori satırı ekleyen bir sql komutu(88 adım )yazmıştık.
Eğer ikinci bir satır(mesele renk) eklemek istersek _tabloGuncelle içine ikinci bir db.execute ile  satır ekleme komutu yazacağız. ama opUpgrade çalışınca _tabloGuncelle de çalışlacak ve kategori satırını tekrar eklemeye çalışacak ve program hata verecek. 
Bunu önlemek için eklenecek her bir sql komutunu bir string listesine kaydedip for döngüsü içinde bir kod yazıyoruz _tabloGuncelle() içinde .

--------------------Ana ekranda kitapları listelerken Kategoriye göre listeleyeceğiz (Filtre where) 
   KitaplarSayfasında () view 
92=> _buildKategoriFiltresi()  fonk. oluşturup ana sayfada en üstte göstermek için _buildListView içinde column ile sarmalayıp içine  dropDown koyuyuoruz(_perncereAc içindeki Dropdown ).ListViewe.builderi expanded ile sarmalıyoruz.
93=> dropDown value değerini tutan int _secilenDegeri=0;  kitaplarSayfasında oluşturuyoruz.
94=> Listede Hepsi değeri yok bu yüzden  List<int> _tumKategoriler = [-1];  listesi oluşturup initState içinde 
_tumKategoriler.addAll(Sabitler.kategoriler.keys);  _1 değerininde olduğu yeni bir liste verir.

95=>_buildKategoriFiltresi() fonk  içindeki listeyi _tumKategoriler den çekiyoruz DropDownMenuItem in  child kısmına  Text () içinde kategoriId ==-1 ise "Hepsi" değilse Sabitler.kategoriler[kategoriId] ?? "" olacak

------------------Kategoriye göre listeleme veritabanı kodu düzenleme 
 yerel_veri_tabani.dart => readTumKitaplar
96=> 33. adımdaki Future<List<Kitap>> _readTumKitaplar(int kategoriId)  fonk int kategoriId isteyeceğiz.KategoriId göre listeleyecepğiz

97=> db.duery e where :"kategoriId = ?" whereArgs:[kategoriId] ekleyerek  AnaSayfadaki listelemeyi bu şekilde filtreliyoruz.

98=> Hepsi seçeneğeni tıklanınca _secilenKategori=_1 olacağından  veritabanında kategorisi  -1 olan hiçbir kitap yok bu yüzden ekranda hiçbir kitap gösterilmeyecek.
  Bunu düzeltmek için _secilenKategori=_1 olunca where :"kategoriId = ?" whereArgs:[kategoriId]  filtreleri hiç yapılmasın filtre olmayınca tüm liste geri dönecek zaten.

99=>(readTumKitaplar fonk .) String? filterWhere ve List<int>? filtreArgs; iki değişken oluşturup bunları where ve whereArgs atıyoruz( where: filtreWhere, whereArgs: filtreArgs,)   kategoriId -1 büyükse  filterWhere filterWhere filtreleme çalışması içinayarlıyoruz.
 if (kategoriId !=-1) { filtreWhere = " $_kategoriKitaplar = ? "; filtreArgs = [kategoriId];}

-------------------Kategoriye ve id ye göre listeleme (Birden fazla koşula göre listeleme)

100=>Hem kategoriye göre hem de kitapId 2 den büyük kitaplar getirilsin 
   kategori filtresine ek olarak and ile ikinci filtreyi ekliyoruz
if (kategoriId !=-1) { filtreWhere = " $_kategoriKitaplar = ? and idKitaplar > ?";
                                 filtreArgs.add(kategoriId);   filtreArgs.add(2)}
                            
Not : and ve or kelimelerini kullanarak  listeleri filtreleyebiliriz  ve 2 ve daha fazla filtreyi yan yaba ekleyebiliriz.
------------------------ listedeki Kitapları toplu silme  
  Listedeki her bir kitabın yanına chackBox koyup işretli chacboxu bir listeye ekleyip sil butonun basınca listedeki kitaplar silinsin 
101=>  kitaplar_Sayfasi.dart   listTile içinde chackBox ekliyoruz .
102=>  kitaplar_Sayfasi.dart   void _seciliKitapSil fonk. ile  listedeki kitapları sileceğiz boş şimdilik
103=> yerel_veri_tabani.dart  da deleteKitap(Kitap kitap) fonk kopyalayıp deleteKitaplar(List <int> seciliKitapIdler) adını koyuyoruz. 








