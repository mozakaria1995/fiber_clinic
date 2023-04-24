import 'package:auth_manager/new/cache/app_cache.dart';
import 'package:auth_manager/new/model/user_model.dart';
import 'package:auth_manager/new/ui/landing/landing_screen.dart';
import 'package:auth_manager/new/ui/login/login_screen.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:auth_manager/new/widgets/app_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class IntroVideo extends StatefulWidget {
  final String videoUrl;
  final String buttonText;
  final Function() onButtonTapped;
  final String? appBarTitle;
  const IntroVideo(
      {required this.videoUrl,
      required this.buttonText,
      required this.onButtonTapped,
        this.appBarTitle
      });

  @override
  State<IntroVideo> createState() => _IntroVideoState();
}

class _IntroVideoState extends State<IntroVideo> {
  //"https://www.youtube.com/watch?v=BBAyRBTfsOU"
 late YoutubePlayerController _controller ;

 @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          widget.videoUrl)??"",
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
   Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: widget.appBarTitle != null && orientation == Orientation.portrait? AppBar(
        centerTitle: true,
        backgroundColor: ColorManager.scaffoldBackGround,
        shadowColor: Colors.transparent,
        title: Text(widget.appBarTitle!,
            style: TextStyle(
                color: ColorManager.primary,
                fontFamily: FontManager.fontFamily,
                fontWeight: FontWeightManager.semiBold,
                fontSize: FontSizeManager.s16)),
      ) : null,
      body: Stack(
        children: [
          YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: ColorManager.primary,
                liveUIColor: Colors.amber,
                progressColors: ProgressBarColors(
                  playedColor: Colors.red,
                  handleColor: Colors.amberAccent,
                ),
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(isExpanded: true),
                ],
              ),
              builder: (context, player) {
                return Center(
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: player
                  ),
                );
              }),
          Padding(
            padding: EdgeInsets.only(bottom: 25, right: 15),
            child: Align(
              alignment: Alignment.bottomRight,
              child: AppButton(
                  width: 100,
                  height: 30,
                  buttonColor: ColorManager.primary,
                  onPressed: widget.onButtonTapped,
                  title: widget.buttonText),
            ),
          ),
        ],
      ),
    );
  }
}
