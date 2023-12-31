import 'package:flutter/material.dart' show Alignment, Color, CrossAxisAlignment;
import 'package:thuc_tap_flutter/views/resources/color.dart';

class MyWidgetValidate {
  Alignment determineAlignment(String senderId, String currentUserId){
    Alignment alignment = (senderId == currentUserId)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return alignment;
  }

  CrossAxisAlignment determineCrossAxisAlignment(String senderId, String currentUserId){
    CrossAxisAlignment crossAxisAlignment = (senderId == currentUserId)
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    return crossAxisAlignment;
  }

  Color determineColor(String senderId, String currentUserId){
    Color color = (senderId == currentUserId)
        ? CustomColors.themeColor
        : CustomColors.colorBubbleLeff;
    return color;
  }

  Color determineColorText(String senderId, String currentUserId){
    Color color = (senderId == currentUserId)
        ? CustomColors.white
        : CustomColors.back;
    return color;
  }

  String determineName(String senderId, String currentUserId, String senderEmail){
    String name = (senderId == currentUserId)
        ? 'You'
        : senderEmail;
    return name;
  }
}