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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/food_model.dart';
import 'package:food_delivery_app/resourese/databaseSQL.dart';
import 'package:food_delivery_app/resourese/firebase_helper.dart';
import 'package:food_delivery_app/screens/homepage.dart';

class CartPageBloc with ChangeNotifier {
  List<FoodModel> foodList = [];
  double totalPrice = 0;
  double totalCalories = 0;

  FirebaseHelper mFirebaseHelper = FirebaseHelper();
  late DatabaseSql databaseSql;

  BuildContext? context;

  getDatabaseValue() async {
    databaseSql = DatabaseSql();
    await databaseSql.openDatabaseSql();
    foodList = await databaseSql.getData();
    //calculating total price
    foodList.forEach((food) {
      double foodItemPrice = food.price;
      totalPrice += foodItemPrice;
      totalCalories += food.calories;
    });
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  orderPlaceToFirebase(String name, String address) async {
    mFirebaseHelper
        .addOrder(totalPrice.toString(),totalCalories.toString(), foodList, name, address)
        .then((isAdded) {
      notifyListeners();
      if (context != null) {
        Navigator.pushReplacement(context!,
            MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      }
    });
  }
}
