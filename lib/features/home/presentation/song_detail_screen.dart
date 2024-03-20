import 'package:flutter/material.dart';
import 'package:music_app/comman/util/enums.dart';
import 'package:music_app/comman/util/player_helper.dart';
import 'package:music_app/features/home/domain/song_model.dart';
import 'package:music_app/features/home/presentation/controller/songs_provider.dart';
import 'package:music_app/features/home/presentation/widgets/player_widget.dart';
import 'package:provider/provider.dart';

class SongDetailScreen extends StatelessWidget {
  const SongDetailScreen({super.key, required this.song});
  final SongModel song;
  static const String routeName = '/songdetail';

  @override
  Widget build(BuildContext context) {
   
    
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network('https://picsum.photos/200/300?image=0'),
            const SizedBox(
              height: 20,
            ),
            Text(song.musicName),
            const SizedBox(
              height: 20,
            ),
            Text(song.artistName),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: PlayerWidget(player: AudioHelper.instance.audioPlayer,song: song,))
          ],
        ),
      ),
    );
  }
}
