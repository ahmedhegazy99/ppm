import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  /*void getData() async {
    
    Response response = await get('http://www.mocky.io/v2/5ea68102320000841eac2a56');
    Map data = jsonDecode(response.body);
    print(data);
    print(data['title']);
  }*/

  int counter =0;

  @override
  void initState() {
    super.initState();
    //getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("loading screen"),
    );
  }
}



/*
{
    "success":true,
    "hierarchy":[
        {
            "title":"HB",
            "description":"the high board"
        },
        {
            "title":"technical",
            "description":"the technical section"
        },
        {
            "title":"production",
            "description":"the production section"
        },
        {
            "title":"organization",
            "description":"the organization section"
        },
        {
            "title":"marketing",
            "description":"the marketing section"
        },
        {
            "title":"magazine",
            "description":"the magazine project"
        }
        ],
        "message":"this is the hierarchy"
    }
*/