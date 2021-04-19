import 'package:book_price_calculator/pages/statistic_page/statistic_model.dart';
import 'package:book_price_calculator/pages/statistic_page/statistic_screen.dart';
import 'package:book_price_calculator/resource/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController customerNameController = TextEditingController();
  TextEditingController bookNumberController = TextEditingController();

  SharedPreferences sharedPreferences;

  FocusNode focusNode;
  bool isVip = false;
  var bookMoney = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    customerNameController.dispose();
    bookNumberController.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final changeInfor = Provider.of<StatisticModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Bán sách"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                textWidget(
                    weightBox: MediaQuery.of(context).size.width,
                    text: "Chương trình bán sách Online",
                    colorText: Colors.white,
                    colorBox: Colors.green,
                    textAlign: TextAlign.center),
                textWidget(
                    weightBox: MediaQuery.of(context).size.width,
                    text: "Thông tin hóa đơn",
                    colorText: Colors.black,
                    colorBox: Colors.green,
                    textAlign: TextAlign.left),
                textAndTextFieldWidget(
                    text: "Tên Khách Hàng : ",
                    textController: customerNameController,
                    hintText: "Tên khách hàng",
                    keyboardType: TextInputType.text,
                    focusNode: focusNode),
                textAndTextFieldWidget(
                    text: "Số lượng sách : ",
                    textController: bookNumberController,
                    hintText: "Số lượng sách ",
                    keyboardType: TextInputType.number),
                vipCheckBox(),
                textAndTextWidget(
                    titleText: "Thành Tiền : ",
                    contentText: bookMoney.toString(),
                    textContentBoxColor: Colors.black26,
                    alignContentText: TextAlign.center),
                buttons(
                    buttonText1: "TÍNH TT",
                    buttonText2: "TIẾP",
                    buttonText3: "THỐNG KÊ",
                    buttonFunction1: () {
                      setState(() {
                        bookMoney = tinhTienFunction();
                      });
                    },
                    buttonFunction2: () {
                      if (customerNameController.text != "") {
                        changeInfor.updateCustomerNumber(c: 1);
                        if (isVip) changeInfor.updateVipCustomerNumber(c: 1);
                        changeInfor.updateMoneyTotal(bookMoney: bookMoney);
                      }
                      customerNameController.text = "";
                      bookNumberController.text = "";
                      setState(() {
                        isVip = false;
                      });
                      focusNode.requestFocus();
                      bookMoney = 0;
                      setInforToDatabase(
                          customer_total: changeInfor.customerNumber,
                          vip_customer: changeInfor.vipCustomerNumber,
                          money_total: changeInfor.moneyTotal);
                    },
                    buttonFunction3: () {
                      var route = MaterialPageRoute(
                          builder: (context) => StatisticScreen());
                      Navigator.push(context, route);
                    }),
                logoutButton()
              ],
            ),
          ),
        ));
  }

  setInforToDatabase(
      {@required customer_total,
      @required vip_customer,
      @required money_total}) async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt("customer_total", customer_total);
    await sharedPreferences.setInt("vip_customer", vip_customer);
    await sharedPreferences.setInt("money_total", money_total);
  }

  tinhTienFunction() {
    if (isVip)
      return (int.parse(bookNumberController.text == ""
                  ? "0"
                  : bookNumberController.text) *
              20000 *
              0.9)
          .toInt();
    else
      return (int.parse(bookNumberController.text == ""
              ? "0"
              : bookNumberController.text) *
          20000);
  }

  logoutButton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  _showMyDialog();
                }),
          )
        ],
      ),
    );
  }

  clearSharedPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bạn có muốn thoát ứng dụng không ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Đồng ý'),
              onPressed: () {
                clearSharedPreference();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  buttons({
    @required buttonText1,
    @required buttonText2,
    @required buttonText3,
    @required buttonFunction1,
    @required buttonFunction2,
    @required buttonFunction3,
  }) {
    return Container(
      margin: EdgeInsets.only(right: 5, left: 5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.only(right: 10),
                color: Colors.grey,
                padding:
                    EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                child: Text(
                  buttonText1,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              onTap: buttonFunction1,
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.only(right: 10),
                color: Colors.grey,
                padding:
                    EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                child: Text(
                  buttonText2,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              onTap: buttonFunction2,
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                color: Colors.grey,
                padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: Text(
                  buttonText3,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              onTap: buttonFunction3,
            ),
          ),
        ],
      ),
    );
  }

  Widget textAndTextFieldWidget(
      {@required text,
      @required textController,
      @required hintText,
      @required keyboardType,
      focusNode}) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(text),
          ),
          Expanded(
              flex: 3,
              child: TextField(
                  controller: textController,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    hintText: hintText,
                  )))
        ],
      ),
    );
  }

  vipCheckBox() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: Container()),
          Expanded(
              flex: 3,
              child: CheckboxListTile(
                title: Text("Khách hàng Vip"),
                value: isVip,
                contentPadding: EdgeInsets.only(left: 0),
                activeColor: Colors.red,
                onChanged: (newValue) {
                  setState(() {
                    isVip = newValue;
                  });
                },
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ))
        ],
      ),
    );
  }
}
