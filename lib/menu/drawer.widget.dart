import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/global.params.dart';

class MyDrawer extends StatelessWidget {
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:ListView(
        children: [
          DrawerHeader(decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.white, Colors.blue])),
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("images/img.png"),
                radius: 80,
              ),
            ),
          ),
          //Parcourir les différents éléments du menu
          ...(GlobalParams.menus as List).map((item){
              Divider(height: 4,color: Colors.blue,);
              return ListTile(
              title: Text(
                '${item['title']}',style: TextStyle(fontSize: 22),),
              leading: item['icon'],
              trailing: Icon(Icons.arrow_right, color: Colors.blue,),
              onTap: (){
               if('${item['title']}'!="Déconnexion"){
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '${item['route']}');
                }
               else
                  _Deconnexion(context);

              },
            );
         }
          )
          ],
      ),
    );
  }
  Future<void> _Deconnexion(BuildContext context) async{
    //prefs = await SharedPreferences.getInstance();
    //prefs.setBool("connecte", false);
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil('/authentification', (Route<dynamic> route) => false);
  }
}