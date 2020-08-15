import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riot/models/league.dart';
import 'package:riot/models/matches_list.dart';
import 'package:riot/models/specific_match.dart';
import 'package:riot/utils/utils.dart';

import 'models/summoner_data.dart';

class RiotApi {
  Map summonerData;
  Map matchData;
  List summonerLeagueData;

  //This is for the new function implementation... DetailedMatchData()
  var matches;
  List matchDataListForUi;
  List numberOfKillsPerMatch;
  String globalChampName;
  List matchUpDataListForUi;

  Map matchDataForUi;

//Stores id of the champions from matches.
  List championIDList;
  List urlList;
  Map championInformation;

  String apiKey = "RGAPI-da91423e-ac40-4be9-bfc5-ac22616143c4";
  String ggApiKey = "Enter ggApiKey";

  //Constructor (Template)
  RiotApi() {
    print("RiotAPI object is instantiating...");
    //getStaticChampionData();
  }

  Future<void> getLeagueBySummoner(String summonerId) async {
    var response = await http.get(
        Uri.encodeFull(
            "https://euw1.api.riotgames.com/lol/league/v4/entries/by-summoner/$summonerId?api_key=$apiKey"),
        headers: {"Accept": "application/json"});
    print(response.statusCode);

    if (response.statusCode == 200) {
      var list = json.decode(response.body) as List;
      Utils.leagueData = list.map((i) => League.fromJson(i)).toList();
    }
  }

  //List data;
//todo image caching

  Future<bool> setSummonerData(String summonerName) async {
    print("Summoner nammmeee " + summonerName);
    var response = await http.get(
        Uri.encodeFull(
            "https://euw1.api.riotgames.com/lol/summoner/v4/summoners/by-name/$summonerName?api_key=$apiKey"),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      summonerData = json.decode(response.body);
      print("Summoner datatata " + summonerData["name"].toString());
      Utils.summonerData = Summoner.fromJson(json.decode(response.body));
      return true;
    } else {
      return false;
    }
  }

  String getSummonerIconLink(int iconId) {
    int profileIconId = iconId;
    print(profileIconId);
    String newUrl =
        "http://ddragon.leagueoflegends.com/cdn/10.16.1/img/profileicon/$iconId.png";
    return newUrl;
  }

  Future<void> getSummonerLeagueInfo() async {
    var summonerID = summonerData['id'];
    var response = await http.get(
        Uri.encodeFull(
            "https://tr1.api.riotgames.com/lol/league/v3/positions/by-summoner/$summonerID?api_key=$apiKey"),
        headers: {"Accept": "application/json"});
    summonerLeagueData = json.decode(response.body);
  }

  Future<void> getMatchListByAccountId() async {
    String accountID = Utils.summonerData.accountId;
    var response = await http.get(
        Uri.encodeFull(
            'https://euw1.api.riotgames.com/lol/match/v4/matchlists/by-account/$accountID?&api_key=$apiKey'),
        headers: {"Accept": "application/json"});
    print(response.statusCode);

    MatchesContent matches =
        MatchesContent.fromJson(json.decode(response.body));
    Utils.listMatches = matches.matches;
  }

  Future<void> getStaticChampionData(champId) async {
    var response = await http.get(
        Uri.encodeFull(
            "https://euw1.api.riotgames.com/lol/static-data/v4/champions?locale=es_ES&champListData=image&dataById=true&api_key=$apiKey"),
        headers: {"Accept": "application/json"});
    print(response.statusCode);
    Map temp = json.decode(response.body);
    //To set the champion informations.
    championInformation = temp["data"];
    int i = 1;
    Utils.champsData = championInformation;
    print(championInformation["$i"]["name"]);
  }

  void getTheChampNameFromMatch(int championId) {
    championInformation.forEach((k, v) {
      if (championInformation[k]["id"] == championId) {
        Map temp = championInformation[k]["image"];
        String champName = temp["full"];
        champName = champName.substring(0, champName.length - 4);
        globalChampName = champName;
      }
    });
  }

  Future<void> getMatchDataById(int matchId) async {
    var response = await http.get(Uri.encodeFull(
        "https://euw1.api.riotgames.com/lol/match/v4/matches/$matchId?api_key=$apiKey"));

    print(response.statusCode);
    if (response.statusCode != 200) {
      print('Response Code  : ${response.statusCode}');
      return null;
    }

    SpecificMatch match = SpecificMatch.fromJson(json.decode(response.body));
    Utils.specificMatch = match;
  }

  //This is a function to get the match id's of the last 10 games and get the data inside of them by using MATCh API from Riot... The api response has huge raw data, so we eliminate many of them...
  Future<void> getDetailedMatchData() async {
    matchDataListForUi = new List();
    int participantId;
    for (int i = 0; i < 10; i++) {
      var matchId = matches[i]["gameId"];
      var response = await http.get(
          Uri.encodeFull(
              "https://tr1.api.riotgames.com/lol/match/v3/matches/$matchId?api_key=$apiKey"),
          headers: {"Accept": "application/json"});
      Map rawMatchData = json.decode(response.body);
      List participantIdentities = rawMatchData["participantIdentities"];
      for (int i = 0; i < 10; i++) {
        Map playerDto = participantIdentities[i]["player"];
        if (playerDto["summonerId"] == summonerData["id"]) {
          participantId = participantIdentities[i]["participantId"];
          participantId--;
        }
      }
      List participants = rawMatchData["participants"];
      Map participantStatsDto = participants[participantId]["stats"];

      getTheChampNameFromMatch(participants[participantId]["championId"]);
      String champName = globalChampName;
      bool gameResult = participantStatsDto["win"];
      int numberOfKills = participantStatsDto["kills"];
      int numberOfDeaths = participantStatsDto["deaths"];
      int numberOfAssists = participantStatsDto["assists"];
      double kda =
          ((numberOfKills + numberOfAssists) / numberOfDeaths).toDouble();
      String kdaString;
      if (kda == 3 / 0)
        kdaString = "Perfect Match!";
      else
        kdaString = kda.toStringAsFixed(3);

      matchDataForUi = {
        "kills": "$numberOfKills",
        "deaths": "$numberOfDeaths",
        "assists": "$numberOfAssists",
        "gameResult": gameResult,
        "championName": champName,
        "kda": kdaString,
        "championId": participants[participantId]["championId"]
      };

      matchDataListForUi.add(matchDataForUi);
    }
  }
  /*

  Future<void> getDataFromGG() async{
    matchUpDataListForUi = new List();
    int lastChampionId;
    for(int i = 0; i < 3; i++){
      lastChampionId = matchDataListForUi[i]["championId"];
     var response = await http.get(
        Uri.encodeFull(
            "http://api.champion.gg/v2/champions/$lastChampionId/matchups?limit=1&api_key=$ggApiKey"),
        headers: {"Accept": "application/json"});
     List championMatchUpData = json.decode(response.body);
     Map matchUpData_1 = championMatchUpData[0]["_id"];
     int secondChampId = matchUpData_1["champ2_id"];
     getTheChampNameFromMatch(secondChampId);

     Map matchUpMap = {
       "firstChampName" : matchDataListForUi[i]["championName"],
       "secondChampName" : globalChampName,
     };
      matchUpDataListForUi.add(matchUpMap);
    }
  }
  */
}
