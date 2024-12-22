
import 'package:get/get.dart';
import 'package:purchase_order/view/pages/reason.dart';

getReason({bool isDetail = false}) {
  Get.bottomSheet(
    
    Reason(
      isDetail: isDetail,
    ),
    isScrollControlled: true,
  );
}
