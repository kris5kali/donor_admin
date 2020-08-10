import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donoradmin/models/acara_donor_page.dart';
import 'package:flutter/material.dart';

class EditAcaraDonor extends StatefulWidget {
 final AcaraDonorModel acara;
  EditAcaraDonor({this.acara});

  @override
  _EditAcaraDonorState createState() => _EditAcaraDonorState();
}

class _EditAcaraDonorState extends State<EditAcaraDonor> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final tanggalController = TextEditingController(text: widget.acara.tanggal);
    final isiController = TextEditingController(text: widget.acara.isi);
    return Scaffold(
      appBar: AppBar(
        title: Text("Ubah Acara Donor"),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Tanggal Acara",
                  ),
                  controller: tanggalController,
                  validator: (val) => val.isEmpty ? "isi dulu" : null,
                ),
                TextFormField(
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: "Isi Acara",
                  ),
                  controller: isiController,
                  validator: (val) => val.isEmpty ? "isi dulu" : null,
                  autocorrect: true,
                ),
                RaisedButton(
                  child: Text("Ubah Acara"),
                  onPressed: () {
                    Firestore.instance
                        .collection('acaradonor')
                        .document(widget.acara.id)
                        .updateData({
                      "tanggal": tanggalController.text,
                      "isi": isiController.text,
                    }).then((onValue) {
                      Navigator.pop(context);
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
