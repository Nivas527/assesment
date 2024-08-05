// Trending_series_individual.dart

import 'dart:convert';

import 'package:assesment/Series_details_class.dart';
import 'package:flutter/material.dart';
import 'TV_popular_class.dart';
import 'package:http/http.dart' as http;

class TrendingSeriesIndividual extends StatelessWidget {
  final Results out;

  const TrendingSeriesIndividual({super.key, required this.out});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 10,
              floating: false,
              pinned: true,
              snap: false,
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: 1,
                    (context, index) => ListTile(
                          title: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 5),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.black12),
                                    child: Image.network(
                                      "https://image.tmdb.org/t/p/w500${out.posterPath}",
                                      height: 350,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 28, right: 28, top: 15),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        "https://image.tmdb.org/t/p/w500${out.backdropPath}",
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              out.originalName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22,
                                                  color: Colors.black),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Rating : ${out.voteAverage.round()}/10(${out.voteCount})",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                            Text(
                                                "Language: ${out.originalLanguage}"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 32, top: 15),
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            foregroundColor: Colors.white),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Play  ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Icon(
                                              Icons.play_circle_outline_sharp,
                                              color: Colors.white,
                                              size: 20,
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 32, top: 15),
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey,
                                            foregroundColor: Colors.white),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Download  ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Icon(
                                              Icons
                                                  .download_for_offline_outlined,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )))
          ];
        },
        body: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              // toolbarHeight: 100,
              automaticallyImplyLeading: false,
              bottom: TabBar(
                labelColor: Colors.red,
                labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
                isScrollable: false,
                  tabs: [
                    Tab(text: "Overview",),
                    Tab(text: "Episodes",),
                    Tab(text: "Cast",),
                  ]),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 22,right: 22,top: 15),
              child: TabBarView(
                  children: [
                    Text(out.overview,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black),),
                    EpisodesTab(out: out,),
                    Text("Cast")
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class EpisodesTab extends StatelessWidget {
  final Results? out;
  const EpisodesTab({super.key, required this.out});

  Future<SeriesDetails?> fetchDetails() async {
    if (out == null) return null;
    print(out?.id);

    try {
      final response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/tv/${out?.id}?api_key=ea80466bd55e4f4e143564b39696b4bd"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return SeriesDetails.fromJson(data);
      } else {
        throw Exception('Failed to load details');
      }
    } catch (e) {
      print('Error fetching details: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (out == null) {
      return Center(
        child: Text("No data available."),
      );
    }

    return FutureBuilder<SeriesDetails?>(
      future: fetchDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("There is an error: ${snapshot.error}"),
          );
        } else if (snapshot.hasData) {
          final details = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: details.numberOfSeasons,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(details.seasons[index].name,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(details.voteAverage.toString()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Text("No data available."),
          );
        }
      },
    );
  }
}
