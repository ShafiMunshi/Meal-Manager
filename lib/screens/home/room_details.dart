import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_manager/controller/data_controller.dart';
import 'package:meal_manager/screens/widgets/bigtext_widget.dart';
import 'package:meal_manager/utils/theme_data.dart';
import 'package:meal_manager/utils/ui_parameter.dart';

class RoomDetails extends StatelessWidget {
   RoomDetails({super.key});
  final controller = Get.find<DataController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: UiParameters.cardBorderRadius(),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigText(
              text: 'Room: ${controller.houseeeData.value?.houseName}'),
           Text(
              'Room id:  ${(controller.houseeeData.value?.houseID)}',
              style: textTheme.bodyMedium!.copyWith(),
            ),
          
          SizedBox(
            height: 4,
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Manager:  ',
                    style: textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Shafi Munshi',
                    style: textTheme.bodySmall!.copyWith(color: Colors.red),
                  ),
                ],
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Leave House',
                    style: textTheme.bodySmall!.copyWith(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.delete))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
