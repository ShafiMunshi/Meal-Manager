import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TestScreen extends StatelessWidget {
  // const TestScreen({super.key});

  List<Map<String, List<Map<String, List<Map<String, int>>>>>> memberMeal = [
    {
      'shafi': [
        {
          'day1': [
            {'lunch': 1},
            {'break': 0},
          ]
        },
        {
          'day2': [
            {'lunch': 1},
            {'break': 0}
          ]
        }
      ]
    },
    {
      'rakib': [
        {
          'day1': [
            {'lunch': 2},
            {'break': 1},
          ]
        },
        {
          'day2': [
            {'lunch': 3},
            {'break': 5}
          ]
        }
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    print('working test...');

    int indx;
    for (int i = 0; i < memberMeal.length; i++) {
      if (memberMeal[i].containsKey('shafi')) {
        print('indx is $i');
        indx = i;
        
        break;
      }
    }

    List<String> d = ['safi', 'rakib'];
    d[6] = 'sakib';
    print(d[6]);

    // print(memberMeal.map((e) => e.forEach((key, value) {
    //       // if(key=='shafi'){
    //       //   int indx=
    //       // }
    //       int indx=
    //     })));
    // if (memberMeal.contains('shafi')) {
    //   int indx = memberMeal.indexWhere((element) => element == 'shafi');
    //   print("the index is $indx");
    // }
    return Scaffold();
  }
}
