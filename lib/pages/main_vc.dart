import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riot/api.dart';
import 'package:riot/models/summoner_data.dart';
import 'package:riot/pages/main_page.dart';
import 'package:riot/utils/style.dart';
import 'package:riot/utils/utils.dart';

class MainVC extends StatefulWidget {
  @override
  _MainVCState createState() => _MainVCState();
}

class _MainVCState extends State<MainVC> {
  TextEditingController _summonerName = TextEditingController();
  StreamController<bool> loadingStream = StreamController.broadcast();
  StreamController<bool> buttonState = StreamController.broadcast();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _summonerName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.white,
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: SingleChildScrollView(
                  padding: Style.lateralPadding,
                  child: IntrinsicHeight(
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(height: 20),
                          Text(
                            'Introduce tu nombre de invocador',
                            style: GoogleFonts.openSans(
                              color: Style.textColor,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Style.textFieldWithLabel(
                            'Nombre de invocador',
                            _summonerName,
                            context,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: Style.lateralPaddingValue * 2,
                            ),
                          ),
                          StreamBuilder(
                            stream: buttonState.stream,
                            initialData: false,
                            builder: (BuildContext context,
                                AsyncSnapshot<bool> snapshot) {
                              return Style.button('Go!', () {
                                summonerData(_summonerName.text);
                              });
                            },
                          ),
                          /*
                         
                          */
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
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
        )
      ],
    );
  }

  summonerData(String summonerName) async {
    bool summonerCheck;
    if (summonerName.isEmpty || summonerName.length == 0) {
      return Utils.showAlert(
          'Krates.gg', 'Debes introducir un nombre de invocador', context);
    } else {
      loadingStream.add(true);

      summonerCheck = await RiotApi().setSummonerData(summonerName);
      if (summonerCheck) {
        var futures = <Future>[];
        futures.add(RiotApi().setSummonerData(summonerName));
        futures.add(RiotApi().getMatchListByAccountId());
        futures.add(RiotApi().getLeagueBySummoner(Utils.summonerData.id));
        futures.add(RiotApi().getMatchListByAccountId());
       

        await Future.wait(futures);

        // getListMatchBySummoner(Utils.summonerData.id);
        loadingStream.add(false);

        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ),
        );
      } else {
        loadingStream.add(false);
        return Utils.showAlert(
            'Krates.gg',
            'El nombre de invocador no existe, por favor introduce uno existente',
            context);
      }

      /*
      static init(context) async {
    var futures = <Future>[];
    futures.add(ApiSingleton().fetchServices());
    futures.add(ApiSingleton().fetchMiscData());
    if (UserManager.user != null) {
      futures.add(ApiSingleton().fetchBookingsList());
      if (UserManager.user.isUser()) {
        Utils.typeUser = TypeUser.user;
        futures.add(ApiSingleton().fetchAdresses());
        futures.add(ApiSingleton().fetchPmContent());
        futures.add(ApiSingleton().fetchReferralInfo());
      } else {
        Utils.typeUser = TypeUser.professional;
        futures.add(ApiSingleton().fetchProServices());
        futures.add(ApiSingleton().fetchSchedules());
        futures.add(ApiSingleton().fetchSpecialSchedules());
      }
    }

    await Future.wait(futures);

    moveToMain(context);
  }
      */

    }
  }
}
