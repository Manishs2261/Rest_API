import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExamoleFour extends StatefulWidget {
  const ExamoleFour({super.key});

  @override
  State<ExamoleFour> createState() => _ExamoleFourState();
}

class _ExamoleFourState extends State<ExamoleFour> {

  
  var data;
  Future<void> getUserApi()async{
    
    final response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode == 200)
      {
        data = jsonDecode(response.body.toString());
      }else
        {
          
        }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example four"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                future: getUserApi(),
                builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting)
                    {
                      return Text("LOading");
                    }
                  return ListView.builder(
                    itemCount: data.length ,
                      itemBuilder: (context,index){
                        return Card(
                          child:Column(
                            children: [

                              ReusabalRow(title: "Name", value: data[index]['name'].toString() ),
                              ReusabalRow(title: "username", value: data[index]['username'].toString() ),
                              ReusabalRow(title: "address", value: data[index]['address']['street'].toString() ),
                            ],
                          ),
                        );
                      });
                },
              ))
        ],
      ),
    );
  }
}

class ReusabalRow extends StatelessWidget {

  String title, value;
  ReusabalRow({super.key,required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    ) ;
  }
}