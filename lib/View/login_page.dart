import 'dart:convert';

import 'package:emp/ApiConfig/ApiController.dart';
import 'package:emp/ApiConfig/ApiEndPoints.dart';
import 'package:emp/View/my_inbox.dart';
import 'package:emp/View/registration.dart';
import 'package:emp/AdditionalClass/show_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool seePassword = false;
  bool seeConfirmPassword = false;

  bool isWorking = false;

  @override
  void initState() {
    super.initState();
    if(GetStorage().read('token')!=null){
      Future.delayed(Duration.zero).then((value){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyInbox()), (Route<dynamic> route) => false);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 42),
                    child: Text('Login',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                  const SizedBox(height: 32,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 0),
                            height: 43,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.6),
                                  spreadRadius: 0,
                                  blurRadius: 7,
                                  offset: const Offset(2, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Icon(Icons.person,size: 20,color: Colors.grey[600],),
                                ),
                                Expanded(
                                  child: TextField(
                                    textAlign: TextAlign.start,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.name,
                                    autofocus: true,
                                    autocorrect: false,
                                    textInputAction: TextInputAction.done,
                                    style: const TextStyle(
                                        height: 1.1, fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
                                    decoration: const InputDecoration(
                                        hintStyle:TextStyle(height: 0.8,fontSize: 14,fontWeight: FontWeight.bold),
                                        hintText: 'User Name',
                                        border:OutlineInputBorder(
                                            borderSide: BorderSide.none
                                        ),
                                        contentPadding:EdgeInsets.symmetric(horizontal: 12)
                                    ),
                                    controller: userNameController,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(5),

                          child: Container(
                            padding: const EdgeInsets.only(bottom: 0),
                            height: 43,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.6),
                                  spreadRadius: 0,
                                  blurRadius: 7,
                                  offset: const Offset(2, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Icon(Icons.lock,size: 20,color: Colors.grey[600],),
                                ),
                                Expanded(
                                  child: TextField(
                                    obscureText: (seePassword)?false:true,
                                    textAlign: TextAlign.start,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.name,
                                    autofocus: true,
                                    autocorrect: false,
                                    textInputAction: TextInputAction.done,
                                    style: const TextStyle(
                                        height: 1.1, fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
                                    decoration: InputDecoration(
                                        suffixIcon: (seePassword)?IconButton(
                                          onPressed: (){
                                            setState(() {
                                              seePassword = false;
                                            });
                                          },
                                          icon: const Icon(Icons.remove_red_eye,color: Colors.blue),
                                        ):IconButton(
                                          onPressed: (){
                                            setState(() {
                                              seePassword = true;
                                            });
                                          },
                                          icon: const Icon(Icons.visibility_off_sharp),
                                        ),
                                        hintStyle:TextStyle(height: 0.8,fontSize: 14,fontWeight: FontWeight.bold),
                                        hintText: 'Password',
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12)
                                    ),
                                    controller: passwordController,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24,),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Row(
                      children: const [
                        Expanded(child: Divider(color: Colors.grey)),
                        SizedBox(width: 12),
                        Text('OR'),
                        SizedBox(width: 12),
                        Expanded(child: Divider(color: Colors.grey)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24,),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Registration()), (Route<dynamic> route) => false);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Create an account!',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,), ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: 40,
              color: Colors.black87,
              child: InkWell(
                onTap: (){

                  Map<String, String> body = {
                    "address" : userNameController.text,
                    "password" : passwordController.text,
                  };

                  if(userNameController.text.isNotEmpty||passwordController.text.isNotEmpty){
                    setState((){
                      isWorking = true;
                    });
                    ApiController().postRequest(endPoint: ApiEndPoints().getToken,body: body).then((value){
                      if(value.responseCode==200){
                        var response = json.decode(value.response);
                        GetStorage().write('token', "Bearer ${response['token']}");
                        GetStorage().write('id', "${response['id']}");
                        ShowToast.myToast("Successfully Login", Colors.black, 2);
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyInbox()), (Route<dynamic> route) => false);
                        setState((){
                          isWorking = false;
                        });
                      }else{
                        if (kDebugMode) {
                          print('Something is wrong');
                        }
                        ShowToast.myToast("Something is wrong", Colors.black, 2);
                        setState((){
                          isWorking = false;
                        });
                      }
                    });
                  }else{
                    if (kDebugMode) {
                      print('Something is wrong');
                    }
                    ShowToast.myToast("Something is wrong", Colors.black, 2);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.blue,
                  child: AnimatedCrossFade(
                    firstChild: const Text('Login',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                    secondChild: const SizedBox(
                      height: 35,
                      width: 35,
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                    duration: const Duration(milliseconds: 250),
                    crossFadeState: isWorking?CrossFadeState.showSecond:CrossFadeState.showFirst,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
