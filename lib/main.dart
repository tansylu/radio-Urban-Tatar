import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'globals.dart' as globals;

final List<String> urlList = ['HOME', 'https://ilgamsharipov.radioca.st/stream', 'https://urbantatarold.radioca.st/stream','https://urbantatar.radioca.st/stream'];
final List<String> nameList = ['Main page', 'Vinyl', 'Alternative', 'Progressive'];
final List<String> imgList = ['assets/home.png', 'assets/vinyl.png', 'assets/alt.png', 'assets/prog.png'];
int _index = 0;
final CarouselController _controller = CarouselController();

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    height: 400.0,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason){
                      print(index);
                      player.pause();
                      print(urlList[index]);
                      if (index!=0){
                        player.setUrl(urlList[index]);
                        player.play();}
                    }
                      ),
                items: imgList.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black12)
                          ),

                        child:Stack(
                          children:
                          <Widget>[
                            GestureDetector(
                              onTap: () {
                                if (player.playing == true){
                                  player.pause();
                                }
                                else{
                                  if (imgList.indexOf(i) == 0){
                                    print("nab chelny");
                                  }
                                  else{
                                    final url = urlList[imgList.indexOf(i)];
                                    print(url);
                                    player.setUrl(url);
                                    player.play();}}
                                },
                              child:
                                Image.asset(imgList[imgList.indexOf(i)],fit: BoxFit.fill,),
                            ),
                            Text(nameList[imgList.indexOf(i)],style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold)),],

                        ),
                      );
                    }
                  );
                }).toList(),

              ),
            // IconButton(
            //   icon: (player.playing)
            //       ? Icon(Icons.pause_circle_filled)
            //       : Icon(Icons.play_circle_outline),
            //       iconSize: 40,
            //     onPressed: () {
            //     print('hello');
            //     print(player.playing);
            //     if (player.playing == true) {
            //       player.pause();
            //       player.dispose();}
            //     else {
            //       final url = urlList[_index];
            //       print(url);
            //       player.setUrl(url);
            //       player.play();}}
            //       ),
        ]
          ),
        ),
      ),
    );
  }
}
