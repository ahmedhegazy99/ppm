import 'package:flutter/material.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/screens/about/strings.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.03),
              Text(
                "about US",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: "englishBebas",
                    color: mindersMainY,
                    fontSize: 60),
              ),
              SizedBox(height: size.height * 0.03),
      /*        Text(
                aboutMinders,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: "englishTex",
                    color: Colors.black,
                    fontSize: 15),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.03),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.history,
                            color: mindersMainY,
                          )),
                      Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.people,
                            color: mindersMainY,
                          )),
                      Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.event_available,
                            color: mindersMainY,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            years,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: "englishBebas",
                                color: Colors.black,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          )),
                      Expanded(
                        flex: 1,
                        child: Text(
                          members,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: "englishBebas",
                              color: Colors.black,
                              fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          events,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: "englishBebas",
                              color: Colors.black,
                              fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.06),
              Text(
                "Meet Our Crew",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: "englishBebas",
                    color: mindersMainY,
                    fontSize: 60),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
