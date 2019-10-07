class ScrapRoll{
  // ScrapRoll(){
  //   this.sht=0;
  // }

  // int sht;

  double getScrapRoll(int dis,int pw,int sb){
    return pw-((sb*dis)/25.4).toDouble();
  }


}