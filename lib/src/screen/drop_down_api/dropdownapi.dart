import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'DeopDownModal.dart';
class DropDownApi extends StatefulWidget {
  const DropDownApi({super.key});

  @override
  State<DropDownApi> createState() => _DropDownApiState();
}

class _DropDownApiState extends State<DropDownApi> {


  
  Future<List<DeopDownModal>> getPost() async{

    try {


      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      final body = json.decode(response.body) as List;

      if(response.statusCode == 200){
        return body.map((e){
          final map = e as Map<String,dynamic>;
          return DeopDownModal(
            userId: map['userId'],
            id: map['id'],
            title: map['title'],
            body: map['body'],
          );
        }).toList();
      } 
      
        }on SocketException{
      throw Exception("no internet");
    }
        throw Exception("Error Featching data");
  }

  var selectedvalue;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drop Down Api"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            FutureBuilder<List<DeopDownModal>>(
              future: getPost(),
                builder: (context,snapshot){

                if(snapshot.hasData){
                  return DropdownButton(
                    hint: Text("select value"),
                      value: selectedvalue,
                      items: snapshot.data!.map((e){
                        return DropdownMenuItem(
                          value: e.id.toString(),
                            child: Text(e.id.toString())
                        );
                      }).toList(),
                      onChanged: (value){

                      selectedvalue = value;
                      setState(() {

                      });
                      }
                  );
                }else
                  {
                    return CircularProgressIndicator();
                  }
                }
            )
            

          ],
        ),
      ),
    );
  }
}
