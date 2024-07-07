import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_1/models/user.dart';
import 'package:first_app_1/services/database.dart';

class AuthService{
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // crete user obj based on FirebaseUser
  Users? _userfromFirebase(User? user){
    // ignore: unnecessary_null_comparison
    return user != null ? Users(uid: user.uid) : null;
  }
  
  
  //auth change user srtream
  Stream <Users?> get user{
    return _auth.authStateChanges()
      //.map((User? user) => _userfromFirebase(user));
      .map(_userfromFirebase);
    
  }


  // sign in anon
  Future signInAnon() async{
    try{
      UserCredential result=await _auth.signInAnonymously();
      User? user = result.user;
      return _userfromFirebase(user!);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userfromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //crete a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData('0','new crew member', 100);
      return _userfromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}
