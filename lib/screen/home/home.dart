import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_1/models/brew.dart';
import 'package:first_app_1/screen/home/brew_list.dart';
import 'package:first_app_1/screen/home/settings_form.dart';
import 'package:first_app_1/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:first_app_1/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
          
        );
      });
    }


    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid:"").brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew', style: TextStyle(color: Colors.white, fontSize: 28)),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person, color: Colors.black),
              label: Text('logout',style: TextStyle(color: Colors.black, fontSize: 15)),
              onPressed: () async{
                await _auth.signOut();
              },            
              ),
            TextButton.icon(            
              icon: Icon(Icons.settings, color: Colors.black),
              
              label: Text('settings', style: TextStyle(color: Colors.black, fontSize: 15)),
              onPressed: () => _showSettingsPanel(),
              ),
            
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.jpg'),
              fit: BoxFit.cover,
              ),
          ),
          child: BrewList()
          ),
      
      ),
    );
  }
}