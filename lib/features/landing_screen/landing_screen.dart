import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/features/add_new_task/add_new_task.dart';
import 'package:taskmanager/features/landing_screen/landing_screen_controller.dart';
import 'package:taskmanager/features/task/task_screen.dart';
import 'package:taskmanager/utils/color/colors.dart';

class LandingScreen extends StatelessWidget {
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  LandingScreen({super.key});

  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: SizedBox(
          height: 72,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            enableFeedback: true,
            type: BottomNavigationBarType.fixed,
            onTap: landingPageController.changeTabIndex,
            elevation: 0,
            currentIndex: landingPageController.tabIndex.value,
            backgroundColor: AppColors.bottomNavColor,
            unselectedItemColor: Colors.white.withOpacity(0.2),
            selectedItemColor: Colors.white,
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                    margin: const EdgeInsets.only(bottom: 7),
                    child: Icon(Icons.task_alt,
                        size: 30,
                        color: landingPageController.tabIndex.value == 0
                            ? AppColors.white
                            : AppColors.grey)),
                label: 'My Task',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                  size: 1,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                    margin: const EdgeInsets.only(bottom: 7),
                    child: Icon(Icons.list_alt,
                        size: 30,
                        color: landingPageController.tabIndex.value == 0
                            ? Colors.white
                            : Colors.grey)),
                label: 'view all',
              ),
            ],
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    final LandingController landingPageController =
        Get.put(LandingController(), permanent: false);

    return SafeArea(
        child: Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          isExtended: true,
          elevation: 20,
          child: const Icon(Icons.add),
          backgroundColor: Colors.pink,
          onPressed: () {
            print("clicked");
            showDialog(
              context: context,
              builder: (BuildContext context) => const AddNewTask(),
            );
          }),
      bottomNavigationBar:
          buildBottomNavigationMenu(context, landingPageController),
      body: Obx(() => IndexedStack(
            index: landingPageController.tabIndex.value,
            children: [
              TaskScreen(),
              Container(),
              Container(),
            ],
          )),
    ));
  }
}
