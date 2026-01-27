class Kitap {
  int? id;
  String isim;
  DateTime olusturulmaTarihi;
  Kitap(this.isim, this.olusturulmaTarihi);
  /////////////////// //toMap yani mapaDonustur.
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "isim": isim,
      'olusturulmaTarihi': olusturulmaTarihi.millisecond,
    };
  }
}
