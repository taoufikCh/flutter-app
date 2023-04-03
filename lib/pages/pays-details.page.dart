import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class PaysDetailsPage extends StatefulWidget {
  String pays = "";
  PaysDetailsPage(this.pays);

  @override
  State<PaysDetailsPage> createState() => _PaysDetailsPageState();
}

class _PaysDetailsPageState extends State<PaysDetailsPage> {

  var paysData;
  @override
  void initState() {
    super.initState();
    getPaysData(widget.pays);
  }

  void getPaysData(String pays){
    print("Information sur la pays "+pays);
    String url = "https://restcountries.com/v2/name/${pays}";
    http.get(Uri.parse(url)).then((resp){
      setState(() {
        this.paysData = json.decode(utf8.decode(resp.bodyBytes));
        print(this.paysData);
      });
    }).catchError((err){
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar :AppBar(title: Text('Page pays Détails ${widget.pays}'),),
      body: paysData == null ? Center(
        child: CircularProgressIndicator(

        ),
      ):
      Container(
        padding: EdgeInsets.only(left: 10),
        child :Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Image.network(paysData[0]['flags']['png'],
                  fit: BoxFit.fitWidth,),
              ),
            ),
            Container(

              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("${paysData[0]['name']}",style: TextStyle( fontSize: 22, fontWeight: FontWeight.bold,),),
                    SizedBox(height: 10,),
                    Text("${paysData[0]['nativeName']}",style: TextStyle( fontSize: 22, fontWeight: FontWeight.bold),),
                  ]
              ),
            ),
            SizedBox(height: 10,),
            Container(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Administration ",style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold,color: Colors.blue),),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text("Capitale :",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold,)),
                          Text("${paysData[0]['capital']}",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold,),),
                          ]
                      ),
                      SizedBox(height: 10,),
                      Row(
                          children: [
                            Text("Language(s) :",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold,)),
                            Text("${paysData[0]['languages'][0]['name']},${paysData[0]['languages'][0]['nativeName']}",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold,),),
                          ]
                      ),
                    ],
                )
            ),
            SizedBox(height: 20,),
            Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Geographie ",style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold,color: Colors.blue),),
                    SizedBox(height: 10,),
                    Row(
                        children: [
                          Text("Région : ",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold,)),
                          Text("${paysData[0]['region']}",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold,),),
                        ]
                    ),
                    SizedBox(height: 10,),
                    Row(
                        children: [
                          Text("Superficie : ",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold,)),
                          Text("${paysData[0]['area']}",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold,),),
                        ]
                    ),
                    SizedBox(height: 10,),
                    Row(
                        children: [
                          Text("Fuseau Horaire : ",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold,)),
                          Text("${paysData[0]['timezones'][0]}",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold,),),
                        ]
                    )
                  ],
                )
            ),
            SizedBox(height: 20,),
            Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Démographie ",style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold,color: Colors.blue),),
                    SizedBox(height: 10,),
                    Row(
                        children: [
                          Text("population : ",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold,)),
                          Text("${paysData[0]['population']}",style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold,),),
                        ]
                    ),

                  ],
                )
            ),
          ],
        ),
      )


    );
  }
}
