

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:chitrai/screens/Artpage.dart';
import 'package:chitrai/screens/admob.dart';
import 'package:chitrai/screens/propage.dart';
import 'package:chitrai/screens/stylespage.dart';
import 'package:chitrai/screens/try.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';


class home extends StatefulWidget {


 const  home({Key? key,}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  TextEditingController _promptContoller=TextEditingController();
  TextEditingController _editpromptContoller=TextEditingController();
  int _wordCount = 0;
  String a='';
  bool _showCancelIcon = false;
  bool _button1Selected = false;
  bool _button2Selected = false;
  String  ? selectedImage;
  String  ? artimage;
  String   ? editedartimage;
  bool isloading=false;
  bool isdownloading=false;
  bool issharing=false;
  int selectedButtonIndex = 0;
  BannerAd? _banner;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  int life = 0;
  void _createBannerAd() {
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _banner = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  void _createIntertitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (LoadAdError error) => _interstitialAd = null,
      ),
    );
  }

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: AdHelper.rewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (ad) => setState(() => _rewardedAd = ad),
            onAdFailedToLoad: (error) => setState(() => _rewardedAd = null)));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createIntertitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createIntertitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void _showRewardedAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          setState(() {
            life += 1;
          });
        });

  }

  @override
  void initState() {
    super.initState();
    _promptContoller= TextEditingController();
    _createbannerAd();
    _createIntertitialAd();
    _createRewardedAd();
    _createBannerAd();

  }

  @override
  void dispose() {
    _promptContoller.dispose();
    _banner?.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }

void _createbannerAd(){
  BannerAd(
    adUnitId: AdHelper.bannerAdUnitId,
    request: AdRequest(),
    size: AdSize.banner,
    listener: BannerAdListener(
      onAdLoaded: (ad) {
        setState(() {
          _banner = ad as BannerAd;
        });
      },
      onAdFailedToLoad: (ad, err) {
        print('Failed to load a banner ad: ${err.message}');
        ad.dispose();
      },
    ),
  ).load();
}

  void _showCancelIconChanged(String text) {
    setState(() {
      _showCancelIcon = text.isNotEmpty;
    });
  }



  void _wordCountChanged(String text) {
    setState(() {
      _wordCount = text.split(' ').where((word) => word.isNotEmpty).length;
    });
  }

  void _clearText() {
    setState(() {

      setState(() {
        isloading = false;
      });
      _promptContoller.clear();
      _wordCount = 0;

    });
  }


  String apikey = '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';
  String url = 'https://api.openai.com/v1/images/generations';


  void getAIImage() async{
    _showRewardedAd();
    setState(() {
      isloading = true;
    });


    if(_promptContoller.text.isNotEmpty) {

/*

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                artpage(
                  selectedImage:
                  selectedImage==null?a:
                  selectedImage! ,
                  prompt: _promptContoller.text,),

          ));

      */





     // showimage();

      var data = {
        "prompt": _promptContoller.text+_selectedName+'Digital Art',



        "n": 1,
        "size": "256x256",
      };


      var res = await http.post(Uri.parse(url),
          headers: {
            "Authorization": "Bearer ${apikey}",
            "Content-Type": "application/json"
          },
          body: jsonEncode(data));

      var jsonResponse = jsonDecode(res.body);

      selectedImage = jsonResponse['data'][0]['url'];

      setState(() {

      });




      Fluttertoast.showToast(
          msg: "Genrating Image..",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }else{
      print("Enter something");
    }


    setState(() {
      isloading = false;
    });
    
  }

/*
  Future<void> downloadImage(BuildContext context) async {
    try {

      if(_promptContoller.text.isNotEmpty) {


/*
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                artpage(
                  selectedImage:
                  selectedImage==null?a:
                  selectedImage! ,
                  prompt: _promptContoller.text,),

          ));

      */


        // showimage();

        var data = {
          "prompt": _promptContoller.text,
          "n": 1,
          "size": "256x256",
        };


        var res = await http.post(Uri.parse(url),
            headers: {
              "Authorization": "Bearer ${apikey}",
              "Content-Type": "application/json"
            },
            body: jsonEncode(data));

        var jsonResponse = jsonDecode(res.body);

        selectedImage = jsonResponse['data'][0]['url'];
      } else{
        Text('ENter something');
      }



      String imageUrl = 'https://api.openai.com/v1/images/generations';
     // getAIImage();
      Dio dio = Dio();
      Response response = await dio.get(imageUrl, options: Options(responseType: ResponseType.bytes));
      Uint8List bytes = response.data;

      // Get the directory where the image will be saved
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/image.png';

      // Save the image to disk
      File file = File(filePath);
      await file.writeAsBytes(bytes);

    }catch (e) {

    }
  }
*/

/*
  Future<void> _downloadImage() async {
    // Replace <SAVE_LOCATION> with the desired location to save the generated image
 try {
   final directory = await getExternalStorageDirectory();
   final folder = Directory('${directory?.path}/chitrAI');
   if (!await folder.exists()) {
     await folder.create();
   }

   final response = await http.get(selectedImage! as Uri);
   final file = File('${folder.path}/${DateTime.now().toIso8601String()}.jpg');
   await file.writeAsBytes(response.bodyBytes);
   Text('image downloaded');
 } catch(e){
   Text('error');
 }
  }
*/

  /*

  String ? _text = '';
  bool _isSubmitEnabled = false;
  String? _selectedStyle='';
  String? _imagepath='';

  void _handleTextChange(String text) {
    setState(() {
      _text = text ;
      _isSubmitEnabled = text.isNotEmpty;
    });
  }


  void _submitHandler() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => styles()),
    );
    setState(() {
      _selectedStyle = result;
    });
  }


  void _showResult() {
    if (_selectedStyle == null) {
      return;
    }
    final result = 'You have selected $_selectedStyle with text: $_text';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(result),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  */


  String _selectedName = "";
  String _selectedImage = "";
  bool _isButtonEnabled=false;


  void _onListItemSelected(String name, String image) {
    setState(() {
      _selectedName = name;
      _selectedImage = image;
      _isButtonEnabled=true;
    });
  }



  void download() async{


    _showRewardedAd();

    setState(() {
      isdownloading = true;
    });

  //  String url='https://images.pexels.com/photos/14800043/pexels-photo-14800043.jpeg?auto=compress&cs=tinysrgb&w=300&lazy=load';
    final tempDir=await getTemporaryDirectory();
    final path='${tempDir.path}/myfile.jpg';
    await Dio().download(selectedImage!,path);
    GallerySaver.saveImage(path,albumName: 'ChitrAI');

    Fluttertoast.showToast(
        msg: "Image Downloaded!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );

    setState(() {
      isdownloading = false;
    });


  }

  void share() async{

    _showRewardedAd();
    setState(() {
      issharing = true;
    });


    //   String url='https://images.pexels.com/photos/14800043/pexels-photo-14800043.jpeg?auto=compress&cs=tinysrgb&w=300&lazy=load';
    final tempDir=await getTemporaryDirectory();
    final path='${tempDir.path}/myfile.jpg';
    await Dio().download(selectedImage!,path);
    GallerySaver.saveImage(path,albumName: 'ChitrAI');
    Fluttertoast.showToast(
        msg: "Processing..",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Share.shareFiles([path]);


    setState(() {
      issharing = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return
    SafeArea(
      child: Stack(
        children: [

          Container(
           // margin: EdgeInsets.only(top: 60),
            
            
            child: Scaffold(
 
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title: Image.asset('images/g.png',height: 33,),
                actions: [
                  IconButton(
                    onPressed: () async {

                      const url = 'https://discord.gg/8D6cxwfT';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  icon:Icon(  Icons.discord,color: Colors.indigoAccent,size: 40),

                  ),
                  SizedBox(width: 33,),


                  /*
                  InkWell(
                      onTap: (){
/*
                        showDialog(context: context, builder: (_){return Dialog(

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20,left: 15,right: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset('images/pro.png'),
                                  SizedBox(height: 10,),
                                  Text('Unleash your',style: TextStyle(fontSize: 28,fontWeight: FontWeight.w400),),
                                  SizedBox(height: 8,),

                                  Text('Creativity',style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 23,),
                                  Row(

                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.check_circle,color: Colors.grey,),
                                          SizedBox(width: 7,),
                                          Text('Remove Ads',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),



                                    ],
                                  ),
                                      SizedBox(width: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.check_circle,color: Colors.grey),
                                          SizedBox(width: 7,),
                                          Text('Faster Processing',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                        ],
                                      ),

                                ],
                              ),
                                  SizedBox(height: 20,),
                                  Row(

                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.check_circle,color: Colors.grey),
                                          SizedBox(width: 7,),
                                          Text('No Watermark',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),



                                        ],
                                      ),
                                      SizedBox(width: 8,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.check_circle,color: Colors.grey),
                                          SizedBox(width: 7,),
                                          Text('Aspect Ratios',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                        ],
                                      ),

                                    ],
                                  ),


                                  SizedBox(height: 22,),
                                  Row(
                                    children: [

                                      InkWell(
                                        onTap: () => setState(() => selectedButtonIndex = 0),
                                        child: Container(
                                          height: 85,
                                          width:85,

                                          decoration: BoxDecoration(
                                            color: selectedButtonIndex == 0 ? Colors.yellow.shade600 : Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(16)
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 3,right: 47),
                                                child: Icon(Icons.circle_outlined),
                                              ),
                                              SizedBox(height: 25,),
                                              Text('Lifetime',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      InkWell(
                                        onTap: () => setState(() => selectedButtonIndex = 1),
                                        child: Container(
                                          height: 85,
                                          width:85 ,
                                          decoration: BoxDecoration(
                                              color: selectedButtonIndex == 1 ? Colors.yellow.shade600 : Colors.grey.shade200,
                                              borderRadius: BorderRadius.circular(16)
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 3,right: 47),
                                                child: Icon(Icons.circle_outlined),
                                              ),
                                              SizedBox(height: 25,),
                                              Text('Weekly',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      InkWell(
                                        onTap: () => setState(() => selectedButtonIndex = 2),
                                        child: Container(
                                          height: 85,
                                          width:85 ,
                                          decoration: BoxDecoration(
                                              color: selectedButtonIndex == 2 ? Colors.yellow.shade600 : Colors.grey.shade200,
                                              borderRadius: BorderRadius.circular(16)
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 3,right: 47),
                                                child: Icon(Icons.check_circle),
                                              ),
                                              SizedBox(height: 25,),
                                              Text('Yearly',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                            ],
                                          ),
                                        ),
                                      )



                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Container(
                                    height: 60,
                                    width:300 ,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(16)
                                    ),
                                    child: Row(
                                    //  mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 100,),
                                        Text('Continue',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
                                        SizedBox(width: 90,),
                                        Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 23),
                                    child: Text('Yearly Payment is 12345',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                                  ),

                              ]
                          ),
                            )
                          );});

                       */
// TO SHOW INERTIAL ADD
     _showInterstitialAd();
                      Navigator.of(context).push(
                         CupertinoPageRoute(
                           fullscreenDialog: true,
                             builder: (_)=>propage())

                      );



                      },
                      child: Image.asset('images/z.png',height: 25,)),
               */

                ],
                
              ),
              
             body: SingleChildScrollView(
               child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 10,left: 15,right: 8),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         /*
                         Row(
                           children: [
                             InkWell(
                                 onTap: (){

                                   setState(() {
                                     _button1Selected = true;
                                     _button2Selected = false;
                                   });
                                 },
                                // color: _button1Selected?Colors.indigoAccent.shade100:Colors.grey.shade300,

                     //  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),

                                 child: Container(

                                   height: 40,
                                   width: 90,
                                   decoration: BoxDecoration(
                                       color: _button1Selected?Colors.indigoAccent.shade100:Colors.grey.shade300,
                                       borderRadius: BorderRadius.circular(25)
                                   ),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Text('T',style: TextStyle(fontSize: 20),),
                                       SizedBox(width: 6,),
                                       Text('Text'),
                                     ],
                                   ),
                                 )

                             ),
                             SizedBox(width: 6,),
                             InkWell(
                                 onTap: (){
                                   setState(() {
                                     _button2Selected = true;
                                     _button1Selected = false;
                                   });
                                 },
                               //  color: _button2Selected?Colors.indigoAccent.shade100:Colors.grey.shade300,

                              //   shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),

                                 child: Container(
                                   height: 40,
                                   width: 150,
                                   alignment: Alignment.center,
                                   decoration: BoxDecoration(
                                       color: _button2Selected?Colors.indigoAccent.shade100:Colors.grey.shade300,
                                     borderRadius: BorderRadius.circular(25)
                                   ),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Icon(Icons.image_rounded),
                                       SizedBox(width: 6,),
                                       Text('Image Remix'),
                                     ],
                                   ),
                                 )

                             )
                           ],
                         ),
                        */
                        SizedBox(height: 14,),
                         Text('Enter Prompt',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                         SizedBox(height: 14,),
                         Container(
                           height: _wordCount * 30.0 + 120.0,
                           width: 350,
                           alignment: Alignment.center,
                           padding: EdgeInsets.only(left: 15,),
                           decoration: BoxDecoration(
                               //color: Colors.indigoAccent,
                               border: Border.all(color: Colors.indigoAccent)
                               ,borderRadius: BorderRadius.circular(26)
                           ),
                           child: Column(
                             children: [
                               Expanded(
                                 child: TextField(
                 controller: _promptContoller,
                                   maxLines: 6,
                                   onChanged: _wordCountChanged,
                                   decoration: InputDecoration(
                                     hintText: " What do you want to create ?",
                                     hintStyle: TextStyle(color: Colors.grey),
                                     border: InputBorder.none,

                                   ),
                                   cursorColor: Colors.black,

                                 ),
                               ),

                               Align(
                                 alignment: Alignment.bottomRight,
                                 child: IconButton(
                                   icon: Icon(Icons.cancel),
                                   onPressed: _clearText,
                                 ),
                               ),
                            //   SizedBox(height: 16.0),

                       /*
                               MaterialButton(
                                 color: _wordCount > 3 ? Colors.blue : Colors.grey,
                                 onPressed: () {},
                                 child: Text('Submit'),
                               ),
                     */
                             ],
                           )
                         ),
                         SizedBox(height: 14,),
                         Text('Select Style',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                         SizedBox(height: 14,),

                         /*
                         _selectedStyle != null?
                         InkWell(
                           onTap: (){
                             setState(() {

                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => styles()),
                               );

                             });
                           },
                           child: Container(
                             height:70,
                             width: 350,
                             alignment: Alignment.center,
                             padding: EdgeInsets.only(left: 15),
                             decoration: BoxDecoration(
                                 color:  Colors.grey.shade300,
                                 //  border: Border.all(color: Colors.indigoAccent)
                                 borderRadius: BorderRadius.circular(20)
                             ),
                             child:




                             Row(
                               children: [
                                 SizedBox(width: 10,),
                                Image.asset('images/add.png',height: 30,

                                  // color:  _promptContoller.text.isNotEmpty?Colors.white:   Colors.grey,

                                 ),
                               //  SizedBox(width: 10,),


                                 Text(




                                   _selectedStyle!,
                                   style: TextStyle(fontSize:15,fontWeight: FontWeight.w500,color:    Colors.grey),),
                                 SizedBox(width: 210,),
                                 Image.asset('images/s.png',height: 23,color:  _promptContoller.text.isNotEmpty?Colors.white:Colors.grey,),

                               ],
                             ),

                           ),
                         ):
                             */
                     _isButtonEnabled?
                         InkWell(
                           onTap:  () {
                             setState(() {
                               _showRewardedAd();
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => styles(
                                     onListItemSelected: _onListItemSelected,

                                   ),
                                 ),
                               );

                             });
                           },


                           child: Container(
                             height:70,
                             width: 350,
                             alignment: Alignment.center,
                             padding: EdgeInsets.only(left: 2),
                             decoration: BoxDecoration(
                                 color:  Colors.grey.shade300,
                                 //  border: Border.all(color: Colors.indigoAccent)
                                 borderRadius: BorderRadius.circular(20)
                             ),
                             child:




                             Row(
                               children: [
                               //  SizedBox(width: 2,),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child:

                                    //_isButtonEnabled?
                                    Image.asset(_selectedImage,height: 64,

                               //    color:  _promptContoller.text.isNotEmpty?Colors.white:   Colors.grey,

                                 )
                                          //:Text('')
                                  ),
                                  SizedBox(width: 10,),




                                 Text(
                                //   _isButtonEnabled?
                                   _selectedName
                                  //     :'Please select Style           '
                                     ,

                                   style: TextStyle(fontSize:15,fontWeight: FontWeight.w500,color: Colors.grey.shade800),),
                                 SizedBox(width: 32,),
                                 Text(
                                   //   _isButtonEnabled?
                                   "View more"
                                   //     :'Please select Style           '
                                   ,

                                   style: TextStyle(fontSize:12,fontWeight: FontWeight.w500,color: Colors.grey.shade700),),
                                SizedBox(width: 7,),
                                 Image.asset('images/s.png',height: 23,color: Colors.grey.shade800,),
                               ],
                             ),

                           ),
                         ):

                         InkWell(
                           onTap:  () {

                             setState(() {
                               _showRewardedAd();
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => styles(
                                     onListItemSelected: _onListItemSelected,

                                   ),
                                 ),
                               );

                             });
                           },


                           child: Container(
                             height:70,
                             width: 350,
                             alignment: Alignment.center,
                             padding: EdgeInsets.only(left: 15),
                             decoration: BoxDecoration(
                                 color:  Colors.grey.shade300,
                                 //  border: Border.all(color: Colors.indigoAccent)
                                 borderRadius: BorderRadius.circular(20)
                             ),
                             child:




                             Row(
                               children: [
                                 SizedBox(width: 10,),






                                 Text(
                                   "Plese Select Style",

                                   style: TextStyle(fontSize:15,fontWeight: FontWeight.w500,color: Colors.grey.shade800),),
                                 SizedBox(width: 150,),
                                 Icon(Icons.add_circle,size: 25,color: Colors.grey.shade800,)
                               ],
                             ),

                           ),
                         ),



        /*
                         SizedBox(height: 14,),
                         Text('Aspect Ratio',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                         SizedBox(height: 10,),
                         SingleChildScrollView(
                           scrollDirection: Axis.horizontal,
                           child: Row(

                             children: [
                               InkWell(
                                   onTap: (){
                                     setState(() {
                                     //  selectedButtonIndex=0;




                                     });
                                   },
                                  // color: Colors.black,
                                 //  minWidth: 60,
                                 //  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),

                                   child: Container(

                                       height: 37,
                                       width: 68,
                                       alignment: Alignment.center,
                                       decoration: BoxDecoration(
                                           color: selectedButtonIndex == 0 ? Colors.grey.shade800 : Colors.grey.shade300,



                                           borderRadius: BorderRadius.circular(25)
                                       ),

                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           Container(
                                             height: 15,
                                             width: 15,
                                             decoration: BoxDecoration(
                                               color: selectedButtonIndex == 0 ? Colors.white : Colors.grey.shade800,
                                               borderRadius: BorderRadius.circular(3),
                                             ),
                                           ),
                                           SizedBox(width: 6,),
                                           Text('1:1',style: TextStyle(  color: selectedButtonIndex == 0 ? Colors.white : Colors.grey.shade800,),),
                                         ],
                                       ))
                               ),
                               SizedBox(width: 9,),
                               InkWell(
                                 // onPressed: (){},
                                 // color: Colors.black,
                                 //  minWidth: 60,
                                 //  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                   onTap: (){
                                     setState(() {
                                      // selectedButtonIndex=1;
                                       Navigator.of(context).push(
                                           CupertinoPageRoute(
                                               fullscreenDialog: true,
                                               builder: (_)=>propage())

                                       );



                                     });
                                   },
                                   child: Container(

                                       height: 37,
                                       width: 68,
                                       alignment: Alignment.center,
                                       decoration: BoxDecoration(
                                           color: selectedButtonIndex == 1? Colors.grey.shade800 : Colors.grey.shade300,
                                           borderRadius: BorderRadius.circular(25)
                                       ),

                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           Container(
                                             height: 15,
                                             width: 7,
                                             decoration: BoxDecoration(
                                               color: selectedButtonIndex == 1 ? Colors.white : Colors.grey.shade800,
                                               borderRadius: BorderRadius.circular(2),
                                             ),
                                           ),
                                           SizedBox(width: 6,),
                                           Text('9:16',style: TextStyle(  color: selectedButtonIndex == 1 ? Colors.white : Colors.grey.shade800,),),
                                         ],
                                       ))
                               ),
                               SizedBox(width: 9,),
                               InkWell(
                                 // onPressed: (){},
                                 // color: Colors.black,
                                 //  minWidth: 60,
                                 //  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                   onTap: (){
                                     setState(() {
                                       Navigator.of(context).push(
                                           CupertinoPageRoute(
                                               fullscreenDialog: true,
                                               builder: (_)=>propage())

                                       );
                                     //  selectedButtonIndex=2;


                                     });
                                   },
                                   child: Container(

                                       height: 37,
                                       width: 68,
                                       alignment: Alignment.center,
                                       decoration: BoxDecoration(
                                           color: selectedButtonIndex == 2 ? Colors.grey.shade800 : Colors.grey.shade300,
                                           borderRadius: BorderRadius.circular(25)
                                       ),

                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           Container(
                                             height: 6,
                                             width: 15,
                                             decoration: BoxDecoration(
                                               color: selectedButtonIndex == 2 ? Colors.white : Colors.grey.shade800,
                                               borderRadius: BorderRadius.circular(2),
                                             ),
                                           ),
                                           SizedBox(width: 6,),
                                           Text('16:9',style: TextStyle(  color: selectedButtonIndex == 2 ? Colors.white : Colors.grey.shade800,),),
                                         ],
                                       ))
                               ),
                               SizedBox(width: 9,),
                               InkWell(
                                   onTap: (){
                                     setState(() {
                                      // selectedButtonIndex=3;

                                       Navigator.of(context).push(
                                           CupertinoPageRoute(
                                               fullscreenDialog: true,
                                               builder: (_)=>propage())

                                       );
                                     });
                                   },
                                 // onPressed: (){},
                                 // color: Colors.black,
                                 //  minWidth: 60,
                                 //  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),

                                   child: Container(

                                       height: 37,
                                       width: 68,
                                       alignment: Alignment.center,
                                       decoration: BoxDecoration(
                                           color: selectedButtonIndex == 3? Colors.grey.shade800 : Colors.grey.shade300,
                                           borderRadius: BorderRadius.circular(25)
                                       ),

                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           Container(
                                             height: 15,
                                             width: 12,
                                             decoration: BoxDecoration(
                                               color: selectedButtonIndex == 3 ? Colors.white : Colors.grey.shade800,
                                               borderRadius: BorderRadius.circular(3),
                                             ),
                                           ),
                                           SizedBox(width: 6,),
                                           Text('3:4',style: TextStyle(  color: selectedButtonIndex == 3 ? Colors.white : Colors.grey.shade800,),),
                                         ],
                                       ))
                               ),
                               SizedBox(width: 9,),
                               InkWell(
                                 // onPressed: (){},
                                 // color: Colors.black,
                                 //  minWidth: 60,
                                 //  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                   onTap: (){
                                     setState(() {
                                      // selectedButtonIndex=4;

                                       Navigator.of(context).push(
                                           CupertinoPageRoute(
                                               fullscreenDialog: true,
                                               builder: (_)=>propage())

                                       );
                                     });
                                   },

                                   child: Container(

                                       height: 37,
                                       width: 68,
                                       alignment: Alignment.center,
                                       decoration: BoxDecoration(
                                        color:   selectedButtonIndex == 4 ? Colors.grey.shade800 : Colors.grey.shade300,
                                           borderRadius: BorderRadius.circular(25)
                                       ),

                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           Container(
                                             height: 12,
                                             width: 15,
                                             decoration: BoxDecoration(
                                               color: selectedButtonIndex == 4 ? Colors.white : Colors.grey.shade800,
                                               borderRadius: BorderRadius.circular(3),
                                             ),
                                           ),
                                           SizedBox(width: 6,),
                                           Text('4:3',style: TextStyle(  color: selectedButtonIndex == 4 ? Colors.white : Colors.grey.shade800,),),
                                         ],
                                       ))
                               ),
                               SizedBox(width: 9,),
                               InkWell(
                                 // onPressed: (){},
                                 // color: Colors.black,
                                 //  minWidth: 60,
                                 //  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                   onTap: (){
                                     setState(() {
                                     //  selectedButtonIndex=5;

                                       Navigator.of(context).push(
                                           CupertinoPageRoute(
                                               fullscreenDialog: true,
                                               builder: (_)=>propage())

                                       );
                                     });
                                   },

                                   child: Container(

                                       height: 37,
                                       width: 68,
                                       alignment: Alignment.center,
                                       decoration: BoxDecoration(
                                        color:   selectedButtonIndex == 5 ? Colors.grey.shade800 : Colors.grey.shade300,
                                           borderRadius: BorderRadius.circular(25)
                                       ),

                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           Container(
                                             height: 15,
                                             width: 10,
                                             decoration: BoxDecoration(
                                               color: selectedButtonIndex == 5 ? Colors.white : Colors.grey.shade800,
                                               borderRadius: BorderRadius.circular(3),
                                             ),
                                           ),
                                           SizedBox(width: 6,),
                                           Text('2:3',style: TextStyle(  color: selectedButtonIndex == 5 ? Colors.white : Colors.grey.shade800,),),
                                         ],
                                       ))
                               ),
                               SizedBox(width: 9,),
                               InkWell(
                                 // onPressed: (){},
                                 // color: Colors.black,
                                 //  minWidth: 60,
                                 //  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                   onTap: (){
                                     setState(() {
                                     //  selectedButtonIndex=6;
                                       Navigator.of(context).push(
                                           CupertinoPageRoute(
                                               fullscreenDialog: true,
                                               builder: (_)=>propage())

                                       );

                                     });
                                   },

                                   child: Container(

                                       height: 37,
                                       width: 68,
                                       alignment: Alignment.center,
                                       decoration: BoxDecoration(
                                           color:   selectedButtonIndex == 6 ? Colors.grey.shade800 : Colors.grey.shade300,
                                           borderRadius: BorderRadius.circular(25)
                                       ),

                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           Container(
                                             height: 10,
                                             width: 15,
                                             decoration: BoxDecoration(
                                               color: selectedButtonIndex == 6? Colors.white : Colors.grey.shade800,
                                               borderRadius: BorderRadius.circular(3),
                                             ),
                                           ),
                                           SizedBox(width: 6,),
                                           Text('3:2',style: TextStyle(  color: selectedButtonIndex == 6 ? Colors.white : Colors.grey.shade800,),),
                                         ],
                                       ))
                               ),

                             ],
                           ),
                         ),
*/
                         SizedBox(height: 14,),


                         InkWell(
                           onTap: (){
                             setState(() {

                               getAIImage();

                             });
                           },
                           child: Container(
                               height:70,
                               width: 350,
                               alignment: Alignment.center,
                               padding: EdgeInsets.only(left: 15),
                               decoration: BoxDecoration(
                                 color:  _promptContoller.text.isNotEmpty?Colors.black:Colors.grey.shade300
                                 //  border: Border.all(color: Colors.indigoAccent)
                                   ,borderRadius: BorderRadius.circular(20)
                               ),
                              child:

                              isloading
                                  ?

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10,),
                                  Text('Your Image is On the Way!',style: TextStyle(fontSize:16,fontWeight: FontWeight.w500,color: Colors.white),),

                                ],
                              )
                                  :


                              Row(
                                children: [
                                  SizedBox(width: 80,),
                                  Image.asset('images/add.png',height: 30,

                                    color:  _promptContoller.text.isNotEmpty?Colors.white:   Colors.grey,

                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 15,),
                                      Text('Genrate',style: TextStyle(fontSize:21,fontWeight: FontWeight.w500,color: _promptContoller.text.isNotEmpty?Colors.white:   Colors.grey),),
                                      Text('Watch an ad',style: TextStyle(fontSize:15,fontWeight: FontWeight.w500,color:   _promptContoller.text.isNotEmpty?Colors.white: Colors.grey),),
                                    ],
                                  ),
                                  SizedBox(width: 80,),
                                  Image.asset('images/s.png',height: 23,color:  _promptContoller.text.isNotEmpty?Colors.white:Colors.grey,),
                                ],
                              ),

                           ),
                         ),
                         SizedBox(height: 27,),
                        
/*
                         Container(
                             height: 300,
                             width: 350,
                             margin: EdgeInsets.only(left: 6),
                             decoration: BoxDecoration(
                               color: Colors.grey,
                               borderRadius: BorderRadius.circular(13),
                               image: DecorationImage(
                                 image:



                                 NetworkImage(
                                   selectedImage==null?a:selectedImage!,

                                 ),
                                 fit: BoxFit.cover
                               )
                             ),
                            // child: selectedImage==null?Text(''): Image.network(selectedImage!,fit: BoxFit.cover,)),

             ),
                         */


                         selectedImage==null?
                         Row(

                           children: [
                             Image.asset('images/propmt.png',height: 200,),
                             SizedBox(width: 16,),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text('Write Your  ',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.w600,letterSpacing: 1),),
                                 Text('Imagination',style: TextStyle(color: Colors.indigoAccent,fontSize: 35,fontWeight: FontWeight.w600,),),

                                 Text('Above!  ',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.w600,letterSpacing: 2),),
                               ],
                             ),

                           ],
                         ):

                         Container(
                           height: 510,
                           width: 500,
                           padding: EdgeInsets.only(left: 11),
                           decoration: BoxDecoration(
                             color: Colors.grey.shade300,
                             borderRadius: BorderRadius.circular(15)
                           ),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                              SizedBox(height: 20,),
                               Text('Result',style: TextStyle(fontSize:21,fontWeight: FontWeight.w600,color: Colors.black,letterSpacing: 2),),
                               SizedBox(height: 10,),
                               ClipRRect(

                                   borderRadius: BorderRadius.circular(16),
                                   child: Image.network(selectedImage!,fit: BoxFit.cover,height: 350,)),
                               SizedBox(height: 20,),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   selectedImage == null
                                       ? Container()
                                       :
                                   InkWell(
                                     onTap:()  {

                                       setState(() {
                                         download();
                                       });


                                     },
                                     splashColor: Colors.indigo,
                                     child: Container(
                                       height: 60,
                                       width: 170,
                                       alignment: Alignment.center,
                                       decoration: BoxDecoration(
                                           color: Colors.indigoAccent,
                                           borderRadius: BorderRadius.circular(13)
                                       ),
                                       child:

                                       isdownloading
                                           ?

                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           CircularProgressIndicator(
                                             color: Colors.white,
                                            // strokeWidth: 1,

                                           ),
                                           SizedBox(width: 8,),
                                           Text('Downloading...',style: TextStyle(fontSize:16,fontWeight: FontWeight.w500,color: Colors.white),),
                                         ],
                                       )
                                           :



                                       Text('Download',style: TextStyle(color: Colors.white),),
                                     ),
                                   ),
                                   SizedBox(width: 7,),

                                   selectedImage == null
                                       ? Container()
                                       :
                                   InkWell(
                                     onTap: ()  {

                                       setState(() {
                                         share();
                                       });


                                     },

                                     child: Container(
                                       height: 60,
                                       width: 170,
                                       alignment: Alignment.center,
                                       decoration: BoxDecoration(
                                           color: Colors.black,
                                           borderRadius: BorderRadius.circular(13)
                                       ),
                                       child:issharing
                                           ?

                                       Row(

                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           CircularProgressIndicator(
                                             color: Colors.white,
                                           ),
                                           SizedBox(width: 8,),
                                           Text('Loading...',style: TextStyle(fontSize:16,fontWeight: FontWeight.w500,color: Colors.white),),

                                         ],
                                       )
                                           :



                                       Text('Share',style: TextStyle(color: Colors.white),),
                                     ),
                                   ),

                                 ],
                               ),
                             //  SizedBox(height: 20,),
                             ],
                           ),
                         ),

                         
                         
                         SizedBox(height: 20,),



                         SizedBox(height: 20,),
                       ],
                     ),
                   ),

                   Container(
                     height:1180,
                     width: double.infinity,
                     decoration: BoxDecoration(
                       color: Colors.grey.shade300
                     ),
                     child: Padding(
                       padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('Inspirations!',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                           SizedBox(
                             height: 15,
                           ),

                           Row(
      mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Container(
                                     height:175,
                                     width: 175,
                                     decoration: BoxDecoration(
                                         color: Colors.pink,
                                         image: DecorationImage(
                                           image: AssetImage('images/p1.png',),
                                           fit: BoxFit.fill
                                         ),
                                         borderRadius: BorderRadius.circular(18)
                                     ),


                                   ),
                               SizedBox(height: 6,),

                               Text('Mechanical Dawn, Technology City, ',style: TextStyle(fontSize: 11),),
                                   Text(' epic fantasy art ',style: TextStyle(fontSize: 12),),

                                 ],
                               ),
                               SizedBox(width: 16,),

                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Container(
                                     height:175,
                                     width: 175,
                                     decoration: BoxDecoration(
                                         color: Colors.pink,
                                         image: DecorationImage(
                                             image: AssetImage('images/p4.png',),
                                             fit: BoxFit.fill
                                         ),
                                         borderRadius: BorderRadius.circular(18)
                                     ),


                                   ),
                                   SizedBox(height: 6,),

                                   Text('delorean in a cyberpunk city with , ',style: TextStyle(fontSize: 11),),
                                   Text(' skyscrapers ',style: TextStyle(fontSize: 12),),

                                 ],
                               ),












                             ],
                           ),

                           SizedBox(height: 14,),

                           Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Container(
                                     height:175,
                                     width: 175,
                                     decoration: BoxDecoration(
                                         color: Colors.pink,
                                         image: DecorationImage(
                                             image: AssetImage('images/p2.png',),
                                             fit: BoxFit.fill
                                         ),
                                         borderRadius: BorderRadius.circular(18)
                                     ),


                                   ),
                                   SizedBox(height: 6,),

                                   Text('A cyberpunk monster in a control  ',style: TextStyle(fontSize: 11),),
                                   Text(' room ',style: TextStyle(fontSize: 12),),

                                 ],
                               ),
                               SizedBox(width: 16,),

                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Container(
                                     height:175,
                                     width: 175,
                                     decoration: BoxDecoration(
                                         color: Colors.pink,
                                         image: DecorationImage(
                                             image: AssetImage('images/p11.png',),
                                             fit: BoxFit.fill
                                         ),
                                         borderRadius: BorderRadius.circular(18)
                                     ),


                                   ),
                                   SizedBox(height: 6,),

                                   Text('Interior of a futuristic bedroom',style: TextStyle(fontSize: 11),),
                                   Text(' cluttred with electronics,',style: TextStyle(fontSize: 12),),

                                 ],
                               ),












                             ],
                           ),

                           SizedBox(height: 14,),

                           Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Container(
                                     height:175,
                                     width: 175,
                                     decoration: BoxDecoration(
                                         color: Colors.pink,
                                         image: DecorationImage(
                                             image: AssetImage('images/p5.png',),
                                             fit: BoxFit.fill
                                         ),
                                         borderRadius: BorderRadius.circular(18)
                                     ),


                                   ),
                                   SizedBox(height: 6,),

                                   Text(' portrait neon operator girl,  ',style: TextStyle(fontSize: 11),),
                                   Text('  reflective puffy coat ',style: TextStyle(fontSize: 12),),

                                 ],
                               ),
                               SizedBox(width: 16,),

                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Container(
                                     height:175,
                                     width: 175,
                                     decoration: BoxDecoration(
                                         color: Colors.pink,
                                         image: DecorationImage(
                                             image: AssetImage('images/p12.png',),
                                             fit: BoxFit.fill
                                         ),
                                         borderRadius: BorderRadius.circular(18)
                                     ),


                                   ),
                                   SizedBox(height: 6,),

                                   Text('giant robot stands over city by ',style: TextStyle(fontSize: 11),),
                                   Text(' simon stalenhag ',style: TextStyle(fontSize: 12),),

                                 ],
                               ),












                             ],
                           ),

                           SizedBox(height: 14,),

                           Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Container(
                                     height:175,
                                     width: 175,
                                     decoration: BoxDecoration(
                                         color: Colors.pink,
                                         image: DecorationImage(
                                             image: AssetImage('images/p7.png',),
                                             fit: BoxFit.fill
                                         ),
                                         borderRadius: BorderRadius.circular(18)
                                     ),


                                   ),
                                   SizedBox(height: 6,),

                                   Text('detailed portrait neon guard girl ',style: TextStyle(fontSize: 11),),
                                   Text(' with very short brown hair ',style: TextStyle(fontSize: 12),),

                                 ],
                               ),
                               SizedBox(width: 16,),

                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Container(
                                     height:175,
                                     width: 175,
                                     decoration: BoxDecoration(
                                         color: Colors.pink,
                                         image: DecorationImage(
                                             image: AssetImage('images/p8.png',),
                                             fit: BoxFit.fill
                                         ),
                                         borderRadius: BorderRadius.circular(18)
                                     ),


                                   ),
                                   SizedBox(height: 6,),

                                   Text('5 cars driving down a street   ',style: TextStyle(fontSize: 11),),
                                   Text(' in the city  of Eindhoven . ',style: TextStyle(fontSize: 12),),

                                 ],
                               ),












                             ],
                           ),

                           SizedBox(height: 14,),

                           Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Container(
                                     height:175,
                                     width: 175,
                                     decoration: BoxDecoration(
                                         color: Colors.pink,
                                         image: DecorationImage(
                                             image: AssetImage('images/p14.png',),
                                             fit: BoxFit.fill
                                         ),
                                         borderRadius: BorderRadius.circular(18)
                                     ),


                                   ),
                                   SizedBox(height: 6,),

                                   Text('picture spiritual native american  ',style: TextStyle(fontSize: 11),),
                                   Text(' man standing on mars look ',style: TextStyle(fontSize: 12),),

                                 ],
                               ),
                               SizedBox(width: 16,),

                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Container(
                                     height:175,
                                     width: 175,
                                     decoration: BoxDecoration(
                                         color: Colors.pink,
                                         image: DecorationImage(
                                             image: AssetImage('images/p15.png',),
                                             fit: BoxFit.fill
                                         ),
                                         borderRadius: BorderRadius.circular(18)
                                     ),


                                   ),
                                   SizedBox(height: 6,),

                                   Text('a man and his son facing the  , ',style: TextStyle(fontSize: 11),),
                                   Text(' desperate call of the void',style: TextStyle(fontSize: 12),),

                                 ],
                               ),












                             ],
                           ),

































                         ],
                       ),
                     ),
                   ),



                 ],
               ),
             ),





            ),
          ),


          // TO SHOW BANNER ADD AFTER  PUBLISHED APP


          if (_banner != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: _banner!.size.width.toDouble(),
                height: _banner!.size.height.toDouble(),
                child: AdWidget(ad: _banner!),
              ),
            ),


/*
          Container(
            height:60,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Image.asset('images/g.png',height: 30,),
                  SizedBox(width: 160,),
                  
                    Container(
                      height:30,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.indigoAccent
                              ,borderRadius: BorderRadius.circular(22)
                      ),
                      child: Icon(Icons.discord,color: Colors.white,),
                    ),

                  SizedBox(width: 8,),
                  Image.asset('images/c.png',height: 37,),

                ],
              ),
            ),
          ),

          */

        ],

      ),
    );
  }



}



