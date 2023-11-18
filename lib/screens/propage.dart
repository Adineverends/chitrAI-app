

import 'dart:async';

import 'package:flutter/material.dart';




class propage extends StatefulWidget {
  const propage({Key? key}) : super(key: key);

  @override
  State<propage> createState() => _propageState();
}

class _propageState extends State<propage> {


  int  selectedButtonIndex = 0;
  String _text = '';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop:() async => false,
      child: SafeArea(
        child: Scaffold(


          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon:Icon(Icons.cancel,size: 33,)),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Image.asset('images/pro.png',),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 25,),
                      Text('Unleash your',style: TextStyle(fontSize: 35,fontWeight: FontWeight.w400,letterSpacing: 1),),
                      SizedBox(height: 5,),

                      Text('Creativity',style: TextStyle(fontSize: 33,fontWeight: FontWeight.bold,letterSpacing: 1),),
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
                          SizedBox(width: 50,),
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
                          SizedBox(width: 37,),
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
                            onTap: ()

                         //   => setState(() => selectedButtonIndex = 0,),

                {
                setState(() async {
                selectedButtonIndex=0;
                _text='One time payment of Rs10,800';



                });



                },

                            child: Container(
                              height: 100,
                              width:100,

                              decoration: BoxDecoration(
                                  color: selectedButtonIndex == 0 ? Colors.yellow.shade600 : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(16)
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3,right: 47),
                                    child:
                                    selectedButtonIndex == 0 ?  Icon(Icons.check_circle): Icon(Icons.circle_outlined)

                                   ,
                                  ),
                                  SizedBox(height: 25,),
                                  Text('Lifetime',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          InkWell(
                            //onTap: () => setState(() => selectedButtonIndex = 1),
                            onTap: ()

                            //   => setState(() => selectedButtonIndex = 0,),

                            {
                              setState(()async {

                                selectedButtonIndex=1;
                                _text='Weekly  payment of Rs590.00';


                              });

                            },
                            child: Container(
                              height: 100,
                              width:100 ,
                              decoration: BoxDecoration(
                                  color: selectedButtonIndex == 1 ? Colors.yellow.shade600 : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(16)
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3,right: 47),
                                    child:selectedButtonIndex == 1 ?  Icon(Icons.check_circle): Icon(Icons.circle_outlined),
                                  ),
                                  SizedBox(height: 25,),
                                  Text('Weekly',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          InkWell(
                         //   onTap: () => setState(() => selectedButtonIndex = 2),
                            onTap: ()

                            //   => setState(() => selectedButtonIndex = 0,),

                            {
                              setState(() async {
                                selectedButtonIndex=2;
                                _text='Yearly  payment of Rs3900';

                              });

                            },
                            child: Container(
                              height: 100,
                              width:100,
                              decoration: BoxDecoration(
                                  color: selectedButtonIndex == 2 ? Colors.yellow.shade600 : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(16)
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3,right: 47),
                                    child: selectedButtonIndex == 2 ?  Icon(Icons.check_circle): Icon(Icons.circle_outlined),
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
                        height: 66,
                        width:320 ,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Row(
                          //  mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 120,),
                            Text('Continue',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),
                            SizedBox(width: 95,),
                            Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),
                          ],
                        ),
                      ),
                      SizedBox(height: 12,),
                      Padding(
                        padding: const EdgeInsets.only(left: 33),
                        child: Text(_text,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                      ),

                    ]
                ),
              ),
            ],
          )

        ),
      ),
    );
  }
}
