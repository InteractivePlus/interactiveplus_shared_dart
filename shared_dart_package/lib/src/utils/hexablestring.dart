import 'dart:convert';

import 'package:hex/hex.dart';

extension HexableString on String{
  /// Encodes into hexidecimal string
  String toHexString(){
    return HEX.encode(utf8.encode(this));
  }

  /// Decodes from hex string
  /// 
  /// Throws [FormatException] if not a valid hex string
  String decodeFromHexString(){
    return utf8.decode(HEX.decode(this));
  }

  bool isValidHexString(){
    try{
      HEX.decode(this);
    }catch(e){
      return false;
    }
    return true;
  }
}