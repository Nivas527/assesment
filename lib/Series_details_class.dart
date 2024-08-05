class SeriesDetails {
  bool adult;
  String backdropPath;
  List<CreatedBy> createdBy;
  List<int> episodeRunTime;
  String firstAirDate;
  List<Genres> genres;
  String homepage;
  int id;
  bool inProduction;
  List<String> languages;
  String lastAirDate;
  LastEpisodeToAir? lastEpisodeToAir;
  String name;
  NextEpisodeToAir? nextEpisodeToAir;
  List<Networks> networks;
  int numberOfEpisodes;
  int numberOfSeasons;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompanies> productionCompanies;
  List<ProductionCountries> productionCountries;
  List<Seasons> seasons;
  List<SpokenLanguages> spokenLanguages;
  String status;
  String tagline;
  String type;
  double voteAverage;
  int voteCount;

  SeriesDetails({
    required this.adult,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    this.lastEpisodeToAir,
    required this.name,
    this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  factory SeriesDetails.fromJson(Map<String, dynamic> json) {
    return SeriesDetails(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'] ?? '',
      createdBy: (json['created_by'] as List?)
          ?.map((i) => CreatedBy.fromJson(i))
          .toList() ?? [],
      episodeRunTime: (json['episode_run_time'] as List?)
          ?.map((e) => e is int ? e : int.tryParse(e.toString()) ?? 0)
          .toList() ?? [],
      firstAirDate: json['first_air_date'] ?? '',
      genres: (json['genres'] as List?)
          ?.map((i) => Genres.fromJson(i))
          .toList() ?? [],
      homepage: json['homepage'] ?? '',
      id: json['id'] ?? 0,
      inProduction: json['in_production'] ?? false,
      languages: (json['languages'] as List?)
          ?.map((e) => e.toString())
          .toList() ?? [],
      lastAirDate: json['last_air_date'] ?? '',
      lastEpisodeToAir: json['last_episode_to_air'] != null
          ? LastEpisodeToAir.fromJson(json['last_episode_to_air'])
          : null,
      name: json['name'] ?? '',
      nextEpisodeToAir: json['next_episode_to_air'] != null
          ? NextEpisodeToAir.fromJson(json['next_episode_to_air'])
          : null,
      networks: (json['networks'] as List?)
          ?.map((i) => Networks.fromJson(i))
          .toList() ?? [],
      numberOfEpisodes: json['number_of_episodes'] ?? 0,
      numberOfSeasons: json['number_of_seasons'] ?? 0,
      originCountry: (json['origin_country'] as List?)
          ?.map((e) => e.toString())
          .toList() ?? [],
      originalLanguage: json['original_language'] ?? '',
      originalName: json['original_name'] ?? '',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      posterPath: json['poster_path'] ?? '',
      productionCompanies: (json['production_companies'] as List?)
          ?.map((i) => ProductionCompanies.fromJson(i))
          .toList() ?? [],
      productionCountries: (json['production_countries'] as List?)
          ?.map((i) => ProductionCountries.fromJson(i))
          .toList() ?? [],
      seasons: (json['seasons'] as List?)
          ?.map((i) => Seasons.fromJson(i))
          .toList() ?? [],
      spokenLanguages: (json['spoken_languages'] as List?)
          ?.map((i) => SpokenLanguages.fromJson(i))
          .toList() ?? [],
      status: json['status'] ?? '',
      tagline: json['tagline'] ?? '',
      type: json['type'] ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'adult': adult,
    'backdrop_path': backdropPath,
    'created_by': createdBy.map((i) => i.toJson()).toList(),
    'episode_run_time': episodeRunTime,
    'first_air_date': firstAirDate,
    'genres': genres.map((i) => i.toJson()).toList(),
    'homepage': homepage,
    'id': id,
    'in_production': inProduction,
    'languages': languages,
    'last_air_date': lastAirDate,
    'last_episode_to_air': lastEpisodeToAir?.toJson(),
    'name': name,
    'next_episode_to_air': nextEpisodeToAir?.toJson(),
    'networks': networks.map((i) => i.toJson()).toList(),
    'number_of_episodes': numberOfEpisodes,
    'number_of_seasons': numberOfSeasons,
    'origin_country': originCountry,
    'original_language': originalLanguage,
    'original_name': originalName,
    'overview': overview,
    'popularity': popularity,
    'poster_path': posterPath,
    'production_companies': productionCompanies.map((i) => i.toJson()).toList(),
    'production_countries': productionCountries.map((i) => i.toJson()).toList(),
    'seasons': seasons.map((i) => i.toJson()).toList(),
    'spoken_languages': spokenLanguages.map((i) => i.toJson()).toList(),
    'status': status,
    'tagline': tagline,
    'type': type,
    'vote_average': voteAverage,
    'vote_count': voteCount,
  };
}

class CreatedBy {
  int id;
  String creditId;
  String name;
  String originalName;
  int gender;
  String profilePath;

  CreatedBy({
    required this.id,
    required this.creditId,
    required this.name,
    required this.originalName,
    required this.gender,
    required this.profilePath,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['id'] ?? 0,
      creditId: json['credit_id'] ?? '',
      name: json['name'] ?? '',
      originalName: json['original_name'] ?? '',
      gender: json['gender'] ?? 0,
      profilePath: json['profile_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'credit_id': creditId,
    'name': name,
    'original_name': originalName,
    'gender': gender,
    'profile_path': profilePath,
  };
}

class Genres {
  int id;
  String name;

  Genres({
    required this.id,
    required this.name,
  });

  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

class LastEpisodeToAir {
  int id;
  String name;
  String overview;
  double voteAverage;
  int voteCount;
  String airDate;
  int episodeNumber;
  String episodeType;
  String productionCode;
  int runtime;
  int seasonNumber;
  int showId;
  String stillPath;

  LastEpisodeToAir({
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
  });

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) {
    return LastEpisodeToAir(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      airDate: json['air_date'] ?? '',
      episodeNumber: json['episode_number'] ?? 0,
      episodeType: json['episode_type'] ?? '',
      productionCode: json['production_code'] ?? '',
      runtime: json['runtime'] ?? 0,
      seasonNumber: json['season_number'] ?? 0,
      showId: json['show_id'] ?? 0,
      stillPath: json['still_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'overview': overview,
    'vote_average': voteAverage,
    'vote_count': voteCount,
    'air_date': airDate,
    'episode_number': episodeNumber,
    'episode_type': episodeType,
    'production_code': productionCode,
    'runtime': runtime,
    'season_number': seasonNumber,
    'show_id': showId,
    'still_path': stillPath,
  };
}

class NextEpisodeToAir {
  int id;
  String name;
  String overview;
  double voteAverage;
  int voteCount;
  String airDate;
  int episodeNumber;
  String episodeType;
  String productionCode;
  int runtime;
  int seasonNumber;
  int showId;
  String stillPath;

  NextEpisodeToAir({
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
  });

  factory NextEpisodeToAir.fromJson(Map<String, dynamic> json) {
    return NextEpisodeToAir(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      airDate: json['air_date'] ?? '',
      episodeNumber: json['episode_number'] ?? 0,
      episodeType: json['episode_type'] ?? '',
      productionCode: json['production_code'] ?? '',
      runtime: json['runtime'] ?? 0,
      seasonNumber: json['season_number'] ?? 0,
      showId: json['show_id'] ?? 0,
      stillPath: json['still_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'overview': overview,
    'vote_average': voteAverage,
    'vote_count': voteCount,
    'air_date': airDate,
    'episode_number': episodeNumber,
    'episode_type': episodeType,
    'production_code': productionCode,
    'runtime': runtime,
    'season_number': seasonNumber,
    'show_id': showId,
    'still_path': stillPath,
  };
}

class Networks {
  int id;
  String name;
  String logoPath;
  String originCountry;

  Networks({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });

  factory Networks.fromJson(Map<String, dynamic> json) {
    return Networks(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      logoPath: json['logo_path'] ?? '',
      originCountry: json['origin_country'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'logo_path': logoPath,
    'origin_country': originCountry,
  };
}

class ProductionCompanies {
  int id;
  String name;
  String logoPath;
  String originCountry;

  ProductionCompanies({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });

  factory ProductionCompanies.fromJson(Map<String, dynamic> json) {
    return ProductionCompanies(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      logoPath: json['logo_path'] ?? '',
      originCountry: json['origin_country'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'logo_path': logoPath,
    'origin_country': originCountry,
  };
}

class ProductionCountries {
  String iso31661;
  String name;

  ProductionCountries({
    required this.iso31661,
    required this.name,
  });

  factory ProductionCountries.fromJson(Map<String, dynamic> json) {
    return ProductionCountries(
      iso31661: json['iso_3166_1'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'iso_3166_1': iso31661,
    'name': name,
  };
}

class Seasons {
  int id;
  String airDate;
  int episodeCount;
  String name;
  String overview;
  String posterPath;
  int seasonNumber;

  Seasons({
    required this.id,
    required this.airDate,
    required this.episodeCount,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  factory Seasons.fromJson(Map<String, dynamic> json) {
    return Seasons(
      id: json['id'] ?? 0,
      airDate: json['air_date'] ?? '',
      episodeCount: json['episode_count'] ?? 0,
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      seasonNumber: json['season_number'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'air_date': airDate,
    'episode_count': episodeCount,
    'name': name,
    'overview': overview,
    'poster_path': posterPath,
    'season_number': seasonNumber,
  };
}

class SpokenLanguages {
  String iso6391;
  String name;

  SpokenLanguages({
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguages.fromJson(Map<String, dynamic> json) {
    return SpokenLanguages(
      iso6391: json['iso_639_1'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'iso_639_1': iso6391,
    'name': name,
  };
}
