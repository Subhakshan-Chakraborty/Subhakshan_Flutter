import 'package:first_app_1/services/auth.dart';
import 'package:first_app_1/shared/constants.dart';
import 'package:first_app_1/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to Brew Crew'),
        actions: <Widget>[
          TextButton(
            
            style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
              ),
            onPressed: () async {
              widget.toggleView();

            }, 
            child: Text('Sign In'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoratiion.copyWith(fillColor: Colors.brown[200],
                  filled: true,hintText: 'Email'),
                validator: (String?value){
                  if(value!=null && value.isEmpty){
                    return "Enter valid email";
                  }
                  return null;
                },
                onChanged: (val){
                  setState(() => email = val );
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoratiion.copyWith(fillColor: Colors.brown[200],
                  filled: true,hintText: 'Password'),
                validator: (String?value){
                  if(value!=null && value.length<6){
                    return "Enter a password 6+ chars long";
                  }
                  return null;
                },
                obscureText: true,
                onChanged: (val){
                  setState(() => password = val );
                }
              ),
              SizedBox(height: 20.0),
              ElevatedButton( 
                child: Text('Register'),
                style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.yellow[400]),
                textStyle: WidgetStateProperty.all(
                  TextStyle(color: Colors.white))
                ),
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result==null){

                      setState(() {
                       error = 'please supply a valid email';
                       loading = false;
                       });
                    }
                  }   
                },
                ),
                SizedBox(height: 20.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.pink, fontSize: 14.0),
                )
            ],
            ),
        ),
      ),
    );
  }
}