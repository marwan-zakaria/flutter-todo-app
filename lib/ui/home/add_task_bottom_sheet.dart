import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_task_management_app/core/styles/app_theme.dart';
import 'package:future_task_management_app/core/utils/dailog_utils.dart';
import 'package:future_task_management_app/database_manager/model/task.dart';
import 'package:future_task_management_app/database_manager/tasks_dao.dart';
import 'package:future_task_management_app/providers/app_auth_provider.dart';
import 'package:future_task_management_app/ui/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();
  var desController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      padding: EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextFormField(
                controller: titleController,
                label: AppLocalizations.of(context)!.task_titel,
                keyboardType: TextInputType.text,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return AppLocalizations.of(context)!.errorTitle;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 8,
              ),
              CustomTextFormField(
                controller: desController,
                label: AppLocalizations.of(context)!.descriptionTask,
                numberOfLines: 4,
                keyboardType: TextInputType.text,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return AppLocalizations.of(context)!.errorTitle;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                  showTaskDatePicker();
                },
                child: Text(
                  AppLocalizations.of(context)!.selectDate,
                  style: TextStyle(
                      fontSize: 14, color: Theme.of(context).primaryColor),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Visibility(
                visible: !validate(),
                child: Text(
                  AppLocalizations.of(context)!.errorDate,
                  style: TextStyle(fontSize: 12, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                validate()
                    ? '${finalSelectedDate?.day}/${finalSelectedDate?.month}/ ${finalSelectedDate?.year}'
                    : '',
              ),
              SizedBox(height: 12.h),
              ElevatedButton(
                  onPressed: () {
                    addTask();
                  },
                  child: Text(AppLocalizations.of(context)!.addTask))
            ],
          ),
        ),
      ),
    );
  }

  DateTime? finalSelectedDate;

  void showTaskDatePicker() async {
    DateTime? userSelectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (userSelectedDate != null) {
      finalSelectedDate = userSelectedDate;
    }
    setState(() {});
  }

  void addTask() async {
    var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    if (!validate()) return;

    // Add task to database
    Task task = Task(
        title: titleController.text,
        description: desController.text,
        dateTime: Timestamp.fromMillisecondsSinceEpoch(
            finalSelectedDate!.millisecondsSinceEpoch));
    try {
      DialogUtils.showLoadingDialog(context);

      await TasksDao.addTaskToFireStore(
          authProvider.firebaseAuthUser!.uid, task);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(
        context,
        message: AppLocalizations.of(context)!.taskAddedSuccessfully,
        posActionTitle: AppLocalizations.of(context)!.ok,
        posAction: () {
          DialogUtils.hideDialog(context);
          Navigator.pop(context);
        },
      );
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context,
          message: e.toString(), posActionTitle: AppLocalizations.of(context)!.tryAgain, posAction: () {
        TasksDao.addTaskToFireStore(authProvider.firebaseAuthUser!.uid, task);
      });
    }
  }

  bool validate() {
    bool isValid = true;
    if (formKey.currentState?.validate() == false) {
      isValid = false;
    }
    if (finalSelectedDate == null) {
      isValid = false;
    }
    return isValid;
  }
}
