import 'package:flutter/material.dart';

import '../models/user_model.dart';

class InformasiCard extends StatelessWidget {
  final UserModel user;

  const InformasiCard({Key key, @required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        child: Container(
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user.image),
              backgroundColor: Colors.black12,
            ),
            title: Text(
              user.username,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            subtitle: user.role == "Pasien"
                ? Text(
                    "Membutuhkan golongan darah ${user.golonganDarah} sebanyak ${user.membutuhkanDarah} kantong")
                : Text(
                    "Mendonorkan golongan darah ${user.golonganDarah} sebanyak ${user.membutuhkanDarah} kantong"),
          ),
        ),
      ),
    );
  }
}
