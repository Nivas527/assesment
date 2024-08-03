import 'dart:convert';
import 'package:assesment/toprated.dart';
import 'package:assesment/toprated_class.dart';
import 'package:assesment/upcoming_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'movieclass.dart';
import 'trendingclass.dart';
import 'style.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Dem extends StatefulWidget {
  const Dem({super.key});

  @override
  State<Dem> createState() => _DemState();
}

class _DemState extends State<Dem> {
  Future<Movie> fetchMovies() async {
    var resp = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=ea80466bd55e4f4e143564b39696b4bd"));
    var data = jsonDecode(resp.body);
    return Movie.fromJson(data);
  }

  Future<Trending> fetchTrendingMovies() async {
    var resp = await http.get(Uri.parse("https://api.themoviedb.org/3/trending/movie/day?api_key=ea80466bd55e4f4e143564b39696b4bd"));
    var data = jsonDecode(resp.body);
    return Trending.fromJson(data);
  }

  Future<TopRated> fetchToprated()async {
    var resp = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/top_rated?api_key=ea80466bd55e4f4e143564b39696b4bd"));
    var data = jsonDecode(resp.body);
    return TopRated.fromJson(data);
  }
  
  Future<Upcoming> fetchUpcoming() async {
    var resp = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/upcoming?api_key=ea80466bd55e4f4e143564b39696b4bd"));
    var data = jsonDecode(resp.body);
    return Upcoming.fromJson(data);
  }
  
  Future<List<dynamic>> fetchData() async {
    final results = await Future.wait([fetchMovies(), fetchTrendingMovies(), fetchToprated(),fetchUpcoming()]);
    return results;
  }

  Future<void> handlerefresh() async {
    return await Future.delayed(const Duration(seconds: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu, color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Movies", style: TextStyle(fontSize: 16, color: Colors.black)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search_rounded, color: Colors.black),
          )
        ],
      ),
      body: LiquidPullToRefresh(
        onRefresh: handlerefresh,
        backgroundColor: Colors.grey.shade400,
        color: Colors.grey.shade800,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 31, right: 31),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Trending Now", style: heading),
                    Text("See all>>", style: seeall)
                  ],
                ),
              ),
              SizedBox(height: 15),
              FutureBuilder<List<dynamic>>(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final movie = snapshot.data![0] as Movie;
                    final trending = snapshot.data![1] as Trending;
                    final toprated = snapshot.data![2] as TopRated;
                    final upcoming = snapshot.data![3] as Upcoming;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12,right: 12),
                          child: Container(
                            color: Colors.blueGrey.shade100.withOpacity(0.5),
                            height: 215, // Adjust height as needed
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 7,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        'https://image.tmdb.org/t/p/w500${trending.results[index].posterPath}',
                                        height: 200,
                                        width: 150,
                                        fit: BoxFit.fill,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 31,right: 31,top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Top Rated",style: heading,),
                              InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Toprated()));
                                  },
                                  child: Text("See all>>",style: seeall,))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12,right: 12,top: 15),
                          child: Container(
                            color: Colors.blueGrey.shade100.withOpacity(0.5),
                            height: 215, // Adjust height as needed
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 7,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        'https://image.tmdb.org/t/p/w500${toprated.results[index].posterPath}',
                                        height: 200,
                                        width: 150,
                                        fit: BoxFit.fill,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 31,right: 31,top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Upcoming",style: heading,),
                              Text("See all>>",style: seeall,)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12,right: 12,top: 15),
                          child: Container(
                            color: Colors.blueGrey.shade100.withOpacity(0.5),
                            height: 215, // Adjust height as needed
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 7,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        'https://image.tmdb.org/t/p/w500${upcoming.results[index].posterPath}',
                                        height: 200,
                                        width: 150,
                                        fit: BoxFit.fill,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 31,right: 31,top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Some Other Suggestions",style: heading,),
                              Text("See all>>",style: seeall,)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12,right: 12,top: 15),
                          child: Container(
                            color: Colors.blueGrey.shade100.withOpacity(0.5),
                            height: 217, // Adjust height as needed
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 7,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        'https://image.tmdb.org/t/p/w500${movie.results[index].posterPath}',
                                        height: 200,
                                        width: 150,
                                        fit: BoxFit.fill,
                                      ),
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
                    return Text('No data');
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
