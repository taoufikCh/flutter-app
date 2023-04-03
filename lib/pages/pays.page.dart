import 'package:flutter/material.dart';
import 'package:voyage/menu/drawer.widget.dart';
import 'pays-details.page.dart';

class PaysPage extends StatelessWidget {
  TextEditingController txt_pays = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Pays"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: txt_pays,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  hintText: "Pays",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1),
                  )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                _onGetPaysDetails(context);
              },
              child: Text('Chercher', style: TextStyle(fontSize: 22),),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.lightBlueAccent,
              ) ,
            ),
          ),
        ],
      ),
    );
  }
  void _onGetPaysDetails(BuildContext context){
    String v = txt_pays.text;
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PaysDetailsPage(v)));
    txt_pays.text="";
  }
}
