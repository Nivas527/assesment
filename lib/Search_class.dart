class Search {
  int page;
  List<Results1> results;
  int totalPages;
  int totalResults;

  Search({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
      page: json['page'] ?? 0,
      results:
          List<Results1>.from(json['results'].map((v) => Results1.fromJson(v))),
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = this.page;
    data['results'] = this.results.map((v) => v.toJson()).toList();
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}

class Results1 {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  String firstAirDate;
  String name;
  double voteAverage;
  int voteCount;

  Results1({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Results1.fromJson(Map<String, dynamic> json) {
    return Results1(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'] ?? '',
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      id: json['id'] ?? 0,
      originCountry: List<String>.from(json['origin_country'] ?? []),
      originalLanguage: json['original_language'] ?? '',
      originalName: json['original_name'] ?? '',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] ?? 0.0).toDouble(),
      posterPath: json['poster_path'] ?? '',
      firstAirDate: json['first_air_date'] ?? '',
      name: json['name'] ?? '',
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['genre_ids'] = this.genreIds;
    data['id'] = this.id;
    data['origin_country'] = this.originCountry;
    data['original_language'] = this.originalLanguage;
    data['original_name'] = this.originalName;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['first_air_date'] = this.firstAirDate;
    data['name'] = this.name;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    return data;
  }
}
