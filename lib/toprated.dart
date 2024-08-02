import 'dart:convert';

import 'package:assesment/toprated_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Toprated extends StatefulWidget {
  const Toprated({super.key});

  @override
  State<Toprated> createState() => _TopratedState();
}

class _TopratedState extends State<Toprated> {


  Future<TopRated> fetchToprated()async {
    var resp = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/top_rated?api_key=ea80466bd55e4f4e143564b39696b4bd"));
    var data = jsonDecode(resp.body);
    return TopRated.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_rounded,color: Colors.black,),
        title: Text("Top Rated Movies",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: fetchToprated(),
                builder: (context, snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return CircularProgressIndicator();
                  }
                  else if(snapshot.hasError){
                    return Text("there is a error");
                  }
                  else if(snapshot.hasData){
                    final toprated = snapshot.data!;
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: toprated.results.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Container(
                              color: Colors.grey.shade100,
                              child: Row(
                                children: [
                                  Image.network(
                                    'https://image.tmdb.org/t/p/w500${toprated.results[index].posterPath}',
                                    height: 140,
                                    width: 140,
                                    fit: BoxFit.fill,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(toprated.results[index].originalTitle,
                                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black),
                                            overflow: TextOverflow.visible,
                                            maxLines: 2,
                                          ),
                                          Text("Rating: ${toprated.results[index].voteAverage.round().toString()}",
                                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.black
                                          ),
                                          ),
                                          Text("Language: ${toprated.results[index].originalLanguage}",
                                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.black
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  else {
                    return Text("No data");
                  }
                }
            )
          ],
        ),
      ),
    );
  }
}
