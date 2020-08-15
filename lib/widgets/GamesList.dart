import 'package:flutter/material.dart';
import 'package:riot/api.dart';
import 'package:riot/models/matches_list.dart';
import 'package:riot/models/specific_match.dart';
import 'package:riot/utils/style.dart';
import 'package:riot/utils/utils.dart';

class GameList extends StatefulWidget {
  @override
  _GameListState createState() => _GameListState();
  int id;
  Matches match;
  GameList({this.id, this.match});
}

class _GameListState extends State<GameList> {
  Teams myTeam;

  initData() async {
    await RiotApi().getMatchDataById(widget.id);
  }

  int summonerTeamId;
  int summonerParticipantId;

  @override
  Widget build(BuildContext context) {
    initData();
    for (int i = 0; i < Utils.specificMatch.participantIdentities.length; i++) {
      myTeam = null;
      if (Utils.specificMatch.participantIdentities[i].player.accountId ==
          Utils.summonerData.accountId) {
        summonerParticipantId =
            Utils.specificMatch.participantIdentities[i].participantId;
        for (int j = 0; j < Utils.specificMatch.participants.length; j++) {
          if (Utils.specificMatch.participants[j].participantId ==
              summonerParticipantId) {
            summonerTeamId = Utils.specificMatch.participants[j].teamId;
          }
        }
      }
    }

    for (int i = 0; i < Utils.specificMatch.teams.length; i++) {
      if (Utils.specificMatch.teams[i].teamId == summonerTeamId) {
        myTeam = Utils.specificMatch.teams[i];
      }
    }
    return ListView.builder(
      itemCount: Utils.listMatches.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),

          ),
          child: Center(child: Text(Utils.listMatches[index].champion.toString()))
        );
      },
    );
  }
}
