import 'package:flutter/material.dart';
import 'package:yazar/model/kitap.dart';
import 'package:yazar/yerel_veri_tabani.dart';

class KitaplarSayfasi extends StatelessWidget {
  YerelVeriTabani _yerelVeriTabani = YerelVeriTabani();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),

      floatingActionButton: _buildKitapEkleFab(context),
    );
  }

  //---------------------------------------------------------------------------
  AppBar appBar() {
    return AppBar(title: Text('KİTAPLAR SAYFASI'));
  }

  Widget _buildKitapEkleFab(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        _kitapEkle(context);
      },
    );
  }

  void _kitapEkle(BuildContext context) async {
    String? kitapAdi = await _pencereAc(context);
    if (kitapAdi != null) {
      Kitap yeniKitap = Kitap(kitapAdi, DateTime.now());
      int? kitapIdsi = await _yerelVeriTabani.createKitap(yeniKitap);
      print("Kitap id si : $kitapIdsi");
    }
  }

  Future<String?> _pencereAc(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        String? sonuc;
        return AlertDialog(
          title: Text('Kitap Adını Giriniz'),
          content: TextField(
            onChanged: (value) {
              sonuc = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, sonuc);
              },
              child: Text('Onayla'),
            ),
          ],
        );
      },
    );
  }
}
