/*
 * Copyright (c) 2021 Akshay Jadhav <jadhavakshay0701@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation; either version 3 of the License, or (at your option) any later
 * version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:uuid/uuid.dart';

class FoodModel {
  final String description;
  // final double discount;
  final String image;
  final String menuId;
  final String name;
  final double price;
  final String keys;
  final int calories;

  FoodModel(
      {required this.description,
      // required this.discount,
      required this.image,
      required this.menuId,
      required this.name,
      required this.price,
      required this.keys,
      required this.calories});

  Map toMap(FoodModel food) {
    var data = Map<String, dynamic>();
    data['description'] = food.description;
    // data['discount'] = food.discount;
    data['image'] = food.image;
    data['menuId'] = food.menuId;
    data['name'] = food.name;
    data['price'] = food.price;
    data['keys'] = food.keys;
    data['calories']=food.calories;
    return data;
  }

  factory FoodModel.fromMap(
    Map<dynamic, dynamic> mapData,
  ) {
    return FoodModel(
      description: mapData['description'],
      // discount: mapData['discount'],
      image: mapData['image'],
      menuId: mapData['menuId'],
      name: mapData['name'],
      price: double.parse(mapData['price'].toString()),
      keys: mapData['keys']??Uuid().v4(),
      calories: mapData['calories']
    );
  }
}
