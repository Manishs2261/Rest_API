import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExamoleTwo extends StatefulWidget {
  const ExamoleTwo({super.key});

  @override
  State<ExamoleTwo> createState() => _ExamoleTwoState();
}

class _ExamoleTwoState extends State<ExamoleTwo> {

  List<Photo> photosList = [];
  
  Future<List<Photo>> getPhoto ()async{
    
    final respons = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));


    if(respons.statusCode == 200)
      {
        var data = jsonDecode(respons.body.toString());

        for(Map i in data)
          {
            Photo photo = Photo(title: i['title'], url: i['url'], id: i['id']);
            photosList.add(photo);
          }
        return photosList;
      }else
        {
          return photosList;

        }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example Tewo"),
      ),
      body: Column(
        children: [

          Expanded(
            child: FutureBuilder(
              future: getPhoto(),
                builder: (context, AsyncSnapshot<List<Photo>>snapshot){

                  return ListView.builder(
                      itemCount: photosList.length,
                      itemBuilder: (context,index){
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                      ),
                      subtitle: Text(snapshot.data![index].id.toString()),
                      title:Text(snapshot.data![index].title.toString()),
                    );
                  });
                }),
          )

        ],
      ),
    );
  }
}

class Photo{

  String title , url;
  int id;

  Photo({required this.title,required this.url,required this.id});


}
