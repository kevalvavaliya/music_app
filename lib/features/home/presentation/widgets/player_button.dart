import 'package:flutter/material.dart';
import 'package:music_app/comman/util/enums.dart';
import 'package:music_app/features/home/domain/song_model.dart';
import 'package:music_app/features/home/presentation/controller/songs_provider.dart';
import 'package:provider/provider.dart';

class PlayerButton extends StatelessWidget {
  const PlayerButton(
      {super.key, required this.songState, required this.song, this.size = 30});
  final SongState songState;
  final SongModel song;
  final double size;

  @override
  Widget build(BuildContext context) {
    // if song is not playing return play button

    if (songState == SongState.stopped) {
      return IconButton(
          onPressed: () async {
            context.read<SongsProvider>().playSong(song);
          },
          icon: Icon(
            Icons.play_arrow,
            size: size,
          ));
    }
    // if song is  playing return pause button
    else if (songState == SongState.playing) {
      return IconButton(
          onPressed: () {
            context.read<SongsProvider>().pauseSong();
          },
          icon: Icon(Icons.pause, size: size));
    }
    // if song is paused return resume button
    else if (songState == SongState.paused) {
      return IconButton(
          onPressed: () {
            context.read<SongsProvider>().resumeSong();
          },
          icon: Icon(Icons.play_arrow, size: size));
    }
    // if song is resumed return pause button
    else if (songState == SongState.resume) {
      return IconButton(
          onPressed: () {
            context.read<SongsProvider>().pauseSong();
          },
          icon: Icon(Icons.pause, size: size));
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
