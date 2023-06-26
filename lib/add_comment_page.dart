import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;


class AddCommentPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_AddCommentPageState();

}

class _AddCommentPageState extends State<AddCommentPage>{

  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Add Comment'),
       centerTitle: true,
     ),
     body: Column(
       children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: TextField(
             controller: commentController,
             decoration: InputDecoration(
               labelText: 'Comment',
               enabledBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(21)
               ),
               focusedBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(21)
               )
             ),

           ),
         ),
         SizedBox(height: 16,),
         ElevatedButton(onPressed: (){
           print(commentController.text.toString());
           addComment();
         },
         child: Text('Add Comment'))

       ],
     ),
   );
  }
  void addComment() async{
    try {
      final url = Uri.parse('https://jsonplaceholder.typicode.com/photos');
      final body = jsonEncode({
        'id': 1,
        'title': commentController.text.toString(),
        'thumbnailUrl':
        'https://www.google.com/s2/favicons?sz=64&domain_url=yahoo.com',
        'url': 'https://yahoo.com',
      });
      final header = {'Content-type': 'application/json; charset=UTF-8'};
      final response = await http.post(
        url,
        body: body,
        headers: header,
      );

      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        print(jsonData);
      } else {
        print('Error:${response.statusCode}');
      }
    }catch(e){
      print('Error occurred:$e');
    }
  }
}