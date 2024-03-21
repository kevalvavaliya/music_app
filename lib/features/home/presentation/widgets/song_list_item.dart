import 'package:flutter/material.dart';
import 'package:music_app/comman/theme/theme_provider.dart';
import 'package:music_app/comman/util/enums.dart';
import 'package:music_app/comman/widgets/custom_favourite_song_button.dart';
import 'package:music_app/features/home/domain/song_model.dart';
import 'package:music_app/features/home/presentation/controller/songs_provider.dart';
import 'package:music_app/features/home/presentation/song_detail_screen.dart';
import 'package:music_app/features/home/presentation/widgets/current_playing_song_text.dart';
import 'package:music_app/features/home/presentation/widgets/player_button.dart';
import 'package:provider/provider.dart';

class SongListItem extends StatelessWidget {
  const SongListItem({super.key, required this.song});
  final SongModel song;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SongDetailScreen(
                song: song,
              ))),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: context.watch<ThemeProvider>().themeMode == ThemeMode.dark
              ? Colors.black54
              : Colors.white70,
        ),
        child: Row(
          children: [
            Hero(
              tag: song.musicId,
              child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4), BlendMode.srcOver),
                        fit: BoxFit.cover,
                        image: NetworkImage(song.coverImage),
                      )),
                  child:
                      // If the current song is playing then show player button according to its state.
                      Consumer<SongsProvider>(
                          builder: (context, songsProvider, _) {
                    return songsProvider.isSongCurrentPlaying(song)
                        ? PlayerButton(
                            song: song,
                            songState:
                                songsProvider.getCurrentPlayingSongState())
                        : PlayerButton(
                            song: song, songState: SongState.stopped);
                  })),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CurrentPlayingSongText(text: song.musicName, song: song),
                  Text(
                    song.artistName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16),
                  )
                ],
              ),
            ),
            CustomFavouriteSongButton(
              song: song,
            )
          ],
        ),
      ),
    );
  }
}
