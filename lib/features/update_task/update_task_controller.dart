import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/mixins/snack_bar_mixins.dart';
import 'package:taskmanager/utils/route/route_name.dart';

class UpDateTaskController extends GetxController with SnackbarMixin {
  var formatedDate = "Anytime".obs;
  var upnameController = TextEditingController();
  var updescriptionController = TextEditingController();
  final _taskBox = Hive.box('task_box');

  Future<void> updateItem(
      {required int itemKey,
      required String name,
      required String description,
      required String dueDate}) async {
    final Map<String, dynamic> item = {
      'title': name,
      'description': description,
      'dueDate': dueDate,
      'iscompleted': true,
    };

    await _taskBox.put(itemKey, item);
    Get.offNamed(AppRoute.landing);

    update();
  }

  void dateFormat(DateTime? pickedDate) {
    if (pickedDate != null) {
      formatedDate.value = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
    update();
  }
}
