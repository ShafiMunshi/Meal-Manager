import 'package:flutter/material.dart';
import 'package:get/get.dart';


  @override
  SnackBar customSnackBar(String msgText){
    return SnackBar(
      content: Text(msgText),
      backgroundColor: Colors.green,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );
  }

