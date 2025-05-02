
import 'package:flutter/material.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';


import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_client.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelledTaskInProgress = false;
  List<TaskModel> _canceledTaskList = [];

  @override
  void initState() {

    super.initState();
    _getAllCancelledTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getCancelledTaskInProgress == false,
        replacement: CenteredCircularProgressIndicator(),
        child: ListView.separated(


          itemCount: _canceledTaskList.length,
          separatorBuilder: (context,index)=>const SizedBox(height: 8,),
          itemBuilder: (context, index) {
            return  TaskCard(
              taskStatus: TaskStatus.canceled,
              taskModel: _canceledTaskList[index],
            );
          },),
      ),

    );
  }


  Future<void> _getAllCancelledTaskList() async{


    _getCancelledTaskInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.cancelledTaskListUrl);
    // print('Progress tasks raw data: ${response.data}');
    if(response.isSuccess){
      TaskListModel taskListModel =TaskListModel.fromJson(response.data ?? {});
      _canceledTaskList = taskListModel.taskList;

    }else{
      showSnackBarMessage(context, response.errorMessage,true);
    }
    _getCancelledTaskInProgress= false;
    setState(() {});
  }

}


