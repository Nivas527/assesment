import 'dart:convert';
import 'package:assesment/Trending_series_individual_search.dart';
import 'package:flutter/material.dart';
import 'Search_class.dart';
import 'package:http/http.dart' as http;

import 'Trending_series_individual.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Future<Search>? _searchFuture;

  Future<Search> fetchSearch(String query) async {
    var resp = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/search/tv?query=$query&include_adult=false&language=en-US&page=1&api_key=ea80466bd55e4f4e143564b39696b4bd"));
    var data = jsonDecode(resp.body);
    return Search.fromJson(data);
  }

  void _search() {
    setState(() {
      _searchFuture = fetchSearch(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: 20,
            )),
        title: const Text(
          "Search",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 22, right: 22, top: 10),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      labelText: "Search here.."),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35, top: 15),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white),
                  onPressed: _search,
                  child: const Text("Click to Search"),
                ),
              ),
            ),
            FutureBuilder<Search?>(
              future: _searchFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text("Please connect to WIFI and Try again",
                      style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.black),),
                  );
                } else if (snapshot.hasData) {
                  final search = snapshot.data!;
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: search.results.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => TrendingSeriesIndividualSearch(out1: search.results[index],)));
                            },
                            child: Container(
                              color: Colors.grey.shade100,
                              child: Row(
                                children: [
                                  Image.network(
                                    search.results[index].posterPath.isNotEmpty
                                        ? 'https://image.tmdb.org/t/p/w500${search.results[index].posterPath}'
                                        : "https://cdn4.iconfinder.com/data/icons/picture-sharing-sites/32/No_Image-1024.png",
                                    height: 140,
                                    width: 140,
                                    fit: BoxFit.fill,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            search.results[index].originalName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                                color: Colors.black),
                                            overflow: TextOverflow.visible,
                                            maxLines: 2,
                                          ),
                                          Text(
                                            "Rating : (${search.results[index].voteAverage.round().toString()}/10)",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: Colors.black),
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
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Center(
                          child: const Text(
                        "Click on search to Find Your TV series",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      )),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
