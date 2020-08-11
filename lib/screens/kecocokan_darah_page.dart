import 'package:donoradmin/utils/constants.dart';
import 'package:flutter/material.dart';

import '../widgets/gol_a_min_widget.dart';
import '../widgets/gol_a_plus_widget.dart';
import '../widgets/gol_ab_min_widget.dart';
import '../widgets/gol_ab_plus_widget.dart';
import '../widgets/gol_b_min_widget.dart';
import '../widgets/gol_b_plus_widget.dart';
import '../widgets/gol_o_min_widget.dart';
import '../widgets/gol_o_plus_widget.dart';

class KecocokanDarahPage extends StatefulWidget {
  @override
  _KecocokanDarahPageState createState() => _KecocokanDarahPageState();
}

class _KecocokanDarahPageState extends State<KecocokanDarahPage> {
  String golDarah;

  List<DropdownMenuItem<String>> golDarahItems = [
    new DropdownMenuItem(
      child: Text("A-"),
      value: "A-",
    ),
    new DropdownMenuItem(
      child: Text("A+"),
      value: "A+",
    ),
    new DropdownMenuItem(
      child: Text("AB-"),
      value: "AB-",
    ),
    new DropdownMenuItem(
      child: Text("AB+"),
      value: "AB+",
    ),
    new DropdownMenuItem(
      child: Text("B-"),
      value: "B-",
    ),
    new DropdownMenuItem(
      child: Text("B+"),
      value: "B+",
    ),
    new DropdownMenuItem(
      child: Text("O-"),
      value: "O-",
    ),
    new DropdownMenuItem(
      child: Text("O+"),
      value: "O+",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Kecocokan Darah',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Text(
                'Apa jenis darah anda ?',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              ListTile(
                leading: Image.asset(
                  'assets/images/blood.png',
                  width: 30,
                  height: 30,
                ),
                title: DropdownButton(
                  items: golDarahItems,
                  hint: Text("Golongan Darah"),
                  value: golDarah,
                  onChanged: (val) {
                    setState(() {
                      golDarah = val;
                    });
                  },
                ),
              ),
              RaisedButton(
                color: Colors.redAccent,
                child: SizedBox(
                  width: 100,
                  height: 50,
                  child: Center(
                      child: Text(
                    'Cari',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
                ),
                onPressed: () {
                  if (golDarah == 'A-') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => GolDarahAmin()),
                    );
                  } else if (golDarah == 'A+') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => GolDarahAPlus()),
                    );
                  } else if (golDarah == 'AB-') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => GolDarahABmin()),
                    );
                  } else if (golDarah == 'AB+') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => GolDarahABPlus()),
                    );
                  } else if (golDarah == 'O-') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => GolDarahOmin()),
                    );
                  } else if (golDarah == 'O+') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => GolDarahOPlus()),
                    );
                  } else if (golDarah == 'B-') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => GolDarahBmin()),
                    );
                  } else if (golDarah == 'B+') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => GolDarahBplus()),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
