import 'package:audioplayers/audioplayers.dart';

class AudioHelper {
  AudioPlayer? _audioPlayer;
  static AudioHelper instance = AudioHelper._();

  AudioHelper._();

  AudioPlayer get audioPlayer {
   _audioPlayer = _audioPlayer ?? AudioPlayer();
    return _audioPlayer!;
  }


}