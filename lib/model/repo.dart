import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Repo {
  final String name;
  final String repoOwner;

  Repo({@required this.name, @required this.repoOwner});

  Repo.fromJson(Map<String, dynamic> json)
      : this.name = json['name'],
        this.repoOwner = json['owner']['login'];

  static List<Repo> repoListFromJson(List collection) {
    List<Repo> repoList =
        collection.map((json) => Repo.fromJson(json)).toList();
    return repoList;
  }
}

class AppProvider with ChangeNotifier {
  List<Repo> _repos = [];
  List<Repo> get repos {
    return [..._repos];
  }

  Future<void> getRepos(String page) async {
    try {
      if (page.isNotEmpty) {
        final String repoUrl =
            "https://api.github.com/search/repositories?q=flutter+language:dart&$page=$page&per_page=10";

        final responseData = await http.get(repoUrl);
        if (responseData.statusCode == 200) {
          Iterable extractedRepoList = json.decode(responseData.body)['items'];
          if (extractedRepoList != null) {
            _repos = Repo.repoListFromJson(extractedRepoList);
            notifyListeners();
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
