import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/comman/util/enums.dart';
import 'package:music_app/comman/util/player_helper.dart';
import 'package:music_app/features/home/domain/song_model.dart';

class SongsProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioHelper.instance.audioPlayer;
  SongModel? currentPLayingSong;

  SongsProvider() {
    subScribeToStream();
  }

  void subScribeToStream() {
    _audioPlayer.eventStream.listen((event) {
      if (event.eventType == AudioEventType.complete) {
        setCurrentPlayingSong(
            currentPLayingSong!.copyWith(songState: SongState.stopped));
      }
    });
  }

  // playing song and updating player state to playing
  void playSong(SongModel song) async {
    setCurrentPlayingSong(song.copyWith(songState: SongState.playing));
    await _audioPlayer.play(UrlSource(song.musicLink));
    _audioPlayer.onPlayerStateChanged.listen((event) {
    });
  }

  // pausing song and updating player state to paused
  void pauseSong() async {
    setCurrentPlayingSong(
        currentPLayingSong!.copyWith(songState: SongState.paused));
    await _audioPlayer.pause();
  }

  // resuming song and updating player state to resume
  void resumeSong() async {
    setCurrentPlayingSong(
        currentPLayingSong!.copyWith(songState: SongState.resume));
    notifyListeners();
    await _audioPlayer.resume();
  }

  // setting current playing song in the state
  void setCurrentPlayingSong(SongModel song) {
    currentPLayingSong = song;
    notifyListeners();
  }

  // get current playing song
  SongModel? getCurrentPlayingSong() {
    return currentPLayingSong;
  }

  // check if the given song is currently playing or not
  bool isSongCurrentPlaying(SongModel song) {
    if (currentPLayingSong == null) {
      return false;
    }
    return song.musicId == currentPLayingSong!.musicId;
  }

  // get current playing song state
  SongState getCurrentPlayingSongState() {
    if (currentPLayingSong == null) {
      return SongState.stopped;
    }
    return currentPLayingSong!.songState;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _audioPlayer.dispose();
    super.dispose();
  }
}
