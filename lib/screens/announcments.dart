import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_player_market/components/constants.dart';
import 'package:pro_player_market/components/videoPlayer.dart';
import 'package:pro_player_market/controllers/databaseController.dart';

class Announcements extends StatelessWidget {
  //const Announcements({Key? key}) : super(key: key);

  //var announce = RxList();
  var announce = RxMap();
  var edit  = RxBool(false);
  final contentController = TextEditingController();

  var selectedImage;
  RxBool ?doneP = false.obs, doneV = false.obs;

  final image = Rxn<File>();
  final video = Rxn<File>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    //announce = Get.find<DatabaseController>().getAnnouncement();
    getAnn();
    
    return Scaffold(
      //backgroundColor: Colors.grey[200],
      backgroundColor: ppmBack,
      body: SingleChildScrollView(
//        padding: EdgeInsets.all(kDefaultPadding/2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              //color: ppmBack,
              //color: Colors.grey[200],
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
              margin: EdgeInsets.only(bottom: kDefaultPadding, ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom:Radius.circular(30),),
                color: Colors.grey[200],
              ),
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
                      text: "فكرة جديدة تعتمد على اختبار لاعبى كرة القدم بشكل جديد من خلال تطبيق الموبيل، حيث  تعتمد الفكرة على إرسال فيديو للمواهب الناشئه، فى عالم كرة القدم و يتم اختيار التواصل مع لاعبى كرة القدم من خلال نوادي اخرة وتقوم فلفسفة التطبيق على اختصار الوقت ومنح الفرصة لملايين الناشئين الراغبين فى الخضوع للاختبارات و يتم تسويق لافضل لاعبى كرة القدم في كل محافظة.",
                      style: TextStyle(
                        fontSize: 18,
                        color: ppmLight,
                      ),

                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                ]
              ),
            ),

            ///add obx listener here
            /*Obx((){
              if (announce.isNotEmpty) {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          children: [
                            Text(
                              '${announce['content']??'this is the content'}',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            CachedNetworkImage(
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  LinearProgressIndicator(value: downloadProgress.progress),
                              imageUrl: '${announce['image']}',
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ],
                        ),
                      );
                    }
                );
              }
              return Container();
            }),*/

            Obx((){
              if (announce.isNotEmpty) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(bottom:Radius.circular(30),),
                    //color: Colors.grey[200],

                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo,
                        //ppmMain,
                        Colors.red,
                        //Colors.pink,
                        //Colors.orange,
                        Colors.yellow,
                      ],
                      begin: Alignment(-1.0, 15.0),
                      end: Alignment(20 , 10.0),
                      stops: [0.1, /*0.38,*/ 0.2, 0.3, /*0.4, 0.5*/],
                      //tileMode: TileMode.mirror,
                    )

                  ),
                  child: Column(
                    children: [

                      if(announce['video'] != null)
                        VideoWidget(announce['video']),

                      if(announce['image'] != null)
                      CachedNetworkImage(
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            LinearProgressIndicator(value: downloadProgress.progress),
                        imageUrl: '${announce['image']}',
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),

                      if(announce['content'] != null)
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        child: Text(
                          '${announce['content']??'this is the content'}',
                          style: TextStyle(
                            fontSize: 18,
                            color: ppmBack,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            }),

            /*IconButton(
                                  onPressed: (){
                                    edit.value = true;
                                  },
                                  color: ppmMain,
                                  icon: Icon(Icons.edit),
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: size.width * 0.35),
                                ),*/
            //edit button
            ElevatedButton(
              onPressed: (){
                print("edit announce");
                edit.value = true;
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 1, horizontal: size.width * 0.35)),
                backgroundColor: MaterialStateProperty.all(ppmMain),
              ),
              child: Icon(Icons.edit),
            ),

            SizedBox(height: size.height * 0.02),

            Obx((){
              if(edit.value)
              return Container(
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Container(
                      padding: EdgeInsets.all(size.width*0.06),
                      child: TextField(
                        controller: contentController,
                        //expands: true,
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: 'Enter content'.tr,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),

                    /*GestureDetector(
                      child: Container(
                        key: key,
                        child: done!.value && selectedImage != null ?
                        Image.file(
                          selectedImage,
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                        ) :
                        Image.asset(
                          "assets/images/placeholder.jpg",
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                      onTap: () async {
                        selectedImage = await (selectImage())!;
                        done!.value = true;
                      },
                    ),*/

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            icon: Icon(
                              Icons.photo_camera,
                              color: doneP!.value ? Colors.green :ppmMain,
                            ),
                            label: Text(
                              doneP!.value ? 'done'.tr : 'add photo'.tr,
                              style: TextStyle(
                                color: doneP!.value ? Colors.green :ppmMain,
                              ),
                            ),
                            onPressed: () async {
                              selectedImage = await (selectImage())!;
                              doneP!.value = true;
                            },
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(Size(size.width*0.35, size.width*0.1)),
                            ),
                          ),

                          ElevatedButton.icon(
                            icon: Icon(
                              Icons.video_stable,
                              color: doneV!.value ? Colors.green :ppmMain,
                            ),
                            label: Text(
                              doneV!.value ?  'done'.tr : 'add video'.tr,
                              style: TextStyle(
                                color: doneV!.value ? Colors.green :ppmMain,
                              ),
                            ),
                            onPressed: () async {
                              //selectedImage =
                              await (selectVideo());
                              doneV!.value = true;
                            },
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(Size(size.width*0.35, size.width*0.1)),
                            ),
                          ),
                        ],
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        print("announcing");
                        await Get.find<DatabaseController>().addAnnouncement(
                            content: contentController.text,
                            image: image.value,
                            video: video.value);
                        edit.value = false;
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            vertical: 1, horizontal: size.width * 0.35)),
                        backgroundColor: MaterialStateProperty.all(ppmMain),
                      ),
                      child: Text('announce'.tr),
                    ),
                  ],
                ),
              );
              return Container();
            }),

          ],
        ),
      ),
    );
  }


  selectImage() async {
    final sImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(sImage != null) {
      image.value = await ImageCropper.cropImage(
        sourcePath: sImage.path,
        /*aspectRatio: CropAspectRatio(
            ratioX: 5, ratioY: 5),*/
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9,
        ],
        compressQuality: 100,
        //maxWidth: 700,
        //maxHeight: 700,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: ppmLight,
          toolbarTitle: "Crop",
          //statusBarColor: Colors.deepOrange.shade900,
          backgroundColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
        ),
        iosUiSettings: IOSUiSettings(
          title: 'Crop',
        ),
      );
      return image.value;
    }
    //return image.value;
  }

  selectVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      video.value = File(pickedFile.path);
      return video.value;
    }
  }

  getAnn() async {
    announce.value = await Get.find<DatabaseController>().getAnnouncement();
    print(announce);
  }

}
