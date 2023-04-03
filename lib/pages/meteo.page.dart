import 'package:flutter/material.dart';
import 'package:voyage/menu/drawer.widget.dart';
import 'meteo-details.page.dart';

class MeteoPage extends StatelessWidget {
  TextEditingController txt_ville = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Page Météo"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: txt_ville,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_city),
                  hintText: "Ville",
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
                _onGetMeteoDetails(context);
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
 void _onGetMeteoDetails(BuildContext context){
    String v = txt_ville.text;
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MeteoDetailsPage(v)));
    txt_ville.text="";
 }
}
