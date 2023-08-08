import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'UseerModel.dart';

class ExamplaThree extends StatefulWidget {
  const ExamplaThree({super.key});

  @override
  State<ExamplaThree> createState() => _ExamplaThreeState();
}

class _ExamplaThreeState extends State<ExamplaThree> {
  List<UseerModel> userList = [];

  Future<List<UseerModel>> getUserApi() async{
    
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode == 200)
      {
        var data = jsonDecode(response.body.toString());
        for(Map i in data)
          {
            userList.add(UseerModel.fromJson(i));

          }
        return userList;
      }else
        {
          return userList;
        }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example three"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                future: getUserApi(),
                builder: (context,AsyncSnapshot<List<UseerModel>> snapshot){
                  if(!snapshot.hasData)
                    {
                      return CircularProgressIndicator();
                    }else
                      {
                        return ListView.builder(
                            itemCount: userList.length,
                            itemBuilder: (context,index){

                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                    ReusabalRow(title: 'Name', value: snapshot.data![index].name.toString()),
                                      ReusabalRow(title: 'User Name', value: snapshot.data![index].username.toString()),
                                      ReusabalRow(title: 'User Email', value: snapshot.data![index].email.toString()),
                                      ReusabalRow(title: 'address', value: snapshot.data![index].address!.geo!.lat.toString()),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }

                  
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
