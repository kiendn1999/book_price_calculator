import 'package:flutter/cupertino.dart';

class StatisticModel extends ChangeNotifier {
  int customerNumber=0;
  int vipCustomerNumber=0;
  int moneyTotal=0;


  StatisticModel(){
    this.customerNumber=0;
    this.vipCustomerNumber=0;
    this.moneyTotal=0;
  }

  updateInfo({customerNumber, vipCustomerNumber, moneyTotal}) {
    this.customerNumber = customerNumber;
    this.vipCustomerNumber = vipCustomerNumber;
    this.moneyTotal = moneyTotal;
    notifyListeners();
  }

  updateCustomerNumber({c}){
    this.customerNumber+=c;
    notifyListeners();
  }

  updateVipCustomerNumber({c}){
    this.vipCustomerNumber+=c;
    notifyListeners();
  }

  updateMoneyTotal({bookMoney}){
    this.moneyTotal+=bookMoney;
    notifyListeners();
  }

}
