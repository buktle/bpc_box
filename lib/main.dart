// import 'package:bpc_box/screens/home_page.dart';
import 'package:bpc_box/screens/sizebox_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BPC BOX',
      home: Scaffold(
        appBar: AppBar(
          title: Text('BPC  คำนวณกล่องกระดาษ'),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          margin: EdgeInsets.all(8),
          color: Colors.grey[100],
          child: SizeBoxPage(),

        ),
      ),
    );
  }
}
