 import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import 'icons.dart';

 String speedValue='1.0';
 bool lock=false;
 class VideoPlaceholder extends StatefulWidget {
    VideoPlayerController controller;
    ValueChanged valueChanged;
    VideoPlaceholder({required this.controller,required this.valueChanged});

   @override
   _VideoPlaceholderState createState() => _VideoPlaceholderState();
 }

 class _VideoPlaceholderState extends State<VideoPlaceholder> {

   bool lock = false;
   static const allSpeeds = <double>[0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2];

   Future setLandscape()async{
     await SystemChrome.setEnabledSystemUIOverlays([]);
     await SystemChrome.setPreferredOrientations([
       DeviceOrientation.landscapeLeft,
       DeviceOrientation.landscapeRight
     ]);
   }


   @override
  void dispose() {
    super.dispose();
  }
   void setOrientation(bool isPortrait) {
     if (isPortrait) {
       SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
     } else {
       SystemChrome.setEnabledSystemUIOverlays([]);
     }
   }

   @override
   Widget build(BuildContext context) {

     return OrientationBuilder(
       builder: (_,orientation) {
         bool  isPortrait= orientation==Orientation.portrait;
         setOrientation(isPortrait);

         return Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Padding(
             padding:  EdgeInsets.symmetric(horizontal: 30),
             child: Column(
               children: [
                 Padding(
                   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/20,bottom: 13),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text('this new video',style: const TextStyle(fontSize: 25),),
                       Container(
                         width: MediaQuery.of(context).size.width/6,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             GestureDetector(
                               onTap: (){ },
                               child: const Text("CC",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                             ),
                             GestureDetector(
                               onTap: (){ },
                               child: const Icon(Icons.more_vert,size: 27),
                             )
                           ],
                         ),
                       )
                     ],
                   ),

                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 10),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [

                       GestureDetector(
                         onTap: (){ },
                         child: const Icon(Icons.slow_motion_video,size: 27),
                       ),
                       GestureDetector(
                         onTap: (){ },
                         child: const Icon(Icons.open_in_new,size: 26),
                       )
                     ],
                   ),
                 )
               ],
             ),
           ),
           Column(
             children: [
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 30),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     GestureDetector(
                       onTap: (){ },
                       child:  Icon(Icons.picture_in_picture,size: 26),
                     ),
                     Container(
                       width: 100,
                       child: PopupMenuButton<double>(
                         initialValue: widget.controller.value.playbackSpeed,
                         onSelected: widget.controller.setPlaybackSpeed,
                         icon: Text('${speedValue}x'),
                         itemBuilder: (context)=>
                         allSpeeds.map<PopupMenuEntry<double>>((speed) =>
                         PopupMenuItem(
                           value: speed,
                           child: Text('${speed}x'),
                           onTap: (){
                             speedValue=speed.toString();
                         },
                         )).toList()
                       ),
                     ),
                     GestureDetector(
                       onTap: (){ },
                       child: const Icon(Icons.fullscreen,size: 30),
                     ),
                   ],
                 ),
               ),
               Container(
                 width: double.infinity,
                 padding: const EdgeInsets.only(right: 25,left: 20,top: 20),
                 child: SliderTheme(
                     data: const SliderThemeData(
                       trackShape: RectangularSliderTrackShape(),
                       trackHeight: 5,
                       overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
                     ), child:Container(width: 500,
                   child: Slider(
                     value: widget.controller.value.position.inSeconds.toDouble(),
                     max: widget.controller.value.duration.inSeconds.toDouble(),
                     onChanged: (value){
                       setState((){
                         widget.controller.seekTo(Duration(seconds: value.toInt()));
                       });
                     },
                     activeColor: Colors.redAccent,
                     inactiveColor: Colors.white54,
                   ),
                 )
                 ),
               ),
               Padding(
                 padding: EdgeInsets.only(left: 30,right: 30,top: 3,bottom: 5 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('${widget.controller.value.position.inMinutes}:${widget.controller.value.position.inSeconds.remainder(60)}'),
                     Text('${widget.controller.value.duration.inMinutes}:${widget.controller.value.duration.inSeconds.remainder(60)}')
                   ],
                 ),
               ),
               Padding(
                 padding:  const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                 child: Stack(alignment: Alignment.center,
                   children: [
                     GestureDetector(
                       onTap: (){
                       },
                       child: Container(
                         width: double.infinity,height: 50,color: Colors.transparent,
                       ),
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         GestureDetector(
                           onTap: (){
                             SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
                             lock=!lock;
                             widget.valueChanged(lock);
                             setState((){});
                           },
                           child: Icon(Icons.lock_outline,size: 27),
                         ),
                         GestureDetector(
                           onTap: (){
                            //todo
                           },
                           child: Icon(Home.fast_bw,size: 23),
                         ),
                         GestureDetector(
                           onTap: (){
                             if(widget.controller.value.isPlaying){
                               widget.controller.pause();
                             }else{
                               widget.controller.play();
                             }
                             setState((){});
                           },
                           child: Icon(widget.controller.value.isPlaying?Home.pause:Home.play,size: 55),
                         ),
                         GestureDetector(
                           onTap: (){
                             //todo
                           },
                           child: Icon(Home.fast_fw,size: 23,),
                         ),
                         GestureDetector(
                           onTap: (){
                             if (isPortrait) {
                               setLandscape();
                             } else {
                               AutoOrientation.portraitUpMode();
                             }
                           },
                           child: Icon(Icons.autorenew,size: 27),
                         ),
                       ],
                     ),

                   ],
                 ),
               ),
             ],
           ),

         ],
       );
       },
     );
   }
 }
