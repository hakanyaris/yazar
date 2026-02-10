class Kitap {
  int? id;
  String isim;
  DateTime olusturulmaTarihi;
  Kitap(this.isim, this.olusturulmaTarihi);

  //maptan verileri çeker
  Kitap.fromMap(Map<String, dynamic> map)
    : id = map['id'],
      isim = map["isim"],
      olusturulmaTarihi = DateTime.fromMillisecondsSinceEpoch(
        map["olusturulmaTarihi"],
      );

  /////////////////// //toMap yani mapaDonustur.
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "isim": isim,
      'olusturulmaTarihi': olusturulmaTarihi.millisecondsSinceEpoch,
    };
  }
}
