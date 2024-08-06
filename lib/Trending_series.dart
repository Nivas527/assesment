import 'dart:convert';

import 'package:assesment/TV_popular_class.dart';
import 'package:assesment/Trending_series_individual.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'Bottom_navigation.dart';

class TrendingSeries extends StatefulWidget {
  const TrendingSeries({super.key});

  @override
  State<TrendingSeries> createState() => _TrendingSeriesState();
}

class _TrendingSeriesState extends State<TrendingSeries> {

  Future<TvPopular> fetchTrending()async {
    var resp = await http.get(Uri.parse("https://api.themoviedb.org/3/tv/popular?api_key=ea80466bd55e4f4e143564b39696b4bd"));
    var data = jsonDecode(resp.body);
    return TvPopular.fromJson(data);
  }

  Future<void> handlerefresh() async {
    return await Future.delayed(const Duration(seconds: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavigation()));
            },
            child: Icon(Icons.arrow_back_rounded,color: Colors.black,)),
        title:
        Text("Trending Series",
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: handlerefresh,
        backgroundColor: Colors.grey.shade400,
        color: Colors.grey.shade800,
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: fetchTrending(),
                  builder: (context, snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(
                          child: CircularProgressIndicator()
                      );
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
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> TrendingSeriesIndividual(out: toprated.results[index])));
                                  },
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
                                              Text(toprated.results[index].originalName.toString(),
                                                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black),
                                                overflow: TextOverflow.visible,
                                                maxLines: 2,
                                              ),
                                              Text("Rating : (${toprated.results[index].voteAverage.round().toString()}/10)",
                                                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black
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
      ),
    );
  }
}
