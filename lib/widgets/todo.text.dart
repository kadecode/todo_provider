import 'package:flutter/material.dart';

class TitleTodoText extends StatelessWidget {
  const TitleTodoText({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Text('todos',textAlign: TextAlign.center,style: TextStyle(fontSize: 70,color: Color.fromARGB(255, 95, 117, 240),fontWeight: FontWeight.w200),
      
    );
  }
}