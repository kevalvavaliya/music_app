import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music_app/comman/util/audio_helper.dart';
import 'package:music_app/comman/widgets/custom_favourite_song_button.dart';
import 'package:music_app/features/home/domain/song_model.dart';
import 'package:music_app/features/home/presentation/widgets/current_playing_song_text.dart';
import 'package:music_app/features/home/presentation/widgets/player_widget.dart';
import 'package:shimmer/shimmer.dart';

class SongDetailScreen extends StatelessWidget {
  const SongDetailScreen({super.key, required this.song});
  final SongModel song;
  static const String routeName = '/songdetail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: song.musicId,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              child: Image.network(song.coverImage, fit: BoxFit.cover,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                if (frame == null) {
                  return Shimmer(
                    gradient: LinearGradient(colors: [
                      Colors.grey.shade300,
                      Colors.grey.shade100,
                      Colors.grey.shade300,
                    ]),
                    child: Container(
                      color: Colors.black,
                    ),
                  );
                } else {
                  return child;
                }
              }, errorBuilder: (context, error, stackTrace) {
                log("error in loading image : ${error.toString()}");
                return const Center(child: Text("Failed to load image"));
              }),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      CurrentPlayingSongText(
                        text: song.musicName,
                        textSize: 40,
                        song: song,
                      ),
                      CustomFavouriteSongButton(
                        song: song,
                        size: 30,
                      ),
                    ],
                  ),
                  FittedBox(
                    child: Text(
                      song.artistName,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PlayerWidget(
                    player: AudioHelper.instance.audioPlayer,
                    song: song,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
