import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/screens/about/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: ppmMain,
        title: Text("Football Player Market"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ppmBack,
          ),
          onPressed: () {
            Get.back();
          },
        ),

        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(kDefaultPadding/2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              color: ppmBack,
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
              margin: EdgeInsets.only(bottom: kDefaultPadding, ),
              child: Flex(
                direction: Axis.vertical,
                children:[
                  SizedBox(
                    height: kDefaultPadding * 1.5,
                  ),

                  Image.asset(
                    'assets/images/fpm.png',
                    fit: BoxFit.contain,
                    height: 200,
                    width: 200,
                  ),

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: aboutFpm,
                      style: TextStyle(
                        fontSize: 18,
                        color: ppmLight,
                      ),
                      children: [
                        TextSpan(
                          text: "\n\n""للتواصل",
                          style: TextStyle(
                            fontSize: 20,
                            color: ppmLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: (){
                          launch("tel://01015800000?");
                        },
                        icon: Image.asset("assets/images/call.png"),
                      ),
                      IconButton(
                        onPressed: (){
                          launch("https://fb.me/ElShrookSportsClub?");
                        },
                        icon: SvgPicture.asset(
                          "assets/icons/facebook.svg",
                          //width: size.width * 0.6,
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          launch("mailto:elshrook1994@yahoo.com?");
                        },
                        icon: Icon(Icons.mail, color: ppmMain, size: 32,),
                      ),
                      IconButton(
                        onPressed: (){
                          launch("https://www.elshrookgroupsportsclub.com?");
                        },
                        icon: Image.asset("assets/images/site.png",color: ppmMain,),
                      ),
                    ],
                  ),
                ]
              ),
            ),

            Center(
              child: Text.rich(
                  TextSpan(
                    text: "Developed By Ahmed Hegazy",
                    style: TextStyle(
                      fontSize: 12,
                      color: ppmLight,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launch("mailto:tt.ahmedhegazy@gmail.com?");
                      },
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
