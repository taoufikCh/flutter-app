import 'package:flutter/material.dart';
import 'package:voyage/menu/drawer.widget.dart';
import 'package:firebase_database/firebase_database.dart';
import '../config/global.params.dart';

String mode="Jour";
FirebaseDatabase fire = FirebaseDatabase.instance;
DatabaseReference ref = fire.ref();

class ParametresPage extends StatefulWidget {

  @override
  State<ParametresPage> createState() => _ParametresPageState();
}

class _ParametresPageState extends State<ParametresPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Parametres"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Mode', style: Theme.of(context).textTheme.headline3,),
          Column(
            children: <Widget>[
              ListTile(
                title: const Text('Jour'),
                leading: Radio<String>(
                  value: "Jour",
                  groupValue: mode,
                  onChanged: (value){
                    setState(() {
                      mode=value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Nuit'),
                leading: Radio<String>(
                  value: "Nuit",
                  groupValue: mode,
                  onChanged: (value){
                    setState(() {
                      mode=value!;
                    });
                  },
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.lightBlueAccent,
              ) ,
              onPressed: (){
                _onSaveMode();
              },
              child: Text('Enregistrer', style: TextStyle(fontSize: 22),),
            ),
          ),
          ],
      )
    );
  }

   _onSaveMode() async{
    GlobalParams.themeActuel.setMode(mode);
    await ref.set({"mode" : mode});
    print("mode changé : "+ mode);
    Navigator.pop(context);
   }

}
