import 'dart:convert';
import 'package:assesment/Trending_series.dart';
import 'package:assesment/style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'TV_popular_class.dart';
import 'Top_Series_class.dart';
import 'movies.dart';

class TvSeries extends StatefulWidget {
  const TvSeries({super.key});

  @override
  State<TvSeries> createState() => _TvSeriesState();
}

Future<TvPopular> fetchTrendingSeries() async {
  var resp = await http.get(Uri.parse("https://api.themoviedb.org/3/tv/popular?api_key=ea80466bd55e4f4e143564b39696b4bd"));
  if (resp.statusCode == 200) {
    var data = jsonDecode(resp.body);
    return TvPopular.fromJson(data);
  } else {
    throw Exception('Failed to load popularTV shows');
  }
}

Future<TopSeries> fetchTopSeries() async {
  var resp = await http.get(Uri.parse("https://api.themoviedb.org/3/tv/top_rated?api_key=ea80466bd55e4f4e143564b39696b4bd"));
  if (resp.statusCode == 200) {
    var data = jsonDecode(resp.body);
    return TopSeries.fromJson(data);
  } else {
    throw Exception('Failed to load topTV shows');
  }
}

Future<TopSeries> fetchTodaySeries() async {
  var resp = await http.get(Uri.parse("https://api.themoviedb.org/3/tv/airing_today?api_key=ea80466bd55e4f4e143564b39696b4bd"));
  if (resp.statusCode == 200) {
    var data = jsonDecode(resp.body);
    return TopSeries.fromJson(data);
  } else {
    throw Exception('Failed to load todayTV shows');
  }
}

Future<TopSeries> fetchairSeries() async {
  var resp = await http.get(Uri.parse("https://api.themoviedb.org/3/tv/on_the_air?api_key=ea80466bd55e4f4e143564b39696b4bd"));
  if (resp.statusCode == 200) {
    var data = jsonDecode(resp.body);
    return TopSeries.fromJson(data);
  } else {
    throw Exception('Failed to load airTV shows');
  }
}

Future<List<dynamic>> fetchTVData() async {
  final results = await Future.wait([fetchTrendingSeries(),fetchTopSeries(),fetchTodaySeries(),fetchairSeries()]);
  return results;
}



class _TvSeriesState extends State<TvSeries> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu,color: Colors.black,),
          title:
          Text("Television Series",
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 22),
              child: Icon(Icons.search_rounded,size: 25,color: Colors.black,),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 31,right: 31 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Trending Now", style: heading),
                    InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> TrendingSeries()));
                        },
                        child: Text("See all >>",style: seeall,)),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              FutureBuilder<List<dynamic>>(
                future: fetchTVData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (snapshot.hasData) {
                    final populartv = snapshot.data![0] as TvPopular;
                    final toptv = snapshot.data![1] as TopSeries;
                    final todaytv = snapshot.data![2] as TopSeries;
                    final tvair = snapshot.data![3] as TopSeries;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Container(
                            color: Colors.blueGrey.shade100.withOpacity(0.5),
                            height: 215,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 7,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        'https://image.tmdb.org/t/p/w500${populartv.results[index].posterPath}',
                                        height: 200,
                                        width: 150,
                                        fit: BoxFit.fill,
                                      ),
                                      // Wrap the Text widget with Expanded
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.only(left: 31,right: 31,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Top rated",style: heading,),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Container(
                            color: Colors.blueGrey.shade100.withOpacity(0.5),
                            height: 215,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 7,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        'https://image.tmdb.org/t/p/w500${toptv.results[index].posterPath}',
                                        height: 200,
                                        width: 150,
                                        fit: BoxFit.fill,
                                      ),
                                      // Wrap the Text widget with Expanded
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 31,top: 15),
                          child: Text("Arriving Today",style: heading,),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Container(
                            color: Colors.blueGrey.shade100.withOpacity(0.5),
                            height: 215,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        todaytv.results[index].posterPath.isNotEmpty ? 'https://image.tmdb.org/t/p/w500${todaytv.results[index].posterPath}' : 'https://image.tmdb.org/t/p/w500${todaytv.results[index].backdropPath}',

                                        height: 200,
                                        width: 150,
                                        fit: BoxFit.fill,
                                      ),
                                      // Wrap the Text widget with Expanded
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 31),
                          child: Text("On the Air",style: heading,),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Container(
                            color: Colors.blueGrey.shade100.withOpacity(0.5),
                            height: 215,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: todaytv.results.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        tvair.results[index].posterPath.isNotEmpty ? 'https://image.tmdb.org/t/p/w500${tvair.results[index].posterPath}' : 'https://image.tmdb.org/t/p/w500${tvair.results[index].backdropPath}',
                                        height: 200,
                                        width: 150,
                                        fit: BoxFit.fill,
                                      ),
                                      // Wrap the Text widget with Expanded
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Text("No data");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
