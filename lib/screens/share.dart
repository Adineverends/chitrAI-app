
/*
import 'package:chitrai/screens/Artpage.dart';
import 'package:chitrai/screens/home.dart';
import 'package:flutter/material.dart';

class share extends StatefulWidget {
  final String selectedartImage;
  final String editedprompt;
  final String editedpromptimage;
   share({Key? key,required this.selectedartImage,required this.editedprompt,required this.editedpromptimage}) : super(key: key);

  @override
  State<share> createState() => _shareState();
}

class _shareState extends State<share> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(

          body: Column(
            children: [
              SizedBox(height: 10,),
              Row(
                children: [

                  SizedBox(width: 20,),
                  InkWell(

                      onTap: (){

                        setState(() {
                         Navigator.pop(context);
                        });


                      },

                      child: Icon(Icons.arrow_back)),

                  SizedBox(width: 250,),
                 /*
                  FlatButton(
                      onPressed: (){

                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      color: Colors.black,

                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(7.0)),

                      child: Row(
                        children: [
                          Text('Done',style: TextStyle(fontSize: 20,color: Colors.white),),

                        ],
                      )

                  ),
                  */

                  InkWell(
                     onTap: (){
                       Navigator.pop(context);
                     },
                    // color: Colors.black,
                    //  minWidth: 60,
                    //  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),

                      child: Container(

                          height: 46,
                          width: 90,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12)
                          ),

                          child: Text('Done',style: TextStyle(color: Colors.white),))
                  ),
                ],
              ),



              SizedBox(height: 15,),

              Container(
                height: 696,
                width: double.infinity,
                color: Colors.grey.shade200,
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: 300,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          color: Colors.black,
                        image: DecorationImage(
                          image:

                          widget.editedprompt.isNotEmpty?NetworkImage(widget.editedpromptimage ):
                          NetworkImage(
                            widget.selectedartImage
                          ),
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                   SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        
                      },
                      child: Container(
                        height: 53,
                        width: 330,

                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.indigoAccent.shade100,
                                Colors.indigoAccent.shade700
                              ]
                            ),
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(30),bottomLeft:Radius.circular(30),bottomRight: Radius.circular(37) ),
                            color: Colors.black
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('REMOVE WATERMARK ',style: TextStyle(fontSize:16,fontWeight: FontWeight.w500,color:Colors.white),),
                            Icon(Icons.keyboard_arrow_up_outlined,color: Colors.white,)
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 117,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Share ',style: TextStyle(fontSize:20,fontWeight: FontWeight.w500,color:Colors.indigoAccent),),
                        Text('your Art with the world',style: TextStyle(fontSize:20,fontWeight: FontWeight.w500,color:Colors.black),),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                                InkWell(
                                    
                                    child: Image.asset('images/instagram.png',height: 50,)),
                        SizedBox(width: 21,),
                        InkWell(
                            onTap: (){
                              
                            },
                            child: Image.asset('images/facebook.png',height: 50,)),
                        SizedBox(width: 21,),
                        InkWell(child: Image.asset('images/pinterest-logo.png',height: 50,)),
                        SizedBox(width: 21,),
                        InkWell(child: Image.asset('images/whatsapp.png',height: 50,)),
                        SizedBox(width: 21,),
                        InkWell(
                          child: Container(
                               height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15),

                              ),

                              child: Icon(Icons.upload,color: Colors.white,)
                              //Image.asset('images/upload.png',height: 10,color: Colors.white,)
                          ),
                        ),


                      ],
                    ),
             SizedBox(height: 21,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                          height: 50,
                          width: 350,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),

                          ),

                          child:  Text('Close ',style: TextStyle(fontSize:18,fontWeight: FontWeight.w500,color:Colors.white),),
                        //Image.asset('images/upload.png',height: 10,color: Colors.white,)
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),

    )
    );

  }
}


 */