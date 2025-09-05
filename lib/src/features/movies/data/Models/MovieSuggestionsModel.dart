import 'MovieListModel.dart';

class MovieSuggestionsModel {
  MovieSuggestionsModel({
    this.status,
    this.statusMessage,
    this.data,
    this.meta,
  });

  MovieSuggestionsModel.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? Meta.fromJson(json['@meta']) : null;
  }

  String? status;
  String? statusMessage;
  Data? data;
  Meta? meta;
}

class Data {
  Data({this.movies});

  Data.fromJson(dynamic json) {
    if (json['movies'] != null) {
      movies = [];
      json['movies'].forEach((v) {
        movies?.add(Movies.fromJson(v)); // 👈 نفس كلاس Movies بتاع MovieListModel
      });
    }
  }

  List<Movies>? movies;
}

class Meta {
  Meta({
    this.serverTime,
    this.serverTimezone,
    this.apiVersion,
    this.executionTime,
  });

  Meta.fromJson(dynamic json) {
    serverTime = json['server_time'];
    serverTimezone = json['server_timezone'];
    apiVersion = json['api_version'];
    executionTime = json['execution_time'];
  }

  int? serverTime;
  String? serverTimezone;
  int? apiVersion;
  String? executionTime;
}
