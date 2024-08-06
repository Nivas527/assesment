import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Episodes_classes.dart';
import 'Series_details_class.dart';

// Assuming you have EpisodeDetails, Episode, and other related classes properly defined and imported

class EpisodeScreen extends StatelessWidget {
  final Seasons? epi;

  final SeriesDetails? epid;

   EpisodeScreen({Key? key, required this.epi, required this.epid}) : super(key: key);


  Future<EpisodeDetails> fetchEpisode() async {
    if (epi == null) {
      throw Exception("Episode details not provided");
    }

    print(epid!.id);
    print(epi!.seasonNumber);

    var response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/tv/${epid!.id.toString()}/season/${epi!.seasonNumber.toString()}?api_key=ea80466bd55e4f4e143564b39696b4bd"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return EpisodeDetails.fromJson(data);
    } else {
      throw Exception("Failed to load episode details");
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_rounded)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 22,right: 22,top: 15,bottom: 5),
              child: Text(epid!.originalName,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: true,
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900,color: Colors.black),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22,right: 22,bottom: 10),
              child: Text(epi!.name.toString(),style: TextStyle(
                fontWeight: FontWeight.w600,fontSize: 20,color: Colors.black87
              ),
              ),
            ),
            FutureBuilder<EpisodeDetails?>(
              future: fetchEpisode(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("There is an error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  final details = snapshot.data;
                  if (details == null || details.episodes == null) {
                    return Center(child: Text("No data available."));
                  }
        
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: details.episodes!.length,
                          itemBuilder: (context, index) {
                            final episode = details.episodes![index];
        
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
                                        crossAxisAlignment : CrossAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            episode.stillPath?.isNotEmpty == true
                                                ? "https://image.tmdb.org/t/p/w500${episode.stillPath}"
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
                                                Text(
                                                  "Episode: ${episode.episodeNumber ?? 'N/A'}",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  "Rating: (${episode.voteAverage?.toString() ?? 'N/A'}/10)",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  "Run Time: ${episode.runtime?.toString() ?? "N/A"} mins",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 40),
                                            child: Icon(Icons.download_for_offline_outlined,color: Colors.white,size: 25,),
                                          )
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
                  return Center(child: Text("No data available."));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
