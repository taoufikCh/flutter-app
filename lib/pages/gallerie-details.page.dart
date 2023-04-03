import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GallerieDetailsPage extends StatefulWidget {
  String keyword = "";
  GallerieDetailsPage(this.keyword);

  @override
  State<GallerieDetailsPage> createState() => _GallerieDetailsPageState();
}

class _GallerieDetailsPageState extends State<GallerieDetailsPage> {
  int currentPage = 1;
  int size = 10;
  late num totalPages = 100;
  ScrollController _scrollController = new ScrollController();
  List<dynamic> hits = [];
  var galleryData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGalleryData(widget.keyword);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          currentPage++;
          getGalleryData(widget.keyword);
        }
      }
    });
  }

  void getGalleryData(String keyword) {
    print("Gallery de " + keyword);
    String url = "https://pixabay.com/api/?key=33244997-daf3c4eda55889335bdc6fab5&q=${keyword}&page=${currentPage}&per_page=${size}";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.galleryData = json.decode(resp.body);
        hits.addAll(galleryData['hits']);
        totalPages = (galleryData['totalHits'] / size).ceil();
        print(hits);
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: totalPages == 0 ? Text('pas de résultats') :
      Text('${widget.keyword}, Page ${currentPage}/${totalPages}'),),
      body: galleryData == null ? Center(
        child: CircularProgressIndicator(),
      ) :
      ListView.builder(
        itemCount: (galleryData == null ? 0 : hits.length),
        controller: _scrollController,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 10, right: 10),
                child:
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(hits[index]['tags'],
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  color: Colors.blue,
                ),
              ),
              Container(
                child: Card(
                  child: Image.network(hits[index]['webformatURL'],
                    fit: BoxFit.fitWidth,),
                ),
                padding: EdgeInsets.only(left: 10, right: 10),
              )

            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
}
