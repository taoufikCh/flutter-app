import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthentificationPage extends StatelessWidget {

  TextEditingController txt_login = new TextEditingController();
  TextEditingController txt_password = new TextEditingController();
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page Authentification"),),
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
                _onAuthentifier(context);
              },
              child: Text('Connexion', style: TextStyle(fontSize: 22),),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.lightBlueAccent,
              ) ,
            ),
          ),
          TextButton(onPressed: (){
            Navigator.pop(context);
            Navigator.pushNamed(context, '/inscription');
          },
              child: Text("Nouvel utilisateur",
                style: TextStyle(fontSize: 22,
                    //color: Colors.cyan,
                ),
              )
          )
        ],
      ),
    );
  }
  Future<void> _onAuthentifier(BuildContext context) async {
    /*prefs = await SharedPreferences.getInstance();
    String log = prefs.getString("login") ?? " ";
    String pwd = prefs.getString("password") ?? " ";
    print(txt_password.text);
    if(!txt_login.text.isEmpty && !txt_password.text.isEmpty) {
      if (txt_login.text == log && txt_password.text == pwd) {
        prefs.setBool("connecte", true);
        Navigator.pop(context);
        Navigator.pushNamed(context, '/home');
      }
      else {
        const snackBar = SnackBar( content: Text("Nom d'utilisateur ou/et mot de passe incorrect(s)"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    else {
      const snackBar = SnackBar( content: Text("Champ(s) vide(s)"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }*/
    SnackBar snackBar = SnackBar(content: Text(""));
    if(!txt_login.text.isEmpty && !txt_password.text.isEmpty){
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: txt_login.text.trim(),
          password: txt_password.text.trim(),
        );
        Navigator.pop(context);
        Navigator.pushNamed(context, '/home');
      } on FirebaseAuthException catch (e) {

        if (e.code =='user-not-found') {
          snackBar = SnackBar(content: Text("Utilisateur inexistant"));
        } else if (e.code == 'wrong-password') {
          snackBar = SnackBar(content: Text("Vérifier votre mot de passe"));
        }

      }
      catch (e) {
        print(e);
      }
    }
    else{
      snackBar = SnackBar(content: Text("Champ(s) vide(s)"));

    }
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
}
