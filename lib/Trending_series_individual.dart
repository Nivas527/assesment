import 'dart:convert';

import 'package:assesment/Series_details_class.dart';
import 'package:flutter/material.dart';
import 'Cast_details_class.dart';
import 'TV_popular_class.dart';
import 'package:http/http.dart' as http;

import 'TV_series_episodes.dart';

class TrendingSeriesIndividual extends StatelessWidget {
  final Results out;

  const TrendingSeriesIndividual({
    super.key,
    required this.out,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            // toolbarHeight: 100,
            automaticallyImplyLeading: true,
            bottom: const TabBar(
                labelColor: Colors.red,
                labelStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                isScrollable: false,
                tabs: [
                  Tab(
                    text: "Overview",
                  ),
                  Tab(
                    text: "Episodes",
                  ),
                  Tab(
                    text: "Cast",
                  ),
                ]),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 22, right: 22, top: 15),
            child: TabBarView(children: [
              OverviewTab(out: out),
              EpisodesTab(
                out: out,
              ),
              CastTab(
                out: out,
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class OverviewTab extends StatelessWidget {
  final Results? out;

  const OverviewTab({super.key, required this.out});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    // border: Border.all(width: 5),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade300),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.network(
                    out?.posterPath == null
                        ? "https://cdn4.iconfinder.com/data/icons/picture-sharing-sites/32/No_Image-1024.png"
                        : "https://image.tmdb.org/t/p/w500${out?.posterPath}",
                    height: 350,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28, right: 28, top: 15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      out!.originalName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Rating : ${out?.voteAverage.round()}/10 (${out?.voteCount})",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 10),
              child: Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white),
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Play  ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
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
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 15),
              child: Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white),
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Download  ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Icon(
                          Icons.download_for_offline_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              out!.overview,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.black),
            )
          ],
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
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (out == null) {
      return const Center(
        child: Text("No data available."),
      );
    }

    return FutureBuilder<SeriesDetails?>(
      future: fetchDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.only(top: 50),
            child: Center(
              child: Text("Please connect to Wifi and Try again ",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.black)),
            ),
          );
        } else if (snapshot.hasData) {
          final details = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: details.numberOfSeasons,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EpisodeScreen(
                                            epi: details.seasons[index],
                                            epid: details,
                                          )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 100,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Image.network(
                                      details.seasons[index].posterPath
                                              .isNotEmpty
                                          ? "https://image.tmdb.org/t/p/w500${details.seasons[index].posterPath}"
                                          : "https://cdn4.iconfinder.com/data/icons/picture-sharing-sites/32/No_Image-1024.png",
                                      height: 80,
                                      width: 100,
                                      fit: BoxFit.fill,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(details.seasons[index].name,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                          Text(
                                            "Rating : (${details.voteAverage.round().toString()}/10)",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "Total Episodes : ${details.seasons[index].episodeCount.toString()}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text("No data available."),
          );
        }
      },
    );
  }
}

class CastTab extends StatelessWidget {
  final Results? out;

  const CastTab({super.key, required this.out});

  Future<Castdetails?> fetchCast() async {
    if (out == null) return null;

    try {
      final response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/tv/${out!.id}/credits?api_key=ea80466bd55e4f4e143564b39696b4bd"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Castdetails.fromJson(data);
      } else {
        throw Exception('Failed to load details');
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (out == null) {
      return const Center(
        child: Text("No data available."),
      );
    }

    return FutureBuilder<Castdetails?>(
      future: fetchCast(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
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
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: details.cast.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 100,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Image.network(
                                    details.cast[index].profilePath == null
                                        ? "https://cdn4.iconfinder.com/data/icons/picture-sharing-sites/32/No_Image-1024.png"
                                        : "https://image.tmdb.org/t/p/w500${details.cast[index].profilePath}",
                                    height: 80,
                                    width: 100,
                                    fit: BoxFit.fill,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Name : ${details.cast[index].name}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          softWrap: true,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "Character : ${details.cast[index].character}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          softWrap: true,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text("No data available."),
          );
        }
      },
    );
  }
}
