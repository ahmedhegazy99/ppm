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
  //var _postsStream = Rxn<List<PlayerModel>>();
  //var _filterdPosts = Rxn<List<PlayerModel>>();
  var _postsStream = RxList<PlayerModel>();
  var _filterdPosts = RxList<PlayerModel>();

  var ownerUserList= RxList<UserModel>();

  var userType = Rx(Get.find<UserController>().user.userType) ;
  String ? userTypeSt;

  List<PlayerModel> ? get posts => _filterdPosts.value;
  List<UserModel> ? get owners => ownerUserList.value;

  var loading = false.obs;

  List<PlayerModel> res = [];

  @override
  void onInit() {
    _postsStream.bindStream(Get.find<DatabaseController>().getPosts());
    _filterdPosts.value = _postsStream;
    cities.bindStream(Get.find<DatabaseController>().getCities());
    super.onInit();
  }

  @override
  void onReady() {

    /*while(_filterdPosts.isEmpty){
      getIds();
    }*/
    ever(Get.find<UserController>().userModel , (UserModel newVal) {
      userType.value = newVal.userType;
    });
    print("Getting idssssssssssssssssssssssssssssssssssssssss of owners");
    getIds();
    ever(_postsStream, (dynamic newVal) {
      print("filtered posts : ${_filterdPosts.value}");
      getIds();
      if (_filterdPosts.isEmpty) {
        print("empty posts");
        getIds();
      }
    });

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
      print(e);
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

    await Future.delayed(Duration(seconds: 0), () {
      Get.defaultDialog(
          title: 'Done'.tr, content: Icon(Icons.verified_rounded), backgroundColor: ppmMain
      );
    });

    Get.back();

  }

  Future<UserModel> getUser(String userId) async {
    try {
      UserModel u = await Get.find<DatabaseController>().getUser(userId);
      return u;
    } catch (e) {
      throw Exception("User Not Found");
      //displayError(e);
    }
  }

  Future<void> getIds() async {
    //ownerUserList = RxList<UserModel>();
    try {
      await Future.forEach(posts!, (PlayerModel value) async {
        print("start adding owners");
        ownerUserList.add(await getUser(value.userId!));

        print("posts length : ${_filterdPosts.length}");
        print("users length : ${ownerUserList.length}");
      });
      print("filtered posts : ${_filterdPosts.value}");
      print("ownerssssss : ${ownerUserList}");
    } catch (e) {
      //displayError(e);
    }
  }

  String ?getUserType(UserModel user) {
    try {
      switch(user.userType){
        case UserTypeEnum.userPlayer: {
          userTypeSt = "Player";
        }
        break;
        case UserTypeEnum.club: {
          userTypeSt = "Club";
        }
        break;
        case UserTypeEnum.admin: {
          userTypeSt = "Admin";
        }
        break;
        default:{
          userTypeSt = "Default";
        }
      }

      return userTypeSt;
    } catch (e) {
      displayError(e);
      //return;
    }
  }

  // This function is called whenever the text field changes
  Future<void> runFilter(String? keyword) async {
    loading.toggle();
    List<PlayerModel> results = [];
    print(keyword);
    if (keyword != null){
      if (keyword.isEmpty) {
        // if the search field is empty or only contains white-space, we'll display all users
        results = _postsStream;
      }else if(keyword == 'select'){
        results = _postsStream;
      }else{
        print("filtering......");
        print(_postsStream.value);
        await Future.delayed(
          Duration(seconds: 1),
              () {
            //_postsStream.bindStream(Get.find<DatabaseController>().getPosts());
            results = _postsStream
                .where((P) =>
                P.city!.contains(keyword/*.toLowerCase()*/))
                .toList();
          },
        );
        // results = _postsStream.value!
        //     .where((P) =>
        //     P.city!.contains(keyword/*.toLowerCase()*/))
        //     .toList();

        results.sort((a, b) => a.upvotes!.length.compareTo(b.upvotes!.length));
        // we use the toLowerCase() method to make it case-insensitive
      }
    }
    // Refresh the UI
    print(results);
    _filterdPosts.value = results;
    //showFliterBar.toggle();
    loading.toggle();

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
            child: Text("filter".tr),
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
  String dropdownValue = 'select'.tr;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //dropdownValue = widget.cities[0].cityName;
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward, color: ppmMain,),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
          color: ppmMain
      ),

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
          value: '${data.cityName}'.tr,
          child: Text('${data.cityName}'.tr),
        );
      }).toList(),
    );
  }
}