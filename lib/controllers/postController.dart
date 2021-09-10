import 'package:get/get.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/controllers/userController.dart';
import 'package:pro_player_market/models/cityModel.dart';
import 'package:pro_player_market/models/playerModel.dart';
import 'package:pro_player_market/models/requestModel.dart';
import 'package:pro_player_market/models/userModel.dart';
import 'package:pro_player_market/utils/utilFunctions.dart';
import 'package:flutter/material.dart';
import 'databaseController.dart';

class PostController extends GetxController {
  var _postsStream = Rxn<List<PlayerModel>>();
  var _filterdPosts = Rxn<List<PlayerModel>>();

  var userType = Get.find<UserController>().user.userType ;

  List<PlayerModel> ? get posts => _filterdPosts.value;

  @override
  void onInit() {
    _postsStream.bindStream(Get.find<DatabaseController>().getPosts());
    _filterdPosts = _postsStream;
    cities.bindStream(Get.find<DatabaseController>().getCities());
    super.onInit();
  }


  Future<void> toggleIsLiked(PlayerModel post) async {
    try {
      final UserModel user = Get.find<UserController>().user;
      final db = Get.find<DatabaseController>();

      if (post.upvotes?.contains(user.id) == true) {
        post.upvotes!.remove(user.id);
      } else {
        if (post.upvotes == null) {
          post.upvotes = [];
        }
        post.upvotes!.add(user.id!);
      }

      await db.updatePost(post);

      //return;
    } catch (e) {
      displayError(e);
      //return;
    }
  }

  Future<void> BuyRequest(String playerid) async {
    UserModel user = Get.find<UserController>().user;

    RequestModel req = RequestModel();

    req.type = RequestTypeEnum.deal;

    req.userId = user.id;
    req.info = playerid;
    req.requestDate = DateTime.now();
    //req.title = 'Player Buy Request';

    await Get.find<DatabaseController>().CreateBuyRequest(req);

   /* await Future.delayed(Duration(seconds: 30), () {*/
      Get.defaultDialog(
        title: 'Done'.tr, content: Icon(Icons.verified_rounded), backgroundColor: ppmMain
      );
   // });

    Get.back();

  }

  // This function is called whenever the text field changes
  Future<void> runFilter(String? keyword) async {
    List<PlayerModel> results = [];
    print(keyword);
    if (keyword != null){
      if (keyword.isEmpty) {
        // if the search field is empty or only contains white-space, we'll display all users
        results = _postsStream.value!;
      }else if(keyword == 'all'){
        results = _postsStream.value!;
      }else{
        print("filtering......");
        print(_postsStream.value);
        results = _postsStream.value!
            .where((P) =>
            P.city!.contains(keyword/*.toLowerCase()*/))
            .toList();

        results.sort((a, b) => a.upvotes!.length.compareTo(b.upvotes!.length));
        // we use the toLowerCase() method to make it case-insensitive
      }
    }
    // Refresh the UI
    print(results);
    _filterdPosts.value = results;
    //showFliterBar.toggle();

  }

  var showFliterBar = RxBool(false);
  var selectedCity;
  var cities = Rxn<List<CityModel>>();

  Container putDropdown(){
    print("Start Put drop down");
    return Container(
      color: ppmBack,
        // child: ListTile(
        //   title: DropButton(cities: cities.value,),
        //   trailing: OutlinedButton(
        //     onPressed: () {
        //       print('Received click Filter');
        //       runFilter(selectedCity);
        //       update();
        //     },
        //     style: ButtonStyle(
        //       foregroundColor: MaterialStateProperty.all(ppmBack),
        //       backgroundColor: MaterialStateProperty.all(ppmMain),
        //     ),
        //     child: Text("Filter"),
        //   ),
        // )
      padding: EdgeInsets.only(left: kDefaultPadding *1.5, right: kDefaultPadding),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropButton(cities: cities.value,),
            OutlinedButton(
              onPressed: () {
                print('Received click Filter');
                print(_postsStream.value);
                runFilter(selectedCity);
                //update();
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(ppmBack),
                backgroundColor: MaterialStateProperty.all(ppmMain),
              ),
              child: Text("Filter"),
            ),
          ],
        ),
    );
  }

}


class DropButton extends StatefulWidget {

  final cities;

  DropButton({
    Key ?key,
    required this.cities,
  }) :super(key: key);

  @override
  _DropButtonState createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {
  //final controller = Get.put(CreatePlayerController());
  String dropdownValue = 'all';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward, color: ppmMain,),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
          color: ppmMain
      ),
      /*underline: Container(
        height: 2,
        color: mainLigthP,
      ),*/
      onChanged: (String ? newValue) {
        setState(() {
          dropdownValue = newValue! ;
          print(dropdownValue);
          Get.find<PostController>().selectedCity = dropdownValue;
          /*switch (dropdownValue) {
            case 'Coworking Space': {
                controller.category = PlaceTypeEnum.coworkingSpace.toString();
              } break;
            case 'Studio': {
              controller.category = PlaceTypeEnum.studio.toString();
            } break;
            case 'Restaurant': {
              controller.category = PlaceTypeEnum.restaurant.toString();
            } break;
        }*/
        });
      },
      items: widget.cities
          .map<DropdownMenuItem<String>>((data) {
        return DropdownMenuItem<String>(
          value: data.cityName,
          child: Text('${data.cityName}'),
        );
      }).toList(),
    );
  }
}