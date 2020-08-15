import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riot/models/league.dart';
import 'package:riot/models/matches_list.dart';
import 'package:riot/models/specific_match.dart';
import 'package:riot/models/summoner_data.dart';
import 'package:riot/utils/style.dart';

class Utils {
  //Data
  static List <SpecificMatch> specificMatches;
  static SpecificMatch specificMatch;
  static List<SpecificMatch> gameData;
  static Summoner summonerData;
  static List<Matches> listMatches;
  static Map<dynamic, dynamic> champsData;
  static String iconUrl;
  static List<League> leagueData;

  //Alerts
  static Future showAlert(String title, String text, BuildContext context,
      {onPressed, barrierDismissible}) {
    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        barrierDismissible: barrierDismissible != null
            ? barrierDismissible
            : true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title, style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(text),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Entendido',
                    style: GoogleFonts.openSans(color: Style.primaryColor)),
                onPressed: () {
                  if (onPressed != null) {
                    onPressed();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
      );
    } else {
      return showDialog(
        context: context, //
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: new Text(
              title,
              style: GoogleFonts.openSans(letterSpacing: -3, color: Style.primaryColor),
            ),
            content: Column(
              children: <Widget>[
                SizedBox(
                  height: 4,
                ),
                Text(
                  text,
                  style: GoogleFonts.openSans(letterSpacing: -3, color: Style.primaryColor, height: 1.2),
                )
              ],
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text(
                  'Entendido',
                  style: GoogleFonts.openSans(
                    color: Style.primaryColor,
                  ),
                ),
                onPressed: () {
                  if (onPressed != null) {
                    onPressed();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }

  //Lodaing
  static Widget loading(_isLoading, [Color indicatorColor]) {
    return _isLoading == true
        ? new Container(
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    indicatorColor == null
                        ? Style.primaryColor
                        : indicatorColor),
              ),
            ),
          )
        : new Container();
  }
}
