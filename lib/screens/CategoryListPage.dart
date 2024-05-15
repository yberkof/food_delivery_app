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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/category_model.dart';
import 'package:food_delivery_app/models/food_model.dart';
import 'package:food_delivery_app/resourese/firebase_helper.dart';
import 'package:food_delivery_app/utils/universal_variables.dart';
import 'package:food_delivery_app/widgets/foodTitleWidget.dart';

class CategoryListPage extends StatefulWidget {
  final CategoryModel category;
  CategoryListPage(this.category);
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  FirebaseHelper mFirebaseHelper = FirebaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
        Container(
        padding: EdgeInsets.all(0.0),
        child: Stack(
          children: [
            Container(
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.orange.withOpacity(0.9),
                  child: Container(height: 1,width: 1,)),
            ),
          ],
        ),
        alignment: Alignment.bottomLeft,
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0)),
          image: DecorationImage(
              image: CachedNetworkImageProvider(widget.category.image),
              fit: BoxFit.cover),
        ),
      ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: UniversalVariables.whiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              child: Column(
                children: [
                  createFoodList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  createFoodList() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: StreamBuilder<List<FoodModel>>(
          stream: mFirebaseHelper
              .fetchSpecifiedFoods(widget.category.keys)
              .asStream(),
          builder: (context, AsyncSnapshot<List<FoodModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == null || snapshot.data!.length == 0) {
                return Center(
                  child: Text("No Food Available"),
                );
              }
              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    return FoodTitleWidget(
                      snapshot.data![index],
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
