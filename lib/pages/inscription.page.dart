import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InscriptionPage extends StatelessWidget {
  TextEditingController txt_login = new TextEditingController();
  TextEditingController txt_password = new TextEditingController();
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page Inscription"),),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: txt_login,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: "Nom d'utilisateur",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(width: 1),
                  )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              obscureText: true,
              controller: txt_password,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: "Mot de passe",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(width: 1),
                  )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                _onInscrire(context);
              },
              child: Text('Inscription', style: TextStyle(fontSize: 22),),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.lightBlueAccent,
              ) ,
            ),
          ),
          TextButton(onPressed: (){
            Navigator.pop(context);
            Navigator.pushNamed(context, '/authentification');
          },
              child: Text("J'ai déjà un compte",
                      style: TextStyle(fontSize: 22,
                          //color: Colors.cyan,
                      ),
                    )
          ),
        ],
      ),
    );
  }

  Future<void> _onInscrire(BuildContext context) async{
    //prefs = await SharedPreferences.getInstance();
    SnackBar snackBar = SnackBar(content: Text(""));
    if(!txt_login.text.isEmpty && !txt_password.text.isEmpty){
      /*prefs.setString("login", txt_login.text);
      prefs.setString("password", txt_password.text);
      prefs.setBool("connecte", true);
      Navigator.pop(context);
      Navigator.pushNamed(context, '/home');*/
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: txt_login.text.trim(),
          password: txt_password.text.trim(),
        );
        Navigator.pop(context);
        Navigator.pushNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          snackBar = SnackBar(content: Text("Mot de passe faible"));
        } else if (e.code == 'email-already-in-use') {
          snackBar = SnackBar(content: Text("Email deja existe"));
        }
      } catch (e) {
        print(e);
      }
    }
    else{
      snackBar = SnackBar(content: Text("Champ(s) vide(s)"));

    }
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
