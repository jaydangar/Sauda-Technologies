import 'package:flutter/material.dart';

class Utils{
  /**
   * * get device size 
   */
  static Size getDeviceSize(BuildContext context){
    return MediaQuery.of(context).size;
  }

}