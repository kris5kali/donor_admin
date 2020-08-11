
import 'package:donoradmin/utils/constants.dart';
import 'package:flutter/material.dart';

class GolDarahABmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Golongan Darah AB-'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50),
            Text(
              'Anda dapat menerima dari',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 8,
              child: Container(
                width: 150,
                height: 50,
                alignment: Alignment.center,
                // margin: EdgeInsets.only(left: 17, right: 17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Golongan AB-',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}