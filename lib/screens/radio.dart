import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

const defaultPlayerCount = 4;

typedef OnError = void Function(Exception exception);

class TheRadio extends StatefulWidget {
  const TheRadio({Key? key}) : super(key: key);

  @override
  State<TheRadio> createState() => _TheRadioState();
}

class _TheRadioState extends State<TheRadio> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
int timerValue=0;
bool _paused=true;
final Stream<int> _periodicStream=Stream.periodic(const Duration(milliseconds: 1000),(i)=>i);
int _previousStremValue=0;
  @override
  void initState() {
    // audioPlayer.onPlayerStateChanged.listen((s) {
    //   setState(() => _audioPlayerState = s);
    // }, onDone: () {
    //   setState(() => _audioPlayerState = PlayerState.COMPLETED);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder(
          stream: _periodicStream,
          builder: (BuildContext context,AsyncSnapshot<int> snapshot){
            if(snapshot.hasData){
              if(snapshot.data!=_previousStremValue){
                _previousStremValue=snapshot.data!;
                if(!_paused){
                  timerValue++;
                }
              }
            }
            return  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    'assets/images/radio.jpg',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width*0.85,
                    height:  MediaQuery.of(context).size.width*0.95,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'إذاعة القرأن الكريم',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'إذاعة القرأن الكريم بث مباشر',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Slider(
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: (value) async{
                      await audioPlayer.seek(Duration(microseconds: (timerValue * 1000).toInt()));

                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                     // Text('$position'),
                      // ,// Text(formatTime(position)),
                     // Text('${duration - position}'),
                      //Text('0:$timerValue'),
                      Text(Duration(milliseconds: (timerValue * 1000).toInt()).toString().split(".").first.padLeft(8,"0"))
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 35,
                  child: IconButton(
                    icon: isPlaying?const Icon(Icons.pause):const Icon(Icons.play_arrow),
                    iconSize: 50,
                    onPressed: ()async{
                      if(isPlaying){
                        await audioPlayer.pause();
                      }else{
                        await audioPlayer.setUrl('https://stream.radiojar.com/8s5u5tpdtwzuv');
                        audioPlayer.play();
                        // int result = await audioPlayer.play('https://stream.radiojar.com/8s5u5tpdtwzuv');
                      }
                      setState(() {
                        _paused=!_paused;
                      });
                      setState(() {
                        isPlaying=!isPlaying;
                      });
                    },
                  ),

                )
              ],
            );
          },
        ),
      ),
    );
  }
}
