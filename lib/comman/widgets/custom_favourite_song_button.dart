import 'package:flutter/material.dart';
import 'package:music_app/comman/util/custom_snackbar.dart';
import 'package:music_app/features/authentication/presentation/controller/user_provider.dart';
import 'package:music_app/features/home/domain/song_model.dart';
import 'package:provider/provider.dart';

class CustomFavouriteSongButton extends StatelessWidget {
  const CustomFavouriteSongButton(
      {super.key, required this.song, this.size = 30});
  final SongModel song;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) => IconButton(
          onPressed: () async {
            // if song is not in favourite list then add it else remove it
            if (userProvider.getUserFromAppState != null &&
                !userProvider.getUserFromAppState!.favouriteSongs
                    .contains(song.musicId)) {
              userProvider.addSongToFavourite(song).then((result) {
                if (result) {
                  CustomSnackBar.showSnackbar(context,
                      '${song.musicName} has been added to liked songs ❤️ ');
                } else {
                  CustomSnackBar.showSnackbar(
                      context, 'Failed to add song to liked songs');
                }
              });
            } else {
              userProvider.removeSongFromFavourite(song).then((result) {
                if (result) {
                  CustomSnackBar.showSnackbar(context,
                      '${song.musicName} has been removed from liked songs ❤️ ');
                } else {
                  CustomSnackBar.showSnackbar(
                      context, 'Failed to remove song from liked songs');
                }
              });
            }
          },
          icon: userProvider.getUserFromAppState != null &&
                  userProvider.getUserFromAppState!.favouriteSongs
                      .contains(song.musicId)
              ? Icon(
                  Icons.favorite_outlined,
                  size: size,
                )
              : Icon(
                  Icons.favorite_border,
                  size: size,
                )),
    );
  }
}
