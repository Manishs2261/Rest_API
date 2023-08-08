import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/PostModel.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<PostModel> postList = [];
  
  Future<List<PostModel>> getPostApi () async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200)
      {

        postList.clear();
        for(Map i in data)
        {
          postList.add(PostModel.fromJson(i));
        }
        return postList;

      }else
        {

          return postList;
        }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [

            Expanded(
              child: FutureBuilder(
                future: getPostApi(),
                  builder: (context , snapshot){

                  if(!snapshot.hasData){
                    return Text('Loading');
                  }else
                    {
                      return ListView.builder(
                        itemCount: postList.length,
                          itemBuilder: (context,index){

                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Title',style:TextStyle(
                                    fontSize: 20,fontWeight: FontWeight.bold
                                  )),
                                  Text(postList[index].title.toString()),
                                  SizedBox(height: 10,),
                                  Text('Discription',style:TextStyle(
                                      fontSize: 20,fontWeight: FontWeight.bold
                                  )),
                                  Text(postList[index].body.toString()),

                                ],
                              ),
                            ),
                          );

                          });
                    }

                  }),
            ),
          ],
        ),
      ),
    );
  }
}
