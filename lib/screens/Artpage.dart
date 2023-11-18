/*
import 'dart:convert';
import 'dart:io';

import 'package:chitrai/screens/Artpage.dart';
import 'package:chitrai/screens/home.dart';
import 'package:chitrai/screens/share.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';



class artpage extends StatefulWidget {
  final String  ? selectedImage;

  final String prompt;
   artpage({Key? key,required this.selectedImage,required this.prompt}) : super(key: key);

  @override
  State<artpage> createState() => _artpageState();
}

class _artpageState extends State<artpage> {


  TextEditingController _editpromptContoller=TextEditingController();
  int _wordCount = 0;
  bool _showCancelIcon = false;
   String  ? artimage;
 String   ? editedartimage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _editpromptContoller= TextEditingController();

    loadImage();
  }

  @override
  void dispose() {
    _editpromptContoller.dispose();
    super.dispose();
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
      _editpromptContoller.clear();
      _wordCount = 0;
    });
  }

  String apikey = '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';
  String url = 'https://api.openai.com/v1/images/generations';
  bool _imagecheck=false;

  void getAIImage() async{

    setState(() {
      isLoading = false;
    });

    if(widget.prompt.isNotEmpty){



      var data ={
        "prompt": widget.prompt,
        "n": 1,
        "size": "256x256",
      };

      var res = await http.post(Uri.parse(url),
          headers: {"Authorization":"Bearer ${apikey}","Content-Type": "application/json"},
          body:jsonEncode(data));

      var jsonResponse = jsonDecode(res.body);

      artimage= jsonResponse['data'][0]['url'];




    }else{
      print("Enter something");
    }

    setState(() {
      isLoading = true;
    });

  }



  void geteditedAIImage() async{

    setState(() {
      isLoading = false;
    });

    if(_editpromptContoller.text.isNotEmpty){
     Navigator.pop(context);
      var data ={
        "prompt": _editpromptContoller.text,
        "n": 1,
        "size": "256x256",
      };

      var res = await http.post(Uri.parse(url),
          headers: {"Authorization":"Bearer ${apikey}","Content-Type": "application/json"},
          body:jsonEncode(data));

      var jsonResponse = jsonDecode(res.body);

      editedartimage = jsonResponse['data'][0]['url'];


      setState(() {

      });




    }else{
      print("Enter something");
    }


    setState(() {
      isLoading = true;
    });

  }





  void loadImage() async {
    // Simulate a delay to show the shimmer effect while loading
    await Future.delayed(Duration(seconds: 10));

    setState(() {
      isLoading = false;
    });
  }


void saveimage() async {



  /*
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => share(
                selectedartImage:

                artimage != null ? artimage ?? "" :
                widget.selectedImage ,

                editedprompt: _editpromptContoller.text ,
                editedpromptimage: editedartimage ?? ""


            )

        )


    );

    */


/*
  var response;
  try {
    response = await http.get(Uri.parse(widget.selectedImage ));
  } catch (e) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("An error occurred while downloading the image"),
      ),
    );
    return;
  }

  if (response.statusCode != 200) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("An error occurred while downloading the image"),
      ),
    );
    return;
  }

  var folder = await getApplicationDocumentsDirectory();
  var folderPath = "${folder.path}/downloaded_images";
  var directory = Directory(folderPath);

  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }

  var filePath = "$folderPath/${DateTime.now().millisecondsSinceEpoch}.jpg";
  File(filePath).writeAsBytesSync(response.bodyBytes);
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text("Image downloaded to $filePath"),
    ),
  );


*/





}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: 







        Column(
            children: [
              Row(
                children: [

                  SizedBox(width: 3,),


                  IconButton(

                      onPressed: (){

                        setState(() {




                          /*

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const home()),
                        );  */
                          showDialog(context: context, builder: (_){
                            return  Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                              //  crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20,),
                                  Text("Discard Results?",style:TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
                                  SizedBox(height: 18,),
                                  Text("All the changes made will be lost",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w400,),),
                                  SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 21,),
                                      InkWell(
                                       // height: 49,
                                          onTap: (){

                                            setState(() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => const home()),
                                              );
                                            });
                                          },
                                        //  color: Colors.grey.shade500,

                                        //  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),

                                          child: Container(

                                              height: 50,
                                              width: 100,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  borderRadius: BorderRadius.circular(11)
                                              ),

                                              child: Text('     Discard     ',style: TextStyle(fontSize: 16,color: Colors.black),))

                                      ),

                                      SizedBox(width: 30,),
                                    InkWell  (
                                       // height: 49,
                                        //  minWidth: 60,
                                          onTap: (){

                                            setState(() {
                                              Navigator.pop(context);
                                            });
                                          },
                                     //     color: Colors.black,

                                    //      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),

                                          child: Container(


                                              height: 50,
                                              width: 100,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(11)
                                              ),

                                              child: Text('     Cancel     ',style: TextStyle(fontSize: 16,color: Colors.white),))

                                      ),
                                      SizedBox(height: 40,),

                                    ],
                                  ),
                                  SizedBox(height: 21,),
                                ],
                              ),

                            );

                          }


                          );




                        });

                      },

                      icon: Icon(Icons.arrow_back)),
                  SizedBox(width: 6,),
                  Text('Results',style: TextStyle(fontSize: 22),),
                  SizedBox(width: 167,),
                  InkWell(
                      onTap: () {







                     saveimage();









                      },
                  //    color: Colors.black,

                   //   shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),

                      child: Container(

                        height: 40,
                        width: 90,

                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25)
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Save',style: TextStyle(fontSize: 20,color: Colors.white),),
                            SizedBox(width: 4,),
                            Icon(Icons.arrow_circle_down_outlined,color: Colors.white,)
                          ],
                        ),
                      )

                  ),
                ],
              ),

              SizedBox(height: 10,),

              Container(
                height: 709,
                width: double.infinity,
                padding: EdgeInsets.only(top: 30,left: 10,right: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,

                ),
                child: Column(
                  children: [
                /*
                    Container(
                  height: 360,
                  width: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.grey.shade500,
                  ),
                      child: isLoading?Shimmer.fromColors(
                        baseColor: Colors.grey.shade500,
                        highlightColor: Colors.grey.shade100,

                  child:    Container(
                      //  height: 360,
                     //   width: 360,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.grey.shade600,
                         /*
                          image: DecorationImage(
                            image:



                            _editpromptContoller.text.isNotEmpty?NetworkImage(editedartimage!):



                            NetworkImage(
                              artimage!=null?artimage!:
                             widget.selectedImage!
                            ),


                            fit: BoxFit.fill
                          )

                           */
                        ),
                      ),

                      ):
                      _editpromptContoller.text.isNotEmpty?

                      editedartimage==null?Text(''):
                      Image.network(editedartimage!,fit: BoxFit.cover,)

                          :
                      artimage==null?Text(''):
                      Image.network(
                          artimage!=null?artimage!:
                          widget.selectedImage ,
                        fit: BoxFit.cover,
                      ),
                    ),
                    */

                    ClipRRect(
                      child: _editpromptContoller.text.isNotEmpty?

                      editedartimage==null?Text(''):
                      Image.network(editedartimage!,fit: BoxFit.cover,)

                          :

                      //  artimage==null?
                   //    widget.selectedImage==null?Text(''):
                          Image.network(
                            artimage!=null?artimage!:
                            widget.selectedImage!,

                            fit: BoxFit.cover,),
                    ),
                    SizedBox(height: 30,),

                    InkWell(
                      onTap: (){
                        setState(() {
                         showModalBottomSheet(

                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25)),
                             ),
                             context: context, builder: (_){
                           return Padding(
                             padding: const EdgeInsets.only(top: 5,left: 10,right: 10),
                             child: Column(
                               mainAxisSize: MainAxisSize.max,
                               children: [
                                 Container(
                                   height: 5,
                                   width: 65,
                                   decoration: BoxDecoration(
                                     color: Colors.grey.shade400,
                                     borderRadius: BorderRadius.circular(15)
                                   ),
                                 ),

                                 SizedBox(height: 15,),

                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Container(
                                       height:70,
                                       width: 70,
                                       decoration: BoxDecoration(
                                           color: Colors.pink,
                                           image: DecorationImage(
                                               image: AssetImage('images/z1.png',),
                                               fit: BoxFit.fill
                                           ),
                                           borderRadius: BorderRadius.circular(18)
                                       ),


                                     ),
                                     SizedBox(width: 16,),

                                     Container(
                                       height:70,
                                       width: 70,
                                       decoration: BoxDecoration(
                                           color: Colors.pink,
                                           image: DecorationImage(
                                               image: AssetImage('images/z2.png',),
                                               fit: BoxFit.fill
                                           ),
                                           borderRadius: BorderRadius.circular(18)
                                       ),


                                     ),












                                   ],
                                 ),
                                  SizedBox(height: 10,),
                                 Padding(
                                   padding: const EdgeInsets.only(left: 70),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Container(
                                         height:70,
                                         width: 70,
                                         decoration: BoxDecoration(
                                             color: Colors.pink,
                                             image: DecorationImage(
                                                 image: AssetImage('images/z3.png',),
                                                 fit: BoxFit.fill
                                             ),
                                             borderRadius: BorderRadius.circular(18)
                                         ),


                                       ),
                                       SizedBox(width: 16,),

                                       Container(
                                         height:70,
                                         width: 70,
                                         decoration: BoxDecoration(
                                             color: Colors.pink,
                                             image: DecorationImage(
                                                 image: AssetImage('images/z4.png',),
                                                 fit: BoxFit.fill
                                             ),
                                             borderRadius: BorderRadius.circular(18)
                                         ),


                                       ),












                                     ],
                                   ),
                                 ),











                                 SizedBox(height: 21,),








                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Text('Genrate ',style: TextStyle(fontSize:21,fontWeight: FontWeight.bold,color:Colors.black),),
                                     Text('More Variations',style: TextStyle(fontSize:21,fontWeight: FontWeight.bold,color:Colors.indigoAccent),),
                                   ],
                                 ),

                                 SizedBox(height: 15,),

                                 Text('Create variations of your AI genrated art! \n             The posibilities are endless.',style: TextStyle(fontSize:16,color:Colors.grey.shade600),),
                                 SizedBox(height: 15,),

                                 InkWell(
                                   onTap: (){
                                     setState(() {
                                       Navigator.pop(context);
                      getAIImage();
                                     });
                                   },
                                   child: Container(
                                     height:70,
                                     width: 350,
                                     alignment: Alignment.center,
                                     padding: EdgeInsets.only(left: 15),
                                     decoration: BoxDecoration(
                                         color:  Colors.black
                                         //  border: Border.all(color: Colors.indigoAccent)
                                         ,borderRadius: BorderRadius.circular(18)
                                     ),
                                     child: Row(
                                       children: [
                                         SizedBox(width: 80,),
                                         Image.asset('images/add.png',height: 30,

                                           color:     Colors.white,

                                         ),
                                         SizedBox(width: 10,),
                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             SizedBox(height: 15,),
                                             Text('Genrate',style: TextStyle(fontSize:21,fontWeight: FontWeight.w500,color:Colors.white),),
                                             Text('Watch an ad',style: TextStyle(fontSize:15,fontWeight: FontWeight.w500,color:   Colors.white),),
                                           ],
                                         ),
                                         SizedBox(width: 89,),
                                         Image.asset('images/s.png',height: 23,color:  Colors.white,),
                                       ],
                                     ),
                                   ),
                                 ),



                                 SizedBox(height: 15,),

                                 InkWell(
                                   onTap: (){
                                     setState(() {

                                     });
                                   },
                                   child: Container(
                                     height:70,
                                     width: 350,
                                     alignment: Alignment.center,
                                     padding: EdgeInsets.only(left: 15),
                                     decoration: BoxDecoration(
                                         color:  Colors.grey.shade200,
                                           border: Border.all(color: Colors.black,width: 2)
                                         ,borderRadius: BorderRadius.circular(18)
                                     ),
                                     child: Row(
                                       children: [
                                         SizedBox(width: 76,),
                                         Image.asset('images/crown.png',height: 30,

                                           color:     Colors.black,

                                         ),
                                         SizedBox(width: 10,),

                                         Text('Remove Ads',style: TextStyle(fontSize:21,fontWeight: FontWeight.w500,color:Colors.black),),
                                         SizedBox(width: 56,),
                                         Icon(Icons.arrow_forward)
                                       ],
                                     ),
                                   ),
                                 ),



                               ],
                             ),
                           );
                         });
                        });
                      },
                      child: Container(
                        height: 60,
                        width: 360,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.indigoAccent
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.change_circle_sharp,color: Colors.white,),
                            SizedBox(width: 3,),
                            Text('Genrate More',style: TextStyle(fontSize: 17,color: Colors.white),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),

                    InkWell(
                      onTap: (){


                        setState(() {
                          showModalBottomSheet(

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25)),
                              ),
                              context: context, builder: (_){
                            return Padding(
                              padding: const EdgeInsets.only(top: 5,left: 10,right: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.edit_outlined,color: Colors.black,),
                                      SizedBox(width: 3,),
                                      Text('Edit Prompt',style: TextStyle(fontSize: 17,color: Colors.black),),
                                    ],
                                  ),
                                  SizedBox(height: 15,),



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
                                              controller: _editpromptContoller,
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



                                  SizedBox(height: 15,),















                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        geteditedAIImage();
                                      });
                                    },
                                    child: Container(
                                      height:70,
                                      width: 350,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(left: 15),
                                      decoration: BoxDecoration(
                                          color: _editpromptContoller.text.isNotEmpty?Colors.black:Colors.grey.shade300
                                          //  border: Border.all(color: Colors.indigoAccent)
                                          ,borderRadius: BorderRadius.circular(18)
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 80,),
                                          Image.asset('images/add.png',height: 30,

                                            color:  _editpromptContoller.text.isNotEmpty?Colors.white:   Colors.grey,

                                          ),
                                          SizedBox(width: 10,),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 15,),
                                              Text('Genrate',style: TextStyle(fontSize:21,fontWeight: FontWeight.w500,color:_editpromptContoller.text.isNotEmpty?Colors.white:   Colors.grey),),
                                              Text('Watch an ad',style: TextStyle(fontSize:15,fontWeight: FontWeight.w500,color:  _editpromptContoller.text.isNotEmpty?Colors.white:   Colors.grey),),
                                            ],
                                          ),
                                          SizedBox(width: 89,),
                                          Image.asset('images/s.png',height: 23,color: _editpromptContoller.text.isNotEmpty?Colors.white:   Colors.grey,),
                                        ],
                                      ),
                                    ),
                                  ),



                                  SizedBox(height: 15,),

                                  InkWell(
                                    onTap: (){
                                      setState(() {

                                      });
                                    },
                                    child: Container(
                                      height:70,
                                      width: 350,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(left: 15),
                                      decoration: BoxDecoration(
                                          color:  Colors.grey.shade200,
                                          border: Border.all(color: Colors.black,width: 2)
                                          ,borderRadius: BorderRadius.circular(18)
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 76,),
                                          Image.asset('images/crown.png',height: 30,

                                            color:     Colors.black,

                                          ),
                                          SizedBox(width: 10,),

                                          Text('Remove Ads',style: TextStyle(fontSize:21,fontWeight: FontWeight.w500,color:Colors.black),),
                                          SizedBox(width: 56,),
                                          Icon(Icons.arrow_forward)
                                        ],
                                      ),
                                    ),
                                  ),



                                ],
                              ),
                            );
                          });
                        });






















                      },
                      child: Container(
                        height: 209,
                        width: 360,
                        padding: EdgeInsets.only(top: 15,left: 7,right: 7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(19),topRight: Radius.circular(19)),
                            color: Colors.white
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit_outlined,color: Colors.black,),
                                SizedBox(width: 3,),
                                Text('Edit Prompt',style: TextStyle(fontSize: 17,color: Colors.black),),
                              ],
                            ),
   SizedBox(height: 10,),
                            Container(
                              height: 145,
                                width: 330,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.indigoAccent,width: 2),
                                borderRadius: BorderRadius.circular(17)
                              ),
                            )
                          ],
                        ),
                      ),
                    ),


                  ],
                ),
              )
            ],
          ),

    ));
  }
}
 }

 */

