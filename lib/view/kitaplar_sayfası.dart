import 'package:flutter/material.dart';

class KitaplarSayfasi extends StatefulWidget {
  @override
  State<KitaplarSayfasi> createState() => _KitaplarSayfasiState();
}

class _KitaplarSayfasiState extends State<KitaplarSayfasi> {
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

  _kitapEkle(BuildContext context) {
    _pencereAc(context);
  }

  Future<String?> _pencereAc(BuildContext context) {
   return showDialog<String>(
      context: context,
      builder: (context) {
        String? sonuc;
        return AlertDialog(
          title: Text('Kitap Adını Giriniz'),
          content: TextField(),
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
