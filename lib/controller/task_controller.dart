import 'package:get/get.dart';
import 'package:purchase_order/model/task_model.dart';
import 'package:purchase_order/view/pages/detail.dart';
import 'package:purchase_order/view/pages/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskController extends GetxController {
  late SharedPreferences prefs;
  Rx<bool> reproving = false.obs;
  Rx<bool> isAllChecked = false.obs;
  List<TaskModel> taskList = <TaskModel>[].obs;
  List<bool> checkList = <bool>[].obs;
  List<String> forAproval = <String>[].obs;

  Rx<bool> loading = false.obs;

  @override
  onInit() async {
    prefs = await SharedPreferences.getInstance();
    getTasks();
    super.onInit();
  }

//PEGA AS APROVAÇÕES

  getTasks() {}

//NAVEGAÇÕES

  toTaskList(String title,int i) {
    Get.to(() => TaskListPage(
          title: title,
          i: i,
        ));
  }

  toDetail(int i ,int index) {
    Get.to(() => TaskDetail(i: i,index: index));
  }
}
