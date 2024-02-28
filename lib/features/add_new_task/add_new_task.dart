import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taskmanager/features/add_new_task/add_new_task_controller.dart';
import 'package:taskmanager/utils/color/colors.dart';
import 'package:taskmanager/widgets/custom_app_bar.dart';
import 'package:taskmanager/widgets/custom_button.dart';
import 'package:taskmanager/widgets/custom_text.dart';

class AddNewTask extends StatelessWidget {
  const AddNewTask({super.key});

  @override
  Widget build(BuildContext context) {
    final AddNewTaskController controller = Get.put(AddNewTaskController());

    return Scaffold(
        appBar: CustomAppBar(
            leading: GestureDetector(
                onTap: () => Get.back(closeOverlays: true),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 30,
                  color: AppColors.grey,
                )),
            title: CustomText(
              "Add New Task",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontheight: 1.8,
              color: AppColors.black,
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
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
                    controller: controller.nameController,
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
                    controller: controller.descriptionController,
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
                              // DateTime(
                              //     2000), //DateTime.now() - not to allow to choose before today.
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
                              // groupTMR (0:1321)
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
                  text: "Add New Task",
                  color: AppColors.primaryPink,
                  textColor: AppColors.white,
                  onPressed: () {
                    // controller.clearDb();

                    if (controller.nameController.text.isNotEmpty) {
                      controller.createItem(
                          name: controller.nameController.text,
                          description: controller.descriptionController.text,
                          dueDate: controller.formatedDate.value);
                      Get.back();
                    } else {
                      const GetSnackBar(
                        title: "Error",
                        message: "title required",
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
