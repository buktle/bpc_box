class BoxProduct {
  BoxProduct() {
    this.hightBox = 0;
    this.widthBox = 0;
    this.lengthBox = 0;
    this.coverTop = 0;
    this.coverBottom = 0;
    this.widthSheet = 0;
    this.lengthSheet = 0;
    this.paperRollInch = 0;
    this.dissect = 1;
    this.tempWidthMin = 0;
    this.lonType = 'B';
    this.ppw[0] = 0;
    this.ppw[1] = 0;
    this.ppw[2] = 0;
    this.ppw[3] = 0;
    this.tempDissect = 1;
  }

  int tempDissect;
  int hightBox;
  int widthBox;
  int lengthBox;
  int coverTop;
  int coverBottom;
  int widthSheet;
  int lengthSheet;
  int paperRollInch;
  int pMin = 32;
  int pMax = 62;
  List<int> ppw = List<int>(4);

  double tempWidthMin;
  int dissect;
  Map<int, List<double>> dissectList = {
    //หน้ากระดาษ, เศษ, Error
    1: [0, 0, 0],
    2: [0, 0, 0],
    3: [0, 0, 0],
    4: [0, 0, 0]
  };

  Map<String, List<double>> longTypeList = const {
    //0.F_Even, 1.F_Odd, 2.เล็มข้าง, 3.เล็มท้าย, 4.ลิ้น, 5.K, 6.C, 7.H, 8.v_T, 9.v_TS, 10.v_Acc
    'B': [1, 0, 0.5, 6, 32, 1.2, 1.38, 0.25, 5, 7, 3],
    'C': [1, 2, 0.5, 6, 32, 1.15, 1.5, 0.361, 8, 9, 5],
    'BC': [5, 4, 0.75, 10, 35, 1.2, 2.88, 0.65, 12, 14, 7]
  };

  int getMyDiss() {
    int tmpDis = 1;
    double tmpSc;
    for (var i = 1; i <= 4; i++) {
      if (i == 1) {
        tmpSc = dissectList[i][1];
      }
      if (dissectList[i][2] < 1) {
        if (dissectList[i][1] < tmpSc) {
          tmpDis = i;
        }
        tmpSc = dissectList[i][1];
      }
    }
    return tmpDis;
  }

  void fcTest() {
    print(getMyDiss());
  }

  String lonType;
  final double scrapMin = 0.5;

  // List<int> paperRollInchList=const[
  //   32,34,36,38
  // ];

  void setWWP() {
    ppw[0] = dissectList[1][1].toInt();
    ppw[1] = dissectList[2][1].toInt();
    ppw[2] = dissectList[3][1].toInt();
    ppw[3] = dissectList[4][1].toInt();
  }

  //กำหนดค่าทั้งหมด
  // void getAll() {
  //   if (this.widthSheet > 0) {
  //     setDissectList();
  //     getDissect();
  //     getPaperRollInch();
  //   }
  // }

  //หาผ่าที่ดีที่สุด
  // void getDissect() {
  //   double nDiss = 100.0;

  //   for (var i = 1; i <= dissectList.length; i++) {
  //     if (dissectList[i][2] < 1) {

  //       if (dissectList[i][1] < nDiss) {
  //         nDiss = dissectList[i][1];
  //         tempDissect = dissectList[i][0].toInt();
  //       }
  //     }
  //   }
  //   //dissect = tempDissect;//dissectList.length;
  // }

  //กำหนดหน้ากระดาษ
  void getPaperRollInch() {
    this.paperRollInch = dissectList[tempDissect][0].toInt();
  }

  void setSheetInch() {
    //หน้ากว้างชีทบอร์ด นิ้ว + เศษที่ต้องเผื่อเล็ม.
    if (this.widthSheet > 0) {
      tempWidthMin = (this.widthSheet / 25.4) + scrapMin;
    }
  }

  void setDissectList() {
    //กำหนดหน้ากระดาษ เศษ ให้ dissectList
    setSheetInch();
    if (this.tempWidthMin > 0) {
      for (var i = 1; i <= 4; i++) {
        //หน้ากระดาษ
        dissectList[i][0] = setPaperRollInch(tempWidthMin * i).toDouble();
        //เศษ
        dissectList[i][1] = dissectList[i][0] - ((tempWidthMin - scrapMin) * i);
        //1=Error
        dissectList[i][2] = (tempWidthMin * i > pMax) ? 1 : 0;
      }
    }
  }

  int setPaperRollInch(nInch) {
    //หาหน้ากระดาษที่เศษน้อยที่สุด

    int runInch = pMin;

    if (nInch <= pMin) {
      return pMin;
    } else if (nInch >= pMax) {
      return pMax;
    } else {
      double num = (pMax - pMin) / 2;
      for (var i = 0; i < num; i++) {
        if (runInch < nInch) {
          runInch = runInch + 2;
        } else {
          return runInch;
        }
      }
      return runInch;
    }
  }

  double fcCoverBox(double nDub) {
    if ((nDub % 2) == 1) {
      return (nDub + longTypeList[lonType][0]) / 2;
    } else {
      return (nDub + longTypeList[lonType][1]) / 2;
    }
  }

  void CoverBox() {
    if (this.widthSheet > 0 && this.lengthBox > 0) {
      double tempDouble = 0.0;
      if (this.widthBox < this.lengthBox) {
        //tempDouble = (this.widthBox.toDouble() / 2);
        tempDouble = fcCoverBox(this.widthBox.toDouble());
      } else {
        //tempDouble = (this.lengthBox.toDouble() / 2);
        tempDouble = fcCoverBox(this.lengthBox.toDouble());
      }

      this.coverBottom = tempDouble.toInt();
      this.coverTop = tempDouble.toInt();
    } else {
      this.coverBottom = 0;
      this.coverTop = 0;
    }

    setSheetInch(); //หน้ากว้างชีทบอร์ด นิ้ว
  }

  void SizeSheetboard() {
    this.widthSheet = (this.coverTop + this.coverBottom) + this.hightBox;

    if (this.widthBox > 0 && this.lengthBox > 0) {
      this.lengthSheet = (this.widthBox * 2) +
          (this.lengthBox * 2) +
          (longTypeList[this.lonType][4].toInt()) +
          (longTypeList[this.lonType][3].toInt()); //+ ลิ้น เล็มท้าย
    }
    setSheetInch(); //หน้ากว้างชีทบอร์ด นิ้ว
  }
}
