import 'package:flutter/material.dart';

class Constant {
  static const Color loginBackground1 = Color(0xFF191347);
  static const Color loginTextField = Color(0xFF2b2a66);
  static const Color loginbutton = Color(0xFF8168F7);
  static const Color loginBackground2 = Color(0xFF544f90);
  static const Color loginTextfieldContent = Color(0xFFB3B6B7);
  static const Color cartIcon = Color(0xFFe2e6e7);
  static const Color mainPageCardbackground = Color(0xFF222356);
  static const Color mainPageDrawerbackground = Color(0xFF212357);
  static const Color totalsBackground = Color(0xFF191C47);
  static const Color sectionUnselected = Color(0xFF42466B);
  static const Color paymentBorders = Color(0xFF191c47);

  static List<List<Color>> cardColors = [
    [const Color(0xFFFebf93), const Color(0xFFfd9a57)],
    [const Color(0xFF7a65e6), const Color(0xFFe3aef4)],
    [
      const Color(0xFFfca7e2),
      const Color(0xFFfa98be),
    ],
    [const Color(0xFF93abfe), const Color(0xFF5153bb)]
  ];
  static String englishToPersianNumbers(String input) {
    Map<String, String> numberMap = {
      '0': '۰',
      '1': '۱',
      '2': '۲',
      '3': '۳',
      '4': '۴',
      '5': '۵',
      '6': '۶',
      '7': '۷',
      '8': '۸',
      '9': '۹',
    };

    String result = '';
    for (int i = 0; i < input.length; i++) {
      String char = input[i];
      if (numberMap.containsKey(char)) {
        result += numberMap[char]!;
      } else {
        result += char;
      }
    }
    return result;
  }
}
