// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quizapp/pages/NavDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState(){
    return _profilePageState();
  }


}

class _profilePageState extends State<ProfilePage>{

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();

String userName = '';
String email = '';

initState(){
 getData();
}

getData() async{
 SharedPreferences pref = await SharedPreferences.getInstance();
 setState ( (){
   userName = pref.getString('userName')?? '';
 });
}

saveProfileData() async{
  setState((){
    userName = nameController.text;
    email = emailController.text;
  });
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('userName', userName);
  pref.setString('email', email);
}
  
@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text('Profile'),

    ),
    drawer: NavDrawer(),
    body: Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 450,
      color: Colors.lime,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          displayName(),
          displayEmail(),
          getSaveButton(),
          Text(userName)
        ]    
        )
  )
  );

  }

  Widget displayName(){
    return TextField(
      controller: nameController,
      decoration: getInputDecoration(hintText: 'User Name'),
    );
  }

    Widget displayEmail(){
    return TextField(
      controller: emailController,
      decoration: getInputDecoration(hintText: 'Email'),
    );
  }

  Widget getSaveButton(){
    return Container(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          onPrimary: Colors.white
        ),
        child: Text('Save'),
        onPressed: saveProfileData,)
    );
  }

  InputDecoration getInputDecoration({@required hintText}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(
    letterSpacing: 2,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    ),
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10.0),
    ),
    );
  }
}