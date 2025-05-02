

//implemnet here

import 'package:flutter/material.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';


import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_client.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskInProgress = false;
  List<TaskModel> _completedTaskList = [];

  @override
  void initState() {

    super.initState();
    _getAllCompletedTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getCompletedTaskInProgress == false,
        replacement: CenteredCircularProgressIndicator(),
        child: ListView.separated(


          itemCount: _completedTaskList.length,
          separatorBuilder: (context,index)=>const SizedBox(height: 8,),
          itemBuilder: (context, index) {
             return  TaskCard(
               taskStatus: TaskStatus.completed,
               taskModel: _completedTaskList[index],
             );
          },),
      ),

    );
  }

  Future<void> _getAllCompletedTaskList() async{


    _getCompletedTaskInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.completedTaskListUrl);
   // print('Progress tasks raw data: ${response.data}');
    if(response.isSuccess){
      TaskListModel taskListModel =TaskListModel.fromJson(response.data ?? {});
      _completedTaskList = taskListModel.taskList;

    }else{
      showSnackBarMessage(context, response.errorMessage,true);
    }
    _getCompletedTaskInProgress= false;
    setState(() {});
  }
}



