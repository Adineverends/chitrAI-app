import 'package:chitrai/screens/home.dart';

import 'package:flutter/material.dart';

class styles extends StatefulWidget {

  final Function(String, String) onListItemSelected;


   styles({Key? key,required this.onListItemSelected}) : super(key: key);

  @override
  State<styles> createState() => _stylesState();
}

class _stylesState extends State<styles> {

  String _selectedName = "";
  String _selectedImage = "";

  final List<ListItem> _styles = [

    ListItem(name: '        REALISTIC           ', image: 'images/real2.png'),
    ListItem(name: '               ANIME          ', image: 'images/anime.png'),
    ListItem(name: '        CYBERPUNK       ', image: 'images/cyberpunk.png'),
    ListItem(name: '        EUPHORIC          ', image: 'images/euphoric.png'),
    ListItem(name: '        INK                       ', image: 'images/ink.png'),
    ListItem(name: '        JAPANESE ART   ', image: 'images/japne.png'),
    ListItem(name: '        SALVADOR DALI  ', image: 'images/salvador.png'),
    ListItem(name: '        VAN GOGH        ', image: 'images/van.png'),
    ListItem(name: '        STEAMPUNK     ', image: 'images/steampunk.png'),
    ListItem(name: '        RETROWAVE     ', image: 'images/retro.png'),
    ListItem(name: '        POLYART           '      , image: 'images/polyart.png'),
    ListItem(name: '        VIBRANT              ', image: 'images/vibrant.png'),
    ListItem(name: '        MYSTICAL            ', image: 'images/mystical.png'),
    ListItem(name: 'CINEMATIC RENDER', image: 'images/cenematic.png'),
    ListItem(name: '        FUTURISTIC     ', image: 'images/future.png'),
    ListItem(name: '         POLAROID       ', image: 'images/polaroid.png'),
    ListItem(name: '         PICASO           ', image: 'images/picaso.png'),
    ListItem(name: '         SKETCH           ', image: 'images/sketch.png'),
    ListItem(name: '         COMIC BOOK     ', image: 'images/comic.png'),
    ListItem(name: '         POSTER ART     ', image: 'images/poster.png'),
    /*


    {'name': 'REALISTIC', 'image': 'images/real2.png'},
    {'name': 'ANIME', 'image': 'images/anime.png'},
    {'name': 'CYBERPUNK', 'image': 'images/cyberpunk.png'},
    {'name': 'EUPHORIC', 'image': 'images/euphoric.png'},
    {'name': 'POSTERART', 'image': 'images/poster.png'},
    {'name': 'INK', 'image': 'images/ink.png'},
    {'name': 'JAPANESE ART', 'image': 'images/japne.png'},
    {'name': 'SALVADOR DALI', 'image': 'images/salvador.png'},
    {'name': 'VAN GOGH', 'image': 'images/van.png'},
    {'name': 'STEAMPUNK', 'image': 'images/steampunk.png'},
    {'name': 'RETROWAVE', 'image': 'images/retro.png'},
    {'name': 'POLYART', 'image': 'images/polyart.png'},
    {'name': 'VIBRANT', 'image': 'images/vibrant.png'},
    {'name': 'MYSTICAL', 'image': 'images/mystical.png'},
    {'name': 'CINEMATIC RENDER', 'image': 'images/cenematic.png'},
    {'name': 'FUTURISTIC', 'image': 'images/future.png'},
    {'name': 'POLAROID', 'image': 'images/polaroid.png'},
    {'name': 'PICASO', 'image': 'images/picaso.png'},
    {'name': 'SKETCH', 'image': 'images/sketch.png'},
    {'name': 'COMIC BOOK', 'image': 'images/comic.png'},

*/

  ];

  void _styleSelectedHandler(BuildContext context, String styleName,String imagepath) {

    Navigator.pop(context,{'name':styleName,'image':imagepath});
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('Select Style',style: TextStyle(color: Colors.black),),
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon:Icon(Icons.arrow_back_outlined,color: Colors.black)),
        ),

        body: GridView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: _styles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
        //    childAspectRatio: 3 / 4,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemBuilder: (context, index) {
            final style = _styles[index];
            return GestureDetector(
              onTap: () {
                widget.onListItemSelected(_styles[index].name, _styles[index].image);
                Navigator.pop(context);
              },
              child: ClipRRect(
                borderRadius:BorderRadius.circular(17) ,
              //  elevation: 2.0,

               child:     Stack(
                 children: [
                   Image.asset(
                     _styles[index].image,
                          fit: BoxFit.cover,
                        ),
                   Padding(
                     padding: const EdgeInsets.only(top: 5,left: 1,right: 6),
                     child: Text(
                       _styles[index].name,
                       style: TextStyle(fontSize: 15.0,color: Colors.white,fontWeight: FontWeight.w900),
                       textAlign: TextAlign.center,
                     ),
                   ),
                 ],
               ),
                    /*
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        style['name'],
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ),
                    ),  */

              ),
            );
          },
        ),
      ),
    );
  }
}

class ListItem {
  final String name;
  final String image;

  ListItem({required this.name, required this.image});
}