
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../video_player.dart';
import '../videos.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List videos=[
    Videos(name: '20211009_225582',duration: Duration(seconds: 110),size: 1.55,path: 'assets/one.mp4'),
    Videos(name: 'VIDEO_443L228D',duration: Duration(seconds: 100),size: 02.55,path: 'assets/two.mp4'),
    Videos(name: 'MUSIC_2019 OKL44',duration: Duration(seconds: 210),size: 22.55,path: 'assets/three.mp4'),
    Videos(name: 'SHAGGY MAD MAD WORLD',duration: Duration(seconds: 110),size: 55.55,path: 'assets/shaggy.mp4'),
    Videos(name: 'sangasar new ',duration: Duration(seconds: 440),size: 4.55,path: 'assets/sang.mp4'),
    Videos(name: 'nature 004 _ 3',duration: Duration(seconds: 50),size: 02.55,path: 'assets/five.mp4'),Videos(name: '20211009_225582',duration: Duration(seconds: 110),size: 1.55,path: 'assets/one.mp4'),
    Videos(name: '1',duration: Duration(seconds: 100),size: 02.55,path: 'assets/1.mp4'),
    Videos(name: '2',duration: Duration(seconds: 210),size: 22.55,path: 'assets/2.mp4'),
    Videos(name: '3',duration: Duration(seconds: 110),size: 55.55,path: 'assets/3.mp4'),
    Videos(name: '4',duration: Duration(seconds: 440),size: 4.55,path: 'assets/4.mp4'),
    Videos(name: '5',duration: Duration(seconds: 50),size: 02.55,path: 'assets/5.gif'),
  ];
  //late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    // _controller = VideoPlayerController.asset(asset)..initialize();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: videos.map((e){

      return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              VPlayer(
                controller: e.path
              )));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
          child: Container(
            width: double.infinity,
            height: 65,
            color: Colors.transparent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 90, height: 55,
                  child: VideoPlayer(
                      VideoPlayerController.asset(e.path)..initialize()
                      ),
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text(e.name, style: TextStyle(fontSize: 19),)
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${e.duration.inMinutes}:${e.duration.inSeconds
                            .remainder(60)}', style: TextStyle(
                            fontSize: 14, color: Colors.white54),),
                        SizedBox(width: MediaQuery
                            .of(context)
                            .size
                            .width / 2.65,),
                        Text('${e.size} MG', style: TextStyle(
                            fontSize: 14, color: Colors.white54),),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );

          }).toList()
          ),
    );
  }
}
