import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ContactUs(
          image: Image.asset('assets/logo.jpg',height: 25.h,),
          email: 'tamimiaya232@gmail.com',
          companyName: 'Smart Bites',
          phoneNumber: '+962790309645',
          dividerThickness: 2,
          tagLine: 'Smart Bites',
          textColor: Colors.white,
          cardColor: Colors.blue[300]!,
          companyColor: Colors.blue,
          taglineColor: Colors.white,
        ),
      ),
    );
  }
}
