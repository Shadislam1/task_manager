
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_status_count_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

import '../../data/models/task_status_count_list_model.dart';
import '../../data/utils/urls.dart';
import '../widgets/summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];

  @override
  void initState() {
    _getAllTaskStatusCount();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSummarySection(),
           ListView.separated(
             primary: false,
             shrinkWrap: true,
             itemCount: 6,
               
             itemBuilder: (context, index) {
               return  TaskCard(taskStatus:TaskStatus.sNew);
             },
             separatorBuilder: (context,index)=>const SizedBox(height: 8,),
           )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _onTapAddNewTask,child: Icon(Icons.add),),
    );
  }
  void _onTapAddNewTask(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> AddNewTaskScreen()));
  }
//passing enum when use snew task on return card
  Card TaskCard({required Enum taskStatus}) {
    return Card(
          elevation: 0,
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Padding(

            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title will be here',style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),),
                Text('Description  will be here'),
                Text('Date: 12/23/25'),
                Row(
                  children: [

                    Chip(label: Text('New',style: TextStyle(
                      color: Colors.white,),),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      backgroundColor: Colors.blue,
                      side: BorderSide.none,
                    ),
                   const Spacer(),
                    IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                  ],
                ),

              ],
            ),
          ),
        );
  }

  Widget _buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: ListView.builder(

          scrollDirection: Axis.horizontal,

          itemCount: _taskStatusCountList.length,
            itemBuilder: (context, index){
            return SummaryCard(title: _taskStatusCountList[index].status, count: _taskStatusCountList[index].count);
            }
        ),
      )
      // Row(
      //   children: [
      //     SummaryCard(
      //       title: 'New',
      //       count: 12,
      //     ),
      //     SummaryCard(
      //       title: 'Progress',
      //       count: 23,
      //     ),
      //     SummaryCard(
      //       title: 'Complate',
      //       count: 3,
      //     ),
      //     SummaryCard(
      //       title: 'Cancel',
      //       count:  25,
      //     ),
      //   ],
      // ),
    );
  }
  Future<void> _getAllTaskStatusCount() async{
    _getStatusCountInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.taskStatusCountUrl);
    if(response.isSuccess){
   TaskStatusCountListModel taskStatusCountListModel = TaskStatusCountListModel.fromJson(response.data ?? {});
   _taskStatusCountList = taskStatusCountListModel.statusCountList;

    }else{
      showSnackBarMessage(context, response.errorMessage,true);
    }
    _getStatusCountInProgress = false;
    setState(() {});
  }
}


