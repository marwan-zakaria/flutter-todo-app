import 'package:flutter/material.dart';
import 'package:future_task_management_app/ui/home/add_task_bottom_sheet.dart';
import 'package:future_task_management_app/ui/home/tabs/settings_tab/settings_tab.dart';
import 'package:future_task_management_app/ui/home/tabs/tasks_tab/tasks_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.app_title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addTaskBottomSheet();
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (indexClicked) {
              selectedIndex = indexClicked;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                  ),
                  label: AppLocalizations.of(context)!.tasks_list_tab),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: AppLocalizations.of(context)!.settings_tab),
            ],
          ),
        ),
        body: tabs[selectedIndex]);
  }

  var tabs = [
    TasksTab(),
    SettingsTab(),
  ];

  void addTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddTaskBottomSheet(),
    );
  }
}
