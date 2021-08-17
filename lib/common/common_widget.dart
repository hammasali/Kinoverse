import 'package:flutter/material.dart';

import '../app.dart';
import 'StringRes.dart';
import 'TextStyleRes.dart';

class CommonWidget{
  static squareButton({containerColor,height, width,text,textColor,fontSize,onTap,fontWeight}){
    return  GestureDetector(
      onTap: onTap,
      child: Container(
          color: containerColor,
          height: height,
          width: width,
          child: Center(
            child: TextStyleRes.textStyleFont1(
              textColor: textColor,
                fontSize: fontSize, text: text,fontWeight: FontWeight.w700),
          )),
    );
  }
}