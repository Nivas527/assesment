import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'Bottom_navigation.dart';
import 'Database/Database _trending _series.dart';
import 'TV_popular_class.dart';
import 'Trending_series_individual.dart';

class TrendingSeries extends StatefulWidget {
  const TrendingSeries({super.key});

  @override
  State<TrendingSeries> createState() => _TrendingSeriesState();
}

class _TrendingSeriesState extends State<TrendingSeries> {
  bool _isOffline = false;
  List<Results> _results = [];
  int _currentPage = 1;
  int _totalPages = 1;
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchTrending();
  }

  Future<void> _fetchTrending() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final tvPopular = await fetchTrending(_currentPage);
      setState(() {
        if (_currentPage == 1) {
          _results = tvPopular.results;
        } else {
          _results.addAll(tvPopular.results);
        }
        _totalPages = tvPopular.totalPages;
        _isOffline = false;
      });
    } catch (e) {
      setState(() {
        _isOffline = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<TvPopular> fetchTrending(int page) async {
    if (_isOffline) {
      List<Results> results = await DatabaseHelper.instance.fetchAllResults();
      return TvPopular(
          page: 1,
          results: results,
          totalPages: 1,
          totalResults: results.length);
    } else {
      var resp = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/tv/popular?api_key=ea80466bd55e4f4e143564b39696b4bd&page=$page"));
      var data = jsonDecode(resp.body);
      print(resp.body.length);
      TvPopular tvPopular = TvPopular.fromJson(data);

      // Clear previous data and save new data to the local database only on the first page
      if (page == 1) {
        await DatabaseHelper.instance.clearResults();
        for (var result in tvPopular.results) {
          await DatabaseHelper.instance.insertResult(result);
        }
      }

      return tvPopular;
    }
  }

  Future<void> _handlerefresh() async {
    _currentPage = 1;
    await _fetchTrending();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            )),
        title: Text(
          "Trending Series",
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: _handlerefresh,
        backgroundColor: Colors.grey.shade400,
        color: Colors.grey.shade800,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _results.length + 1,
                itemBuilder: (context, index) {
                  if (index == _results.length) {
                    return _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : _currentPage < _totalPages
                            ? Padding(
                              padding: const EdgeInsets.only(left: 22,right: 22,top: 15,bottom: 25),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    _currentPage++;
                                    _fetchTrending();
                                  },
                                  child: Text(
                                    'Load More',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                            )
                            : SizedBox.shrink();
                  }

                  final result = _results[index];
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        color: Colors.grey.shade100,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TrendingSeriesIndividual(out: result),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Image.network(
                                result.posterPath.isNotEmpty
                                    ? 'https://image.tmdb.org/t/p/w500${result.posterPath}'
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
                                        result.originalName.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            color: Colors.black),
                                        overflow: TextOverflow.visible,
                                        maxLines: 2,
                                      ),
                                      Text(
                                        "Rating : (${result.voteAverage.round().toString()}/10)",
                                        style: TextStyle(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
