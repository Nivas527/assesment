import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../TV_popular_class.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'tv_popular.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tv_popular(
        id INTEGER PRIMARY KEY,
        adult INTEGER,
        backdrop_path TEXT,
        genre_ids TEXT,
        origin_country TEXT,
        original_language TEXT,
        original_name TEXT,
        overview TEXT,
        popularity REAL,
        poster_path TEXT,
        first_air_date TEXT,
        name TEXT,
        vote_average REAL,
        vote_count INTEGER
      )
    ''');
  }

  Future<int> insertResult(Results result) async {
    Database db = await instance.database;
    return await db.insert('tv_popular', result.toJson());
  }

  Future<List<Results>> fetchAllResults() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('tv_popular');

    return List.generate(maps.length, (i) {
      return Results(
        adult: maps[i]['adult'] == 1,
        backdropPath: maps[i]['backdrop_path'],
        genreIds: (jsonDecode(maps[i]['genre_ids']) as List<dynamic>).cast<int>(),
        id: maps[i]['id'],
        originCountry: (jsonDecode(maps[i]['origin_country']) as List<dynamic>).cast<String>(),
        originalLanguage: maps[i]['original_language'],
        originalName: maps[i]['original_name'],
        overview: maps[i]['overview'],
        popularity: maps[i]['popularity'],
        posterPath: maps[i]['poster_path'],
        firstAirDate: maps[i]['first_air_date'],
        name: maps[i]['name'],
        voteAverage: maps[i]['vote_average'],
        voteCount: maps[i]['vote_count'],
      );
    });
  }

  Future<void> clearResults() async {
    Database db = await instance.database;
    await db.delete('tv_popular');
  }
}
