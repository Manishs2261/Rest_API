import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  
  void login(String email, String password) async{
    try
    {
          Response response = await post(
            Uri.parse('https://reqres.in/api/register'),
            body:{
              "email": email,
              "password": password,

            }
          );
          if(response.statusCode == 200)
            {
              var data = jsonDecode(response.body.toString());
              print(data['token']);
              print('account created successfully');
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
        title: Text("sign up"),
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
                child:Center(child: Text("Sign UP",style: TextStyle(fontSize: 20),),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
