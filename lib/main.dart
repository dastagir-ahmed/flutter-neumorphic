import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool isPlaying=false;
  bool isPaused=false;
  bool isRepeat=false;
  Color color= Colors.black;
  List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];
  final AudioPlayer advancedPlayer = AudioPlayer();
  @override
  void initState(){
    super.initState();
    this.advancedPlayer.onDurationChanged.listen((d) {setState(() {
      _duration=d;
    });});
    this.advancedPlayer.onAudioPositionChanged.listen((p) {setState(() {
      _position=p;
    });});

    this.advancedPlayer.setUrl("https://st.bslmeiyu.com/uploads/%e6%9c%97%e6%96%87%e5%9b%bd%e9%99%85SBS%e7%b3%bb%e5%88%97/%e6%9c%97%e6%96%87%e5%9b%bd%e9%99%85%e8%8b%b1%e8%af%ad%e6%95%99%e7%a8%8b%e7%ac%ac1%e5%86%8c_V2/%e5%ad%a6%e7%94%9f%e7%94%a8%e4%b9%a6/P149_Chapter%2016_Vocabulary%20Preview.mp3");
    this.advancedPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = Duration(seconds: 0);
        if(isRepeat==true){
          isPlaying=true;
        }else{

          isPlaying=false;
          isRepeat=false;
        }
      });
    });
  }
  Widget btnStart() {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon:isPlaying==false?Icon(_icons[0], size:50, color:Colors.blue):Icon(_icons[1], size:50, color:Colors.blue),
      onPressed: (){
        if(isPlaying==false) {
          this.advancedPlayer.play("https://st.bslmeiyu.com/uploads/%e6%9c%97%e6%96%87%e5%9b%bd%e9%99%85SBS%e7%b3%bb%e5%88%97/%e6%9c%97%e6%96%87%e5%9b%bd%e9%99%85%e8%8b%b1%e8%af%ad%e6%95%99%e7%a8%8b%e7%ac%ac1%e5%86%8c_V2/%e5%ad%a6%e7%94%9f%e7%94%a8%e4%b9%a6/P149_Chapter%2016_Vocabulary%20Preview.mp3");
          setState(() {
            isPlaying = true;
          });
        }else if(isPlaying==true){
          this.advancedPlayer.pause();
          setState(() {
            isPlaying=false;
          });
        }
      },
    );
  }

  Widget btnFast() {
    return
      IconButton(
        icon:   ImageIcon(
          AssetImage('img/forward.png'),
          size: 15,
          color: Colors.black,
        ),
        onPressed: () {
          this.advancedPlayer.setPlaybackRate(playbackRate: 1.5);
        },
      );
  }
  Widget btnSlow() {
    return IconButton(
      icon:   ImageIcon(
        AssetImage('img/backword.png'),
        size: 15,
        color: Colors.black,
      ),
      onPressed: () {
        this.advancedPlayer.setPlaybackRate(playbackRate: 0.5);

      },
    );
  }
  Widget btnLoop() {
    return IconButton(
        icon:   ImageIcon(
          AssetImage('img/loop.png'),
          size: 15,
          color: Colors.black,
        ), onPressed: () {  },
    );
  }
  Widget btnRepeat() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('img/repeat.png'),
        size: 15,
        color:color,
      ),
      onPressed: (){
        if(isRepeat==false){
          this.advancedPlayer.setReleaseMode(ReleaseMode.LOOP);
          setState(() {
            isRepeat=true;
            color=Colors.blue;
          });
        }else if(isRepeat==true){
          this.advancedPlayer.setReleaseMode(ReleaseMode.RELEASE);
          color=Colors.black;
          isRepeat=false;
        }
      },
    );
  }

  Widget slider() {
    return Slider(
        activeColor: _iconsColor(context),
        inactiveColor: Colors.grey,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });});
  }

  void changeToSecond(int second){
    Duration newDuration = Duration(seconds: second);
    this.advancedPlayer.seek(newDuration);
  }

  Widget loadAsset() {
    return
      Container(
          child:Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                btnRepeat(),
                btnSlow(),
                btnStart(),
                btnFast(),
                btnLoop()
              ])
      );
  }
  @override
  Widget build(BuildContext context) {
    return Container();

  }

  Color? _iconsColor(BuildContext context) {
    final theme = NeumorphicTheme.of(context);
    if (theme!.isUsingDark) {
      return theme.current!.accentColor;
    } else {
      return null;
    }
  }

  Color _textColor(BuildContext context) {
    if (NeumorphicTheme.isUsingDark(context)) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
  }

