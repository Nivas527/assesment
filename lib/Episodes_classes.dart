class EpisodeDetails {
  final String? sId;
  final String? airDate;
  final List<Episode>? episodes;
  final String? name;
  final String? overview;
  final int? id;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;

  EpisodeDetails({
    required this.sId,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.id,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory EpisodeDetails.fromJson(Map<String, dynamic> json) {
    return EpisodeDetails(
      sId: json['_id'] as String?,
      airDate: json['air_date'] as String?,
      episodes: (json['episodes'] as List<dynamic>?)
          ?.map((e) => Episode.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      overview: json['overview'] as String?,
      id: json['id'] as int?,
      posterPath: json['poster_path'] as String?,
      seasonNumber: json['season_number'] as int?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'air_date': airDate,
      'episodes': episodes?.map((e) => e.toJson()).toList(),
      'name': name,
      'overview': overview,
      'id': id,
      'poster_path': posterPath,
      'season_number': seasonNumber,
      'vote_average': voteAverage,
    };
  }
}

class Episode {
  final String? airDate;
  final int? episodeNumber;
  final String? episodeType;
  final int? id;
  final String? name;
  final String? overview;
  final String? productionCode;
  final int? runtime;
  final int? seasonNumber;
  final int? showId;
  final String? stillPath;
  final double? voteAverage;
  final int? voteCount;
  final List<dynamic>? crew;
  final List<GuestStar>? guestStars;

  Episode({
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
    required this.crew,
    required this.guestStars,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      airDate: json['air_date'] as String?,
      episodeNumber: json['episode_number'] as int?,
      episodeType: json['episode_type'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      overview: json['overview'] as String?,
      productionCode: json['production_code'] as String?,
      runtime: json['runtime'] as int?,
      seasonNumber: json['season_number'] as int?,
      showId: json['show_id'] as int?,
      stillPath: json['still_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
      crew: json['crew'] as List<dynamic>?,
      guestStars: (json['guest_stars'] as List<dynamic>?)
          ?.map((e) => GuestStar.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'air_date': airDate,
      'episode_number': episodeNumber,
      'episode_type': episodeType,
      'id': id,
      'name': name,
      'overview': overview,
      'production_code': productionCode,
      'runtime': runtime,
      'season_number': seasonNumber,
      'show_id': showId,
      'still_path': stillPath,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'crew': crew,
      'guest_stars': guestStars?.map((e) => e.toJson()).toList(),
    };
  }
}

class GuestStar {
  final String? character;
  final String? creditId;
  final int? order;
  final bool? adult;
  final int? gender;
  final int? id;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;

  GuestStar({
    required this.character,
    required this.creditId,
    required this.order,
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
  });

  factory GuestStar.fromJson(Map<String, dynamic> json) {
    return GuestStar(
      character: json['character'] as String?,
      creditId: json['credit_id'] as String?,
      order: json['order'] as int?,
      adult: json['adult'] as bool?,
      gender: json['gender'] as int?,
      id: json['id'] as int?,
      knownForDepartment: json['known_for_department'] as String?,
      name: json['name'] as String?,
      originalName: json['original_name'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      profilePath: json['profile_path'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'character': character,
      'credit_id': creditId,
      'order': order,
      'adult': adult,
      'gender': gender,
      'id': id,
      'known_for_department': knownForDepartment,
      'name': name,
      'original_name': originalName,
      'popularity': popularity,
      'profile_path': profilePath,
    };
  }
}
