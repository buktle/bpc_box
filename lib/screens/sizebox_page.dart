import 'package:bpc_box/data_box.dart';
import 'package:flutter/material.dart';
import 'package:bpc_box/function.dart';

class SizeBoxPage extends StatefulWidget {
  @override
  _SizeBoxPageState createState() => _SizeBoxPageState();
}

class _SizeBoxPageState extends State<SizeBoxPage> {
  final _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> listGrade = [];
  void loadData() {
    listGrade.add(DropdownMenuItem(
      child: null,
    ));
  }

  //my style
  double sizeBox = 2;
  double myTextNumber = 20;

  BoxProduct boxProduct = BoxProduct();
  ScrapRoll scrapRoll = ScrapRoll();
  String dropdownValue = 'One';
  String valueTest = '';

  //my Controller
  var textController = new TextEditingController(); //test
  var textControllerSheetWidth = new TextEditingController();
  var textControllerSheetLength = new TextEditingController();
  var textControllerTop = new TextEditingController();
  var textControllerBotton = new TextEditingController();
  var _currencies = ['ผ่า 1', 'ผ่า 2', 'ผ่า 3', 'ผ่า 4'];
  var _currentItemSelected = 'ผ่า 1';
  var _currenciesPw = [
    'หน้า 32',
    'หน้า 34',
    'หน้า 36',
    'หน้า 38',
    'หน้า 40',
    'หน้า 42',
    'หน้า 44',
    'หน้า 46',
    'หน้า 48',
    'หน้า 50',
    'หน้า 52',
    'หน้า 54',
    'หน้า 56',
    'หน้า 58',
    'หน้า 60',
    'หน้า 62',
  ];
  var _currentItemSelectedPw = 'หน้า 32';

  int txtShtW = 0;
  double pw1 = 0;
  double pw2 = 0;
  double pw3 = 0;
  double pw4 = 0;

  String txtPaperInch = '--';
  String txtScrap = '--';
  String txtDissect = '--';
  String strError = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            // Text('${dissectList['2'][0]}'),

            Container(
              padding: EdgeInsets.fromLTRB(25, 5, 25, 15),
              child: Text(
                'ประเภทกล่อง : RSC',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),

            //Lon Type
            Card(
              child: Container(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 15),
                child: _buildLonType(),
              ),
            ),
            SizedBox(height: sizeBox),

            //Size Box
            Card(
              child: Container(
                padding: EdgeInsets.fromLTRB(25, 5, 25, 25),
                child: _buildSizeBox(),
              ),
            ),
            SizedBox(height: sizeBox),

            //Sheet board
            Card(
              child: Container(
                padding: EdgeInsets.fromLTRB(25, 5, 25, 25),
                child: _buildSheetboard(),
              ),
            ),
            SizedBox(height: sizeBox),

            _buildSummitButton(),

            _buildError(),
            //Paper Grade
            Card(
              elevation: 5.0,
              color: Colors.amber[100],
              child: Container(
                padding: EdgeInsets.fromLTRB(25, 5, 25, 8),
                child: _buildPaperRollInch(),
                //TODD
              ),
            ),
            //SizedBox(height: sizeBox),

            Card(
              //แจกแจงหน้ากระดาษ
              color: Colors.grey[300],
              child: Container(
                padding: EdgeInsets.fromLTRB(25, 5, 25, 25),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    _gradeGram(),
                  ],
                ),
              ),
            ),
            SizedBox(height: sizeBox),
          ],
        ),
      ),
    );
  }

  //---------------- Widget -------------------
  InputDecoration _buildInputDecoration(
      {String label, String hint, IconData icon}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      icon: Icon(icon),
    );
  }

  Widget _buildSummitButton() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: RaisedButton(
        child: Text(
          'คำนวณหน้ากระดาษ',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        color: Colors.blue,
        onPressed: _submit,
      ),
    );
  }

  Widget _buildLonType() {
    final Color activeColor = Colors.blue;

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 1),
      child: Column(
        children: <Widget>[
          Text(
            'ชนิดลอน',
            style: TextStyle(fontSize: 18, color: Colors.blue),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio(
                activeColor: activeColor,
                value: 'B',
                groupValue: boxProduct.lonType,
                onChanged: _handleRadioValueChange,
              ),
              Text(
                'ลอน B',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                width: 2,
              ),
              Radio(
                activeColor: activeColor,
                value: 'C',
                groupValue: boxProduct.lonType,
                onChanged: _handleRadioValueChange,
              ),
              Text(
                'ลอน C',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                width: 2,
              ),
              Radio(
                activeColor: activeColor,
                value: 'BC',
                groupValue: boxProduct.lonType,
                onChanged: _handleRadioValueChange,
              ),
              Text(
                'ลอน BC',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSizeBox() {
    return Column(
      children: <Widget>[
        Text(
          'ขนาดกล่อง',
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),

        //test
        TextFormField(
          
          style: TextStyle(fontSize: myTextNumber),
          decoration: _buildInputDecoration(
              label: 'ความสูง', hint: '', icon: Icons.straighten),
          keyboardType: TextInputType.number,
          validator: _validateNumber,
          onChanged: (String value) {
            boxProduct.hightBox = int.parse(value);
            _setAll();
            // boxProduct.CoverBox();
            // boxProduct.SizeSheetboard();
            // _setCoverBox();
            // _setSizeSheetboard();
          },
        ),
        TextFormField(
          style: TextStyle(fontSize: myTextNumber),
          decoration: _buildInputDecoration(
              label: 'ความกว้าง', hint: '', icon: Icons.straighten),
          keyboardType: TextInputType.number,
          validator: _validateNumber,
          onChanged: (String value) {
            boxProduct.widthBox = int.parse(value);
            _setAll();
            // boxProduct.CoverBox();
            // boxProduct.SizeSheetboard();
            // _setCoverBox();
            // _setSizeSheetboard();
          },
        ),
        TextFormField(
          style: TextStyle(fontSize: myTextNumber),
          decoration: _buildInputDecoration(
              label: 'ความยาว', hint: '', icon: Icons.straighten),
          keyboardType: TextInputType.number,
          onChanged: (String value) {
            boxProduct.lengthBox = int.parse(value);
            _setAll();
          },
        ),
        TextFormField(
          style: TextStyle(fontSize: myTextNumber),
          controller: textControllerTop,
          decoration: _buildInputDecoration(
              label: 'ฝาบน', hint: '', icon: Icons.straighten),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          style: TextStyle(fontSize: myTextNumber),
          controller: textControllerBotton,
          decoration: _buildInputDecoration(
              label: 'ฝาล่าง', hint: '', icon: Icons.straighten),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildSheetboard() {
    return Column(
      children: <Widget>[
        Text(
          'ชีทบอร์ด',
          style: TextStyle(fontSize: 18, color: Colors.blue),
        ),
        TextFormField(
          style: TextStyle(fontSize: myTextNumber),
          controller: textControllerSheetWidth,
          decoration: _buildInputDecoration(
              label: 'ความกว้างชีทบอร์ด', hint: '', icon: Icons.straighten),
          keyboardType: TextInputType.number,
          validator: _validateNumber,
        ),
        TextFormField(
          style: TextStyle(fontSize: myTextNumber),
          controller: textControllerSheetLength,
          decoration: _buildInputDecoration(
              label: 'ความยาวชีทบอร์ด', hint: '', icon: Icons.straighten),
          keyboardType: TextInputType.number,
          validator: _validateNumber,
        ),
      ],
    );
  }

  Widget _buildPaperRollInch() {
    return Column(
      children: <Widget>[
        // Text(
        //   'หน้กระดาษ',
        //   style: TextStyle(color: Colors.blue, fontSize: 18),
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            //Text('ผ่า :'),
            DropdownButton<String>(
              items: _currencies.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(
                    dropDownStringItem,
                    style: TextStyle(fontSize: myTextNumber),
                  ),
                );
              }).toList(),
              onChanged: (String newValueSelected) {
                setState(() {
                  strError = '';
                  if (boxProduct.widthSheet > 0) {
                    String strDissect;
                    this._currentItemSelected = newValueSelected;
                    strDissect =
                        newValueSelected.substring(newValueSelected.length - 1);
                    //boxProduct.dissect = int.parse(strDissect);
                    boxProduct.tempDissect = int.parse(strDissect);
                    boxProduct.getPaperRollInch();
                    _currentItemSelectedPw = 'หน้า ${boxProduct.paperRollInch}';
                    print(_currentItemSelectedPw);
                    //txtPaperInch = '${boxProduct.paperRollInch}';
                    //print(boxProduct.widthSheet * boxProduct.dissect);
                    if (boxProduct.pMax <
                        ((boxProduct.widthSheet * boxProduct.tempDissect) /
                            25.4)) {
                      strError = 'ไม่มีหน้ากระดาษทีใช้';
                    } else {
                      strError = '';
                    }

                    _setScrap();
                    //print(strError);
                  }
                });
              },
              value: (_currentItemSelected),
            ),
            // Text(
            //   'หน้า : $txtPaperInch',
            //   style: TextStyle(fontSize: myTextNumber),
            // ),
            _buildDropBownButton(),
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            Text(
              'เศษ : $txtDissect',
              style: TextStyle(fontSize: myTextNumber),
            ),
//@@@@@@@@@@@@@@@@@@@@
          ],
        ),
      ],
    );
  }

  DropdownButton _buildDropBownButton() {
    return DropdownButton<String>(
      items: _currenciesPw.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
          value: dropDownStringItem,
          child: Text(
            dropDownStringItem,
            style: TextStyle(fontSize: myTextNumber),
          ),
        );
      }).toList(),
      onChanged: (String newValueSelected) {
        setState(() {
          if (boxProduct.widthSheet > 0) {
            String strPw;
            this._currentItemSelectedPw = newValueSelected;
            strPw = newValueSelected.substring(newValueSelected.length - 2);
            boxProduct.paperRollInch = int.parse(strPw);

            //หาผ่า
            //boxProduct.getPaperRollInch();

            // if (boxProduct.pMax <
            //     ((boxProduct.widthSheet * boxProduct.dissect) / 25.4)) {
            //   strError = 'ไม่มีหน้ากระดาษทีใช้';
            // } else {
            //   strError = '';
            // }
            _setScrap();
            //print(strError);
          }
        });
      },
      value: (_currentItemSelectedPw),
    );
  }

  Widget _buildError() {
    if (strError == '') {
      return SizedBox(
        height: 0,
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: Text(
          strError,
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
      );
    }
  }

  //Table
  Widget _gradeGram() {
    return Table(
      // defaultColumnWidth: FixedColumnWidth(150.0),
      border: TableBorder(
        horizontalInside: BorderSide(
          color: Colors.black26,
          style: BorderStyle.solid,
          width: 1.0,
        ),
        verticalInside: BorderSide(
          color: Colors.black26,
          style: BorderStyle.solid,
          width: 1.0,
        ),
      ),
      children: [
        _buildTableRow(
            "1, ${pw1.round()}, ${scrapRoll.getScrapRoll(1, pw1.round(), txtShtW).toStringAsFixed(1)}"),
        _buildTableRow(
            "2, ${pw2.round()}, ${scrapRoll.getScrapRoll(2, pw2.round(), txtShtW).toStringAsFixed(1)}"),
        _buildTableRow(
            "3, ${pw3.round()}, ${scrapRoll.getScrapRoll(3, pw3.round(), txtShtW).toStringAsFixed(1)}"),
        _buildTableRow(
            "4, ${pw4.round()}, ${scrapRoll.getScrapRoll(4, pw4.round(), txtShtW).toStringAsFixed(1)}"),
      ],
    );
  }

  TableRow _buildTableRow(String listOfNames) {
    return TableRow(
      children: listOfNames.split(',').map((name) {
        return Container(
          alignment: Alignment.center,
          child: Text(name, style: TextStyle(fontSize: 20.0)),
          padding: EdgeInsets.all(8.0),
        );
      }).toList(),
    );
  }

  //-------------------

  String _validateNumber(String value) {
    if (value.isEmpty) {
      return null; //'กรุณาใส่ตัวเลข';
    }
  }

  void _setScrap() {
    double nScrap = 0;
    nScrap = boxProduct.paperRollInch -
        ((boxProduct.widthSheet * boxProduct.dissect) / 25.4);
    //txtScrap = (nScrap.round()).toString();
    //txtDissect = (nScrap.toStringAsFixed(1));
    txtDissect = scrapRoll
        .getScrapRoll(boxProduct.tempDissect, boxProduct.paperRollInch,
            boxProduct.widthSheet)
        .toStringAsFixed(1);
  }

  void _setTxtPaperInch() {
    //txtPaperInch = (boxProduct.paperRollInch).toString();
    _currentItemSelectedPw = 'หน้า ${(boxProduct.paperRollInch).toString()}';
    //print(txtPaperInch);
  }

  void _setCoverBox() {
    textControllerTop.text = (boxProduct.coverTop).toString();
    textControllerBotton.text = (boxProduct.coverBottom).toString();
  }

  void _setSizeSheetboard() {
    textControllerSheetWidth.text = (boxProduct.widthSheet).toString();
    textControllerSheetLength.text = (boxProduct.lengthSheet).toString();
    _setTxtPaperInch();
  }

  void _handleRadioValueChange(value) {
    //print('value : $value');
    setState(() {
      boxProduct.lonType = value;
      _setAll();
    });
  }

  void _setAll() {
    boxProduct.CoverBox();
    boxProduct.SizeSheetboard();
    _setCoverBox();
    _setSizeSheetboard();
  }

  void _submit() {
    if (boxProduct.widthSheet > 0) {
      // if (this._formKey.currentState.validate()) {
      //   //
      // }
      setState(() {
        strError = '';
        txtShtW = boxProduct.widthSheet;

        boxProduct.setDissectList();

        boxProduct.tempDissect = boxProduct.getMyDiss();
        //boxProduct.getDissect();//err
        //boxProduct.fcTest();
        boxProduct.getPaperRollInch();
        //boxProduct.getAll();
        _currentItemSelected = 'ผ่า ${boxProduct.tempDissect}';
        _currentItemSelectedPw = 'หน้า ${boxProduct.paperRollInch}';

        ///txtPaperInch = '${boxProduct.paperRollInch}';
        _setScrap();
        //boxProduct.setWWP();
        pw1 = boxProduct.dissectList[1][0];
        pw2 = boxProduct.dissectList[2][0];
        pw3 = boxProduct.dissectList[3][0];
        pw4 = boxProduct.dissectList[4][0];
      });
    }
  }
}
