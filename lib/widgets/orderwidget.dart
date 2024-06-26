import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:food_delivery_app/models/food_model.dart';
import 'package:food_delivery_app/models/request_model.dart';
import 'package:food_delivery_app/utils/universal_variables.dart';

import 'foodTitleWidget.dart';

class OrderWidget extends StatefulWidget {
  final RequestModel request;
  OrderWidget(this.request);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late List<Step> steps ;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  steps=  [
      Step(
        content: Text(widget.request.address),
        title: Text('Placed'),
        isActive: true,
      ),
      Step(
        title: Text('On The Way'),
        content: Text('asd'),
        isActive: false,
      ),
      Step(
        content: Text('asd'),
        title: Text('Completed'),
        isActive: false,
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              widget.request.name,
              style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              widget.request.address,
              style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.normal,
              ),
            ),
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                  "https://www.pngitem.com/pimgs/m/252-2523515_delivery-clipart-delivery-order-frames-illustrations.png"),
            ),
            trailing: Text(
              widget.request.total + " JD",
              style: TextStyle(
                color: UniversalVariables.orangeColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          createSatusBar(),
          Container(
            padding: EdgeInsets.only(left: 20.0, top: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Food",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                createListOfFood(),
              ],
            ),
          )
        ],
      ),
    );
  }

  createSatusBar() {
    return Container(
      height: 30.h,
      child: Stepper(
        currentStep: int.parse(widget.request.status),
        steps: steps,
        type: StepperType.vertical,
        physics: NeverScrollableScrollPhysics(),
        controlsBuilder:
            (BuildContext context, ControlsDetails controlsDetails) =>
                Container(
          height: 0.0,
        ),
      ),
    );
  }

  createListOfFood() {
    List<FoodModel> foodList = [];
    widget.request.foodList.forEach((key, value) {
      FoodModel food = FoodModel(
        name: value["name"],
        image: value["image"],
        keys: value["keys"],
        price: double.parse(value["price"].toString()),
        description: value["description"],
        menuId: value["menuId"],
        calories: value['calories']??0
      );
      foodList.add(food);
    });

    return Container(
      height: 200.0,
      child: foodList.length == -1
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: foodList.length,
              itemBuilder: (_, index) {
                return FoodTitleWidget(
                  foodList[index],
                );
              }),
    );
  }
}
