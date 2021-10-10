
import 'package:donwload/icons.dart';
import 'package:donwload/video_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VPlayer extends StatefulWidget {
  String controller;
  VPlayer({required this.controller});

  @override
  _VPlayerState createState() => _VPlayerState();
}

class _VPlayerState extends State<VPlayer>  {

  double value=0;  bool lockVisibility=false;
  bool visible=false; bool lock=false;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller=VideoPlayerController.asset(widget.controller)..addListener(() {
      setState((){ });})
      ..initialize().then((value) => setState((){ _controller.play();}));
  }

  void lockVisibilityMethod(){
    lockVisibility=true;
    Future.delayed(
        Duration(seconds: 3),
            (){
          lockVisibility=false;
        }
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future setAllOrientations()async{
    await SystemChrome.setPreferredOrientations(
        DeviceOrientation.values
    );
    await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    if(lock){
      visible=false;
      setState(() {});
    }

    return Scaffold(
        body: Center(
          child: GestureDetector(
            child: Stack(
              children: [
                Center(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller,),
                    ),
                ),
                 lock ? Visibility(
                   visible: lockVisibility,
                   child: Positioned(
                     bottom: 29,
                     left: 30,
                     child: GestureDetector(
                       onTap: ()async{
                         lockVisibility=lock=false; visible=true;
                          SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
                          setState((){});
                       },
                       child: Icon(Icons.lock_open,size: 27),
                     ),
                   ),
                 )
                 :Visibility(
                   visible: visible,
                     child: GestureDetector(
                       child: VideoPlaceholder(
                         controller: _controller,
                         valueChanged: (value){
                           lockVisibility=lock=value;
                           lockVisibilityMethod();
                           setState((){});
                         },

                       ),
                     )
                 ),

              ],
            ),
            onTap: (){
             if(!lock){
               visible=!visible;
             }else{
               lockVisibilityMethod();
             }
             setState(() { });
            },
             onDoubleTap: (){
             if(!lock){
               visible=!visible;
               if(_controller.value.isPlaying){
                 _controller.pause();
               }else{
                 _controller.play();
               }

             }else{
               lockVisibilityMethod();
             }
             setState(() { });
             },
          ) ,
        ),

      );
  }
}
