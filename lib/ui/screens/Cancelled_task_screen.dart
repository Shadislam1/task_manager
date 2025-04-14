
import 'package:flutter/material.dart';


import '../widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(


        itemCount: 6,
        separatorBuilder: (context,index)=>const SizedBox(height: 8,),
        itemBuilder: (context, index) {
          return  TaskCard(taskStatus: TaskStatus.canceled,);
        },),

    );
  }




}


