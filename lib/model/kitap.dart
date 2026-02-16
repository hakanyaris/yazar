class Kitap {
  int? id;
  String isim;
  DateTime olusturulmaTarihi;
  int kategori;
  Kitap(this.isim, this.olusturulmaTarihi, this.kategori);

  //maptan verileri çeker
  Kitap.fromMap(Map<String, dynamic> map)
    : id = map['id'],
      isim = map["isim"],
      kategori = map["kategori"] ?? 0,
      olusturulmaTarihi = DateTime.fromMillisecondsSinceEpoch(
        map["olusturulmaTarihi"],
      );

  /////////////////// //toMap yani mapaDonustur.
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "isim": isim,
      "olusturulmaTarihi": olusturulmaTarihi.millisecondsSinceEpoch,
      "kategori": kategori,
    };
  }
}
