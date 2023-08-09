import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void login(String email, String password) async{
    try
    {
      Response response = await post(
          Uri.parse('https://reqres.in/api/login'),
          body:{
            "email": email,
            "password": password,

          }
      );
      if(response.statusCode == 200)
      {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('account created login successfully');
      }
      else
      {
        print("Failed ");
      }

    }catch(e){

      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Login"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  hintText: "Email",
                  labelText: "Email"
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                  hintText: "password",
                  labelText: "password"
              ),
            ),
            SizedBox(height: 20,),

            GestureDetector(
              onTap: (){
                login(_emailController.text.toString(),_passwordController.text.toString());
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child:Center(child: Text("Login",style: TextStyle(fontSize: 20),),),
              ),
            )
          ],
        ),
      ),
    );
  }
  }

