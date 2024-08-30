import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:future_task_management_app/database_manager/model/task.dart';
import 'package:future_task_management_app/database_manager/tasks_dao.dart';
import 'package:future_task_management_app/providers/app_auth_provider.dart';
// import 'package:future_task_management_app/ui/home/edit_task_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../home/tabs/EditTaskBottomSheet.dart';

class TaskItemWidget extends StatefulWidget {
  Task task;

  TaskItemWidget({required this.task});

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AppAuthProvider>(context);
    return Slidable(
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {
              TasksDao.delete(
                  authProvider.firebaseAuthUser!.uid, widget.task.taskId!);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {
              editTaskBottomSheet(widget.task.taskId!);
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: Card(
        color: Theme
            .of(context)
            .colorScheme
            .outline,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 4.w,
                height: 62.h,
                decoration: BoxDecoration(
                    color: widget.task.isDone!
                        ? Colors.green
                        : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.r)),
              ),
              SizedBox(
                width: 25.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.task.title!, style: TextStyle(color: Theme
                        .of(context)
                        .primaryColor)),
                    Text(widget.task.description!,style: TextStyle(color: Theme
                        .of(context)
                        .colorScheme
                        .tertiary),)
                  ],
                ),
              ),
          !( widget.task.isDone!) ?
          Container(
              padding:
              EdgeInsets.symmetric(horizontal: 21.w, vertical: 7.h),
              decoration: BoxDecoration(
                  color: widget.task.isDone!
                      ? Colors.green
                      : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10.r)),
              child: InkWell(
                  onTap: () {
                    TasksDao.taskDone(
                        authProvider.firebaseAuthUser!.uid, widget.task);
                    setState(() {});
                  },
                  child:
                  Icon(Icons.check, size: 24.sp, color: Colors.white))):Text('Done!', style: TextStyle(color: Colors.green, fontSize: 24.sp)
          )
            ],
          ),
        ),
      ),
    );
  }

  void editTaskBottomSheet(String taskId) {
    showModalBottomSheet(
      context: context,
      builder: (context) => EditTaskBottomSheet(task: taskId),
    );
  }
}