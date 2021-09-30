import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/controllers/createPlayerController.dart';
import 'package:pro_player_market/controllers/postController.dart';
import 'package:pro_player_market/models/cityModel.dart';

class DropButton extends StatefulWidget {
  final double ? cSize, oWidth;
  final Color ? color;
  final Color ? textColor;
  var controller;
  var cities;

  DropButton({
    Key ?key,
    this.cSize = 0.8,
    this.oWidth = 1,
    this.color = Colors.white,
    this.textColor = Colors.black,
    this.controller,
    this.cities,
  }) :super(key: key);

  @override
  _DropButtonState createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {
  //final controller = Get.put(CreatePlayerController());
  String ?dropdownValue = 'select';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    widget.cities = Get.find<PostController>().cities.value;
    //dropdownValue = widget.cities[0].cityName;
    return Container(
      //margin: EdgeInsets.symmetric(vertical: 12.5* widget.cSize),
      padding: EdgeInsets.symmetric(horizontal: 12 *widget.cSize!, vertical: 5 * widget.cSize!),
      height: size.width * (widget.cSize!/6),
      width: size.width * widget.cSize! * widget.oWidth!,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(/*37.5*cSize*/30),
      ),
      child:DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_downward, color: ppmMain),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
            color: ppmMain
        ),

        onChanged: (String ? newValue) {
          setState(() {
            dropdownValue = newValue! ;
            widget.controller.city = dropdownValue;
            /*switch (dropdownValue) {
              case 'Coworking Space': {
                  controller.category = PlaceTypeEnum.coworkingSpace.toString();
                } break;
              case 'Studio': {
                controller.category = PlaceTypeEnum.studio.toString();
              } break;
              case 'Restaurant': {
                controller.category = PlaceTypeEnum.restaurant.toString();
              } break;
          }*/
          });
        },

        items: widget.cities
            .map<DropdownMenuItem<String>>((data) {
          return DropdownMenuItem<String>(
            value: data.cityName,
            child: Center(child: Text('${data.cityName}'.tr)),
          );
        }).toList(),
      ),
    );
  }
}
