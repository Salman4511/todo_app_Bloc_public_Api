import 'package:flutter/material.dart';
import 'package:todo/core/constraints.dart';
import 'package:todo/models/model.dart';

class ScreenViewPost extends StatelessWidget {
  final TodoModel post;

  const ScreenViewPost({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Todo'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            post.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            post.description,
            style: const TextStyle(fontSize: 16),
          ),
          
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); 
          },
          child: Container(height: 30,width: 70,
            color:themeprimary ,
            child:const Center(child:  Text('Close',style: subtitlestyle,))),
        ),
      ],
    );
  }
}
