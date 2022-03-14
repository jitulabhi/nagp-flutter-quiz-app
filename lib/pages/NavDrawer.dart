// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quizapp/pages/Homepage.dart';
import 'package:quizapp/pages/ProfilePage.dart';

class NavDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration:  BoxDecoration(
              color:  Colors.blue
            ),
            child: Center(
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Expanded(
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 40
                  ),
                  flex: 2
                  ),
                  Expanded(
                  child: Text('Welcome!'),
                  flex: 2
                  )
                  ]
                  ) ,
                  )
                  ),
                  ListTile(
                    title: Text('Home'),
                    leading: Icon(Icons.home),
                    onTap:(){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: 
                        (BuildContext conext) => HomePage()
                        )
                      );
                    }
                  ),
                   ListTile(
                    title: Text('Profile'),
                    leading: Icon(Icons.account_circle),
                    onTap:(){                      
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: 
                        (BuildContext conext) => ProfilePage()
                        )
                      );
                    
                    }
                  )
        ],
      )
    );
  }
}