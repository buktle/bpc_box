import 'package:flutter/material.dart';

class _buildTypeBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 5, 25, 15),
      child: Text(
        'ประเภทกล่อง : RSC',
        style: TextStyle(fontSize: 20, color: Colors.blue),
      ),
    );
  }
}
