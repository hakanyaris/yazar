class YerelVeriTabani{
  YerelVeriTabani._privateConstructur();
   
  static final YerelVeriTabani _nesne =YerelVeriTabani._privateConstructur();

// factory constructur bir nesne ürettiği nesneyi düzenleyip geri döndürür.
// Bir YerelVeriTabani nesnesi mainde oluşturulduğunda ilk aşağdaki  factory YerelVeriTabani  constructur çağrılır.
//o da geriye _nesne döndürü ,önceden bir nesne oluşturulmadıysa YerelVeriTabani._privateConstructur(); nesnesi oluşturulur 
//ve geriye döndürülür.Fakat ikinci çağrılmada _nesne önecden oluturulduğu için ve final olduğu için önceki (ilk)nesne verilir ve değiştirilemez
  factory YerelVeriTabani(){
    return _nesne;
  }


}


/* CREATE TABLE "kitaplar" (
	"id"	INTEGER NOT NULL UNIQUE PRIMARY KEY AUTOINCREMENT,
	"isim"	TEXT NOT NULL,
	"yazar"	TEXT,
	"sayfaSayisi"	INTEGER,
	"ilkBasimYili"	INTEGER
);
*/