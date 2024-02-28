import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taskmanager/features/add_new_task/add_new_task_controller.dart';
import 'package:taskmanager/features/update_task/update_task_controller.dart';
import 'package:taskmanager/utils/color/colors.dart';
import 'package:taskmanager/widgets/custom_app_bar.dart';
import 'package:taskmanager/widgets/custom_button.dart';
import 'package:taskmanager/widgets/custom_text.dart';

class UpdateTask extends StatelessWidget {
  const UpdateTask({super.key});

  @override
  Widget build(BuildContext context) {
    UpDateTaskController mycontroller = Get.put(UpDateTaskController());
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final taskData = arguments;
    mycontroller.upnameController.text = taskData['title'];
    mycontroller.updescriptionController.text = taskData['description'];
    mycontroller.formatedDate.value = taskData['dueDate'];

    return Scaffold(
      appBar: CustomAppBar(
          leading: GestureDetector(
              onTap: () {
                print(arguments.toString());
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 30,
                color: AppColors.grey,
              )),
          title: CustomText(
            "Upadate Task",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GetBuilder<UpDateTaskController>(
              // init: (UpDateTaskController()),
              builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextAbhaya(
                  "Title",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontheight: 1.18,
                  color: AppColors.textColor,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.greyShadowColor),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    controller: controller.upnameController,
                    decoration: const InputDecoration(
                        hintText: "Title",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none),
                  ),
                ),
                CustomTextAbhaya(
                  "Description",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontheight: 1.18,
                  color: AppColors.textColor,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.greyShadowColor),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    controller: controller.updescriptionController,
                    decoration: const InputDecoration(
                        hintText: "Description",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.greyShadowColor),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        CustomTextAbhaya('Due Date',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontheight: 1.18,
                            color: AppColors.textColor),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 0)),
                              lastDate: DateTime(2101),
                              builder: (context, child) => Theme(
                                  data: ThemeData().copyWith(
                                      colorScheme: const ColorScheme.light(
                                          primary: Colors.red,
                                          onPrimary: AppColors.primaryPink,
                                          surface: Colors.white,
                                          onSurface: Colors.black),
                                      dialogBackgroundColor: Colors.white),
                                  child: child!),
                            );
                            controller.dateFormat(pickedDate);
                          },
                          child: Obx(
                            () => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xff6074f9),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: CustomTextAbhaya(
                                  controller.formatedDate.value,
                                  textAlign: TextAlign.center,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontheight: 1.18,
                                  color: AppColors.white),
                            ),
                          ),
                        )
                      ],
                    )),
                CustomButton(
                  height: 40,
                  width: double.maxFinite,
                  text: "Upd Task",
                  color: AppColors.primaryPink,
                  textColor: AppColors.white,
                  onPressed: () {
                    controller.updateItem(
                        name: controller.upnameController.text,
                        description: controller.updescriptionController.text,
                        dueDate: controller.formatedDate.value,
                        itemKey: taskData['key']);
                    // } else {
                    //   const GetSnackBar(
                    //     title: "Error",
                    //     message: "title required",
                    //     backgroundColor: Colors.red,
                    //   );  // } else {
                    //   const GetSnackBar(
                    //     title: "Error",
                    //     message: "title required",
                    //     backgroundColor: Colors.red,
                    //   );
                  },
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
