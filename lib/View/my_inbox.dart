import 'package:emp/AdditionalClass/CustomAnimation.dart';
import 'package:emp/AdditionalClass/SqfLiteHelper.dart';
import 'package:emp/Controller/mail_management_controller.dart';
import 'package:emp/Model/InboxModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:sqflite/sqlite_api.dart';

class MyInbox extends StatefulWidget {
  const MyInbox({Key? key}) : super(key: key);

  @override
  _MyInboxState createState() => _MyInboxState();
}

class _MyInboxState extends State<MyInbox> with SingleTickerProviderStateMixin {

  MailMamagementController controller = Get.put(MailMamagementController());

  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  initState(){
    controller.getData();
    CustomAnimation().initAnim(activity: this,begin: 0,end: 1,isReverse: false,millisecond: 1000);
    if(mounted){
      CustomAnimation.animCartController!.forward();
    }
    updateDataWithSqflite(InboxModel.inboxList);
    super.initState();
  }


  void updateDataWithSqflite(List<InboxModel> inboxList){

    for(int i = 0;i<inboxList.length;i++){
      databaseHelper.insert(inboxList[i]).then((value){
        print("$value");
      });
    }

  }

  @override
  dispose(){
    CustomAnimation().disposeAnim();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inbox')),
      body: ListView.builder(
        itemCount: controller.inboxList.length,
        itemBuilder: (context,position){
          return AnimatedBuilder(
              animation: CustomAnimation.animCartController!,
              builder: (context,child) {
                return Opacity(
                  opacity: CustomAnimation.animCard!.value,
                  child: InkWell(
                    onTap: (){

                    },
                    child: Container(
                        height: 80,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  flex: 15,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.grey[200],
                                          radius: 18,
                                          child: Text(controller.inboxList[position].title[0],style: TextStyle(fontSize: 18,color: Colors.grey,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                                        ),
                                        Icon(Icons.more_vert,color: Colors.grey[500],size: 18),
                                        SizedBox(height: 4),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 80,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${controller.inboxList[position].email}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[600],fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis),
                                          Text('${controller.inboxList[position].title}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[900]),maxLines: 1,overflow: TextOverflow.ellipsis),
                                          Text('${controller.inboxList[position].details}',style: TextStyle(color: Colors.grey[600],fontSize: 12),maxLines: 2,overflow: TextOverflow.ellipsis),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Flexible(
                                  flex: 5,
                                  child: Icon(Icons.attachment,color: Colors.grey),
                                ),
                                SizedBox(width: 8),
                              ],
                            ),
                            Divider(height: 0),
                          ],
                        )
                    ),
                  ),
                );
              }
          );
        },
      ),
      drawer: Drawer(),
    );
  }
}
