import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riot/api.dart';
import 'package:riot/models/matches_list.dart';
import 'package:riot/models/specific_match.dart';
import 'package:riot/utils/utils.dart';

/*
class MatchTile extends StatefulWidget {
  int id;
  MatchTile({@required this.id});
  @override
  _MatchTileState createState() => _MatchTileState();
}

class _MatchTileState extends State<MatchTile> {
  Teams myTeam;
  StreamController<bool> myTeamStateStream = StreamController<bool>.broadcast();

  @override
  void initState() {
    getMatchData();
    getMyTeam();
    super.initState();
  }

  getMatchData() async {
    await RiotApi().getMatchDataById(widget.id);
  }

  void getMyTeam() async {
    print(Utils.specificMatch.participantIdentities.length);
    

  @override
  Widget build(BuildContext context) {
    if (myTeam == null) {
      myTeamStateStream.add(false);
    } else {
      myTeamStateStream.add(true);
    }

    return StreamBuilder(
        stream: myTeamStateStream.stream,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data) {
            return Container(
              child: Text(
                myTeam.win == 'fail' ? 'Derrota' : 'Victoria',
              ),
            );
          } else {
            return Container(
              child: Center(
                child: Text(
                  'Loading',
                ),
              ),
            );
          }
        });
  }
}
*/
