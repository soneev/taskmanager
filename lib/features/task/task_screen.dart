import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taskmanager/features/add_new_task/add_new_task_controller.dart';
import 'package:taskmanager/utils/color/colors.dart';
import 'package:taskmanager/utils/route/route_name.dart';
import 'package:taskmanager/widgets/custom_app_bar.dart';
import 'package:taskmanager/widgets/custom_text.dart';
import 'package:slideable/slideable.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final AddNewTaskController myController = Get.find();

    int resetSlideIndex = 0;
    return Scaffold(
        appBar: CustomAppBar(
            title: CustomText(
          "MyTask",
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontheight: 1.8,
          color: AppColors.textColor,
        )),
        body: GetBuilder<AddNewTaskController>(
            init: AddNewTaskController(),
            builder: (controller) {
              return Obx(
                () => ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
                  itemCount: controller.taskList.length,
                  itemBuilder: (context, index) {
                    var item = controller.taskList[index];

                    return Slideable(
                      resetSlide: index == resetSlideIndex ? false : true,
                      items: [
                        ActionItems(
                          icon: Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    right: BorderSide(
                                      //                   <--- right side
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 1.0,
                                    ),
                                  )),
                              child: const Padding(
                                padding: EdgeInsets.all(20),
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: AppColors.grey,
                                ),
                              )
                              //  const Icon(
                              //   Icons.thumb_up,
                              //   color: Colors.blue,
                              // ),
                              ),
                          onPress: () {
                            Get.toNamed(AppRoute.updateTask, arguments: item);
                          },
                          backgroudColor: Colors.transparent,
                        ),
                        ActionItems(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPress: () {},
                          backgroudColor: Colors.transparent,
                        ),
                      ],
                      child: Container(
                          height: 80,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          width: double.infinity,
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(3),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x7fe0e0e0),
                                offset: Offset(5, 5),
                                blurRadius: 4.5,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // controller.taskStatus.value == false
                                  //     ? CustomSvgImage(
                                  //         imageName: "Oval",
                                  //         width: 15,
                                  //         height: 15,
                                  //       )
                                  //     :
                                  controller.taskStatus.value == false
                                      ? Icon(
                                          Icons.incomplete_circle,
                                          color: AppColors.primaryViolet,
                                          size: 20,
                                        )
                                      : const Icon(
                                          Icons.check_circle,
                                          color: AppColors.primaryPink,
                                          size: 20,
                                        ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CustomText(item['title'],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontheight: 1.875,
                                      color: AppColors.textColor),
                                  const Spacer(),
                                  Container(
                                    // rectangle2NuV (0:265)
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                    width: 4,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        // color: controller.taskStatus
                                        //             .value ==
                                        //         false
                                        // ? const Color(0xff6074f9)
                                        // :

                                        color:
                                            controller.taskStatus.value == false
                                                ? AppColors.primaryViolet
                                                : AppColors.primaryPink),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: CustomTextAbhaya(item['description'],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: CustomTextAbhaya(item['dueDate'],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor),
                              ),
                            ],
                          )),
                    );
                  },
                ),
              );
            }));
  }
}
