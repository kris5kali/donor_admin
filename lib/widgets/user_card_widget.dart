import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../models/user_model.dart';
import '../utils/constants.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
      height: 180.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 3.0,
            spreadRadius: 2.0,
          )
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: user.role == "Pasien"
                ? Container(
                    height: 24.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                    ),
                    child: Center(
                      child: Text(
                        "Urgent",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : Container(),
          ),
          Positioned(
            top: 12,
            bottom: 12,
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(16.0),
                image: DecorationImage(
                  image: NetworkImage(user.image ??
                      'https://i.pinimg.com/564x/7c/1c/a4/7c1ca448be31c489fb66214ea3ae6deb.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 24,
            left: 124,
            bottom: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(user.username ?? 'Data Kosong', style: kHeadline3),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Icon(user.jenisKelamin == 'Laki-laki' ? FlutterIcons.md_male_ion: FlutterIcons.md_female_ion),
                    SizedBox(width: 10),
                    Text(user.jenisKelamin ?? 'Data Kosong',
                        style: kDescription),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      color: Colors.black,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(user.noHp ?? 'Data Kosong', style: kDescription),
                    // )
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Colors.black,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: MediaQuery.of(context).size.width - 200,
                      child: Text(user.alamat ?? 'Data Kosong',
                          overflow: TextOverflow.ellipsis, style: kDescription),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
