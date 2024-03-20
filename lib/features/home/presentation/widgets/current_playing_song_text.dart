import 'package:flutter/material.dart';
import 'package:music_app/comman/theme/custom_colors.dart';
import 'package:music_app/features/home/domain/song_model.dart';
import 'package:music_app/features/home/presentation/controller/songs_provider.dart';
import 'package:provider/provider.dart';

class CurrentPlayingSongText extends StatelessWidget {
  const CurrentPlayingSongText({
    super.key,
    required this.text,
    required this.song,
    this.textSize = 18,
  });
  final String text;
  final double textSize;
  final SongModel song;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        text,
        style: TextStyle(
            fontSize: textSize,
            fontWeight: FontWeight.w700,
            color: context.watch<SongsProvider>().isSongCurrentPlaying(song)
                ? CustomColors.PRIMARY_COLOR
                : null),
      ),
    );
  }
}
