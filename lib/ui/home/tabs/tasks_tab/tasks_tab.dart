import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_task_management_app/database_manager/tasks_dao.dart';
import 'package:future_task_management_app/providers/app_auth_provider.dart';
import 'package:future_task_management_app/ui/widgets/tasks_item_widget.dart';
import 'package:provider/provider.dart';

class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AppAuthProvider>(context, listen: true);
    return Column(
      children: [
        CalendarTimeline(
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            selectedDate = date;
            print(selectedDate.toString());
            setState(() {});
          },
          leftMargin: 20,
          monthColor: Colors.blueGrey,
          dayColor: Colors.black,
          activeDayColor: Theme.of(context).primaryColor,
          activeBackgroundDayColor: Colors.white,
          fontSize: 22.sp,
          shrink: true,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        StreamBuilder(
          stream: TasksDao.getDataRealTime(
              authProvider.firebaseAuthUser!.uid, selectedDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [Text(snapshot.error.toString())],
              );
            } else {
              return Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) => TaskItemWidget(
                  task: snapshot.data![index],
                ),
                itemCount: snapshot.data!.length,
              ));
            }
          },
        )
      ],
    );
  }
}
