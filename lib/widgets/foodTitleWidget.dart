import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:food_delivery_app/models/food_model.dart';
import 'package:food_delivery_app/screens/FoodDetailPage.dart';
import 'package:food_delivery_app/utils/universal_variables.dart';

class FoodTitleWidget extends StatelessWidget {
  final FoodModel fooddata;

  FoodTitleWidget(this.fooddata);

  @override
  Widget build(BuildContext context) {
    var random = new Random();
    gotoFoodDetails() {
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodDetailPage(fooddata)));
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 500),
              pageBuilder: (_, __, ___) => FoodDetailPage(food: fooddata)));
    }

    return GestureDetector(
      onTap: () => gotoFoodDetails(),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            children: [
              Container(
                height: 22.h,
                width: 45.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange![100]!,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Hero(
                      tag: "avatar_${fooddata.keys.toString()}",
                      child: CachedNetworkImage(
                        imageUrl: fooddata.image,
                        fit: BoxFit.fill,
                      )),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Wrap(
                spacing: 20.0, // gap between adjacent chips
                runSpacing: 4.0, // gap between lines
                direction: Axis.vertical,
                children: [
                  Text(
                    "${fooddata.name} ",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Icon(
                        Icons.star,
                        color: UniversalVariables.orangeAccentColor,
                      ),
                      Text(
                        doubleInRange(random, 3.5, 5.0).toStringAsFixed(1),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: UniversalVariables.orangeAccentColor),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                    ],
                  ),
                  Text(
                    "${fooddata.price} JD",
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),  Text(
                    "${fooddata.calories} Cals",
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ],
              )
            ],
          )),
    );
  }

  //we are generating random rating for now
  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
}
