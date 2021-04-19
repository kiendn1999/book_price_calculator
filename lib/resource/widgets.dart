import 'package:flutter/material.dart';

Widget textWidget(
    {@required text,
    @required colorText,
    @required colorBox,
    @required textAlign,
    @required weightBox,
    marginBox}) {
  return Container(
    margin: marginBox,
    width: weightBox,
    padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
    decoration: BoxDecoration(color: colorBox),
    child: Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: colorText,
      ),
    ),
  );
}

Widget textAndTextWidget(
    {@required titleText,
    @required contentText,
    @required textContentBoxColor,
    @required alignContentText}) {
  return Container(
    padding: EdgeInsets.only(top: 10, bottom: 10),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(titleText),
        ),
        Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              color: textContentBoxColor,
              child: Text(
                contentText,
                textAlign: alignContentText,
              ),
            ))
      ],
    ),
  );
}
