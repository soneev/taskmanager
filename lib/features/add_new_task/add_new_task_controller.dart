import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskmanager/mixins/snack_bar_mixins.dart';
import 'package:intl/intl.dart';

class AddNewTaskController extends GetxController with SnackbarMixin {
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();

  var formatedDate = "Anytime".obs;

  final _taskBox = Hive.box('task_box');

  var taskStatus = false.obs;
  setStatus(bool value) {
    taskStatus.value = value;
    update();
  }

  void dateFormat(DateTime? pickedDate) {
    if (pickedDate != null) {
      formatedDate.value = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
    update();
  }

  void clearDb() {
    _taskBox.clear();
  }

  final RxList<Map<String, dynamic>> taskList = <Map<String, dynamic>>[].obs;

  void _refreshItems() {
    final data = _taskBox.keys.map((key) {
      final item = _taskBox.get(key);
      return {
        "key": key,
        "title": item["title"],
        "description": item['description'],
        "dueDate": item["dueDate"],
        "isCompleted": false
      };
    }).toList();
    taskList.assignAll(data.reversed.toList());
    print(taskList.toJson());
  }

  Future<void> createItem(
      {required String name,
      required String description,
      required String dueDate}) async {
    final Map<String, dynamic> newItem = {
      'title': name,
      'description': description,
      'dueDate': formatedDate.value,
      'iscompleted': false,
    };

    await _taskBox.add(newItem);
    _refreshItems();
    showcreateSnackbar(
        title: "Success", message: "new successfully task created");
    update();
  }

  Future<void> updateItem(
      {required int itemKey,
      required String name,
      required String description,
      required String dueDate}) async {
    final Map<String, dynamic> item = {
      'title': name,
      'description': description,
      'dueDate': dueDate,
      'iscompleted': false,
    };

    await _taskBox.put(itemKey, item);
    _refreshItems();
    update();
  }

  Future<void> deleteItem(int itemKey) async {
    await _taskBox.delete(itemKey);
    _refreshItems();
    showdeletSnackbar(title: "Deleted !", message: "task successfully deleted");
    update();
  }

  @override
  void onInit() {
    _refreshItems();
    super.onInit();
  }
}
