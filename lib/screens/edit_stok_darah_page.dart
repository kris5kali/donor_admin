import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donoradmin/models/stok_darah_model.dart';
import 'package:donoradmin/utils/constants.dart';
import 'package:flutter/material.dart';

class UbahStokDarah extends StatefulWidget {
  final StokDarahModel stok;

  UbahStokDarah({this.stok});

  @override
  _UbahStokDarahState createState() => _UbahStokDarahState();
}

class _UbahStokDarahState extends State<UbahStokDarah> {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final darahController =
        TextEditingController(text: widget.stok.golonganDarah);
    final stokController = TextEditingController(text: widget.stok.stok);
    return Scaffold(
      appBar: AppBar(

        backgroundColor: kPrimaryColor,
        title: Text("Edit Stok Darah"),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(hintText: "Darah"),
                  controller: darahController,
                  enabled: false,
                  validator: (val) => val.isEmpty ? "isi oi" : null,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Darah"),
                  controller: stokController,
                  validator: (val) => val.isEmpty ? "isi oi" : null,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          final collRef = Firestore.instance.collection("stokdarah");
          DocumentReference documentReference = collRef.document();
          Firestore.instance
              .collection("stokdarah")
              .document(widget.stok.id)
              .setData({
            "golonganDarah": darahController.text,
            "stok": stokController.text,
          }).then((val) {
            Navigator.pop(context);
          });
        },
      ),
    );
  }
}
