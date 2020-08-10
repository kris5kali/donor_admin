import 'package:flutter/material.dart';

class GolDarahOPlus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Golongan Darah O+'),
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
                height: 70,
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
                      'Golongan A+',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Golongan O+',
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