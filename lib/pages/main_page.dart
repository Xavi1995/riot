import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riot/api.dart';
import 'package:riot/models/matches_list.dart';
import 'package:riot/utils/style.dart';
import 'package:riot/utils/utils.dart';
import 'package:riot/widgets/GamesList.dart';
import 'package:riot/widgets/matchTile.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  StreamController<bool> loadingStream = StreamController<bool>.broadcast();
  StreamController<List<Matches>> matches =
      StreamController<List<Matches>>.broadcast();
  var summonerData = Utils.summonerData;
  var matchList = Utils.listMatches;
  var leagueinfoSummoner = Utils.leagueData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String emblemSoloQueue = getEmblemIconSolo(0);
  }

  @override
  Widget build(BuildContext context) {
    String iconUrl = RiotApi().getSummonerIconLink(summonerData.profileIconId);

    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Style.backgroundLightColor,
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            title: Text('krates.gg',
                style: GoogleFonts.anton(color: Style.primaryColor)),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: Style.lateralPadding,
                    decoration: BoxDecoration(
                      color: Style.backgroundLightColor,
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Style.body('Hi', fontSize: 30),
                                    SizedBox(width: 10),
                                    Text(
                                      '${summonerData.name},',
                                      style: GoogleFonts.montserrat(
                                        color: Style.primaryColor,
                                        fontSize: 30,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Style.body(
                                      'Nivel ${summonerData.summonerLevel}',
                                      fontSize: 12,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: new BoxDecoration(
                                    border: Border.all(
                                        color: Style.primaryColor, width: 4),
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(iconUrl),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Style.lightPrimaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding: Style.lateralPadding,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Style.body('Solo Ranked',
                                            color: Colors.black, fontSize: 12),
                                      ),
                                      Image.asset(getEmblemIconSolo(0),
                                          height: 100, width: 100),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Style.body(getTier(0),
                                              color: Style.primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                          SizedBox(width: 4),
                                          Style.body(
                                            getRank(),
                                            color: Style.primaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: <Widget>[
                                          Style.body(
                                            '${Utils.leagueData[0].leaguePoints.toString()} LP',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                          SizedBox(width: 10),
                                          Style.body(
                                              '${Utils.leagueData[0].wins.toString()} V',
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 12),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Style.body('/',
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 12),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Style.body(
                                            '${Utils.leagueData[0].losses.toString()} D',
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 12,
                                          ),
                                        ],
                                      ),
                                      Style.body(
                                        'Win ratio: ${getWinRatioSoloQ(0).toString().substring(0, 4)} %',
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 12,
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Style.lightPrimaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding: Style.lateralPadding,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Style.body('Ranked flex 5v5',
                                            color: Colors.black, fontSize: 12),
                                      ),
                                      Image.asset(getEmblemFlex(1),
                                          height: 100, width: 100),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Style.body(getTier(1),
                                              color: Style.primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                          SizedBox(width: 4),
                                          Style.body(
                                            getRank(),
                                            color: Style.primaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: <Widget>[
                                          Style.body(
                                            '${Utils.leagueData[1].leaguePoints.toString()} LP',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                          SizedBox(width: 10),
                                          Style.body(
                                              '${Utils.leagueData[1].wins.toString()} V',
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 12),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Style.body('/',
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 12),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Style.body(
                                            '${Utils.leagueData[1].losses.toString()} D',
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 12,
                                          ),
                                        ],
                                      ),
                                      Style.body(
                                        'Win ratio: ${getWinRatioSoloQ(1).toString().substring(0, 4)} %',
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 12,
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: Style.lateralPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Style.body('Historial',
                            color: Colors.black, fontSize: 20),
                        SizedBox(height: Style.lateralPaddingValue),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: Utils.listMatches.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GameList(id: Utils.listMatches[index].gameId, match: Utils.listMatches[index],);
                          },
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        StreamBuilder<bool>(
          stream: loadingStream.stream,
          initialData: false,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData == false || snapshot.data == false) {
              return Container();
            }
            return Utils.loading(snapshot.data);
          },
        ),
      ],
    );
  }

  double getWinRatioSoloQ(int queueType) {
    int wins = Utils.leagueData[queueType].wins;
    int losses = Utils.leagueData[queueType].losses;
    int totalGames = wins + losses;

    double result = (wins * 100) / totalGames;
    return result;
  }

  String getEmblemIconSolo(int queueType) {
    String emblemString = Utils.leagueData.length == 1
        ? Utils.leagueData[0].tier
        : Utils.leagueData[queueType].tier;
    String result;
    switch (emblemString) {
      case 'BRONZE':
        result = 'assets/icons/Emblem_Bronze.png';
        break;
      case 'SILVER':
        result = 'assets/icons/Emblem_Silver.png';
        break;
      case 'GOLD':
        result = 'assets/icons/Emblem_Gold.png';
        break;
      case 'PLATINUM':
        result = 'assets/icons/Emblem_Platinum.png';
        break;
      case 'DIAMOND':
        result = 'assets/icons/Emblem_Diamond.png';
        break;
      case 'IRON':
        result = 'assets/icons/Emblem_Iron.png';
        break;
      case 'MASTER':
        result = 'assets/icons/Emblem_Master.png';
        break;
      case 'GRANDMASTER':
        result = 'assets/icons/Emblem_Grandmaster.png';
        break;
      case 'CHALLENGER':
        result = 'assets/icons/Emblem_Challenger.png';
        break;

      default:
        return '';
    }
    return result;
  }

  String getEmblemFlex(int typeQueue) {
    String emblemString = Utils.leagueData.length == 1
        ? Utils.leagueData[0].tier
        : Utils.leagueData[typeQueue].tier;
    String result;
    switch (emblemString) {
      case 'BRONZE':
        result = 'assets/icons/Emblem_Bronze.png';
        break;
      case 'SILVER':
        result = 'assets/icons/Emblem_Silver.png';
        break;
      case 'GOLD':
        result = 'assets/icons/Emblem_Gold.png';
        break;
      case 'PLATINUM':
        result = 'assets/icons/Emblem_Platinum.png';
        break;
      case 'DIAMOND':
        result = 'assets/icons/Emblem_Diamond.png';
        break;
      case 'IRON':
        result = 'assets/icons/Emblem_Iron.png';
        break;
      case 'MASTER':
        result = 'assets/icons/Emblem_Master.png';
        break;
      case 'GRANDMASTER':
        result = 'assets/icons/Emblem_Grandmaster.png';
        break;
      case 'CHALLENGER':
        result = 'assets/icons/Emblem_Challenger.png';
        break;
    }
    return result;
  }

  String getTier(int queueType) {
    String emblemString = Utils.leagueData.length == 1
        ? Utils.leagueData[0].tier
        : Utils.leagueData[queueType].tier;
    String result;
    switch (emblemString) {
      case 'BRONZE':
        result = 'BRONCE';
        break;
      case 'SILVER':
        result = 'PLATA';
        break;
      case 'GOLD':
        result = 'ORO';
        break;
      case 'PLATINUM':
        result = 'PLATINO';
        break;
      case 'DIAMOND':
        result = 'DIAMANTE';
        break;
      case 'IRON':
        result = 'HIERRO';
        break;
      case 'MASTER':
        result = 'MASTER';
        break;
      case 'GRANDMASTER':
        result = 'GRANDMASTER';
        break;
      case 'CHALLENGER':
        result = 'CHALLENGER';
        break;
    }
    return result;
  }

  String getRank() {
    String emblemString = Utils.leagueData[0].rank;
    String result;
    switch (emblemString) {
      case 'I':
        result = '1';
        break;
      case 'II':
        result = '2';
        break;
      case 'III':
        result = '3';
        break;
      case 'IV':
        result = '4';
        break;
      case 'V':
        result = '5';
        break;
    }
    return result;
  }
}
