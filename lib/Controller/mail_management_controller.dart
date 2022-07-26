import 'package:emp/Model/InboxModel.dart';
import 'package:get/state_manager.dart';

class MailMamagementController extends GetxController{

  RxList inboxList = [].obs;

  void getData(){
    inboxList.addAll(InboxModel.inboxList);
    update();
  }
}