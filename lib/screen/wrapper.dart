import 'package:first_app_1/models/user.dart';
import 'package:first_app_1/screen/authentication/authentication.dart';
import 'package:first_app_1/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {


    final user = Provider.of<Users?>(context);
    print(user);

    //return either home or authenticate widget
    if (user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}