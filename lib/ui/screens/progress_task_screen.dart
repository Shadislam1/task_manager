
import 'package:flutter/material.dart';
import 'package:task_manager/data/utils/urls.dart';


import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_client.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTaskInProgress = false;
  List<TaskModel> _ProgressTaskList = [];

  @override
  void initState() {
    _getAllProgressTaskList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getProgressTaskInProgress ==false,
        replacement: CircularProgressIndicator(),
        child: ListView.separated(


          itemCount: _ProgressTaskList.length,
          separatorBuilder: (context,index)=>const SizedBox(height: 8,),
          itemBuilder: (context, index) {
            return  TaskCard(
              taskStatus: TaskStatus.progress,
              taskModel: _ProgressTaskList[index],
            );
          },),
      ),

    );
  }

  Future<void> _getAllProgressTaskList() async{


    _getProgressTaskInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.progressTaskListUrl);
    print('Progress tasks raw data: ${response.data}');
    if(response.isSuccess){
      TaskListModel taskListModel =TaskListModel.fromJson(response.data ?? {});
      _ProgressTaskList = taskListModel.taskList;

    }else{
      showSnackBarMessage(context, response.errorMessage,true);
    }
    _getProgressTaskInProgress= false;
    setState(() {});
  }


}





