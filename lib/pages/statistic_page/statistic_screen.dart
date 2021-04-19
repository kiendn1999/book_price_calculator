import 'package:book_price_calculator/pages/statistic_page/statistic_model.dart';
import 'package:book_price_calculator/resource/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticScreen extends StatefulWidget {
  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final changeInfor = Provider.of<StatisticModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Thống Kê"),
      ),
      body: Column(
        children: [
          textWidget(
              text: "Thông tin thống kê",
              colorText: Colors.black,
              colorBox: Colors.green,
              textAlign: TextAlign.left,
              weightBox: MediaQuery.of(context).size.width,
              marginBox: EdgeInsets.only(top: 10, bottom: 10)),
          textAndTextWidget(
              titleText: "Tổng số KH : ",
              contentText: changeInfor.customerNumber.toString(),
              textContentBoxColor: Colors.transparent,
              alignContentText: TextAlign.left),
          textAndTextWidget(
              titleText: "Tổng số KH là VIP : ",
              contentText: changeInfor.vipCustomerNumber.toString(),
              textContentBoxColor: Colors.transparent,
              alignContentText: TextAlign.left),
          textAndTextWidget(
              titleText: "Tổng doanh thu : ",
              contentText: changeInfor.moneyTotal.toString(),
              textContentBoxColor: Colors.transparent,
              alignContentText: TextAlign.left),
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width,
            color: Colors.green,
          ),
        ],
      ),
    );
  }

/*getInforFromDatabase(context)async {
  sharedPreferences = await SharedPreferences.getInstance();
  moneyTotal = sharedPreferences.getInt("money_total")?? 0;
}*/
}
