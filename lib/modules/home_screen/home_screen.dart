import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/modules/tabs/settings/settings_tab.dart';
import 'package:todo_application/modules/tabs/tasks/tasks_tab.dart';
import 'package:todo_application/shared/reusable_components/custom_scaffold_bg.dart';
import 'package:todo_application/shared/reusable_components/show_bottom_sheet_form.dart';
import 'package:todo_application/shared/utils/app_assets.dart';
import 'package:todo_application/shared/reusable_components/task_provider.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName ='homeScreen';

   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0 ;
  List<Widget> tabsList = [
    const TasksTab(),
    const SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldBg(
      appBar: AppBar(
        title: Text(
          'ToDo List',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: tabsList[currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape:const CircularNotchedRectangle(),
        notchMargin: 10.0,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            currentIndex = value ;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  AppAssets.listIcon,
                ),
              ),
              label: 'list',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  AppAssets.settingsIcon,
                ),
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:Provider.of<TaskProvider>(context).selectedDate.isBefore(DateTime.now().subtract(const Duration(days: 1))) ? null :()
      {
        showModalBottomSheet(context: context, builder: (context) => const ShowBottomSheetForm(),);
      } ,
        backgroundColor: Provider.of<TaskProvider>(context).selectedDate.isBefore(DateTime.now().subtract(const Duration(days: 1))) ? Colors.grey : null ,
        child:const Icon(
          Icons.add,
          size: 30.0,
        ),
      ),
      floatingActionButtonLocation:  FloatingActionButtonLocation.centerDocked,
    );
  }
}
