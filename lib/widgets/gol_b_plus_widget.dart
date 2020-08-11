import 'package:donoradmin/utils/constants.dart';
import 'package:flutter/material.dart';

class GolDarahBplus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: kPrimaryColor,
        title: Text('Golongan Darah B+'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Golongan AB+',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Golongan B+',
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