import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class MeteoDetailsPage extends StatefulWidget {
  String ville = "";
  MeteoDetailsPage(this.ville);

  @override
  State<MeteoDetailsPage> createState() => _MeteoDetailsPageState();
}


class _MeteoDetailsPageState extends State<MeteoDetailsPage> {

  var meteoData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMeteoData(widget.ville);
  }


  void getMeteoData(String ville){
    print("Méteo de la ville de "+ville);
    String url = "https://api.openweathermap.org/data/2.5/forecast?q=${ville}&appid=a1ba705f96a8bce9fd3970ab8e7e05fe";
    http.get(Uri.parse(url)).then((resp){
      setState(() {
        this.meteoData = json.decode(resp.body);
        print(this.meteoData);
      });
    }).catchError((err){
      print(err);
    });
  }

  String cardinalDirection(double degree){
    if (degree > 337.5 || degree <= 22.5) {
      return "N";
    } else if (degree > 22.5 && degree <= 67.5) {
      return "NE";
    } else if (degree > 67.5 && degree <= 112.5) {
      return "E";
    } else if (degree > 112.5 && degree <= 157.5) {
      return "SE";
    } else if (degree > 157.5 && degree <= 202.5) {
      return "S";
    } else if (degree > 202.5 && degree <= 247.5) {
      return "SW";
    } else if (degree > 247.5 && degree <= 292.5) {
      return "W";
    } else if (degree > 292.5 && degree <= 337.5) {
      return "NW";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Méteo Détails ${widget.ville}'),),
      body: meteoData == null ? Center(
        child: CircularProgressIndicator(),
      ):
      ListView.builder(
        itemCount :(meteoData==null ? 0: meteoData['list'].length),
        itemBuilder: (context, index){
          return Card(
            //color: Colors.blue,
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.transparent])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          "images/${meteoData['list'][index]['weather'][0]['main'].toString().toLowerCase()}.png"
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${new DateFormat('E-dd/MM/yyyy').format(
                              DateTime.fromMicrosecondsSinceEpoch(
                                meteoData['list'][index]['dt']*1000000)
                            )}",
                            style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${new DateFormat('HH:mm').format(
                                  DateTime.fromMicrosecondsSinceEpoch(
                                    meteoData['list'][index]['dt']*1000000)
                                  )}"
                                  "| ${meteoData['list'][index]['weather'][0]['main']}",
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${(meteoData['list'][index]['main']['temp'] - 273.15).round()} °C",
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${(meteoData['list'][index]['wind']['speed']*3.6).round()} Km/h "+cardinalDirection((meteoData['list'][index]['wind']['deg']).toDouble()) ,
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
