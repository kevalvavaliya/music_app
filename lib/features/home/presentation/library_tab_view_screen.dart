import 'package:flutter/material.dart';
import 'package:music_app/features/authentication/presentation/controller/user_provider.dart';
import 'package:music_app/features/home/domain/song_model.dart';
import 'package:music_app/features/home/presentation/widgets/song_list_item.dart';
import 'package:provider/provider.dart';

class LibararyTabViewScreen extends StatelessWidget {
  const LibararyTabViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: context.read<UserProvider>().fetchFavouriteSongs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<SongModel> favSongList = context.watch<UserProvider>().getFavouriteSongsList();
            if (favSongList.isEmpty) {
              return const  Center(
                child: Text('No favourite songs'),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return SongListItem(song: favSongList[index]);
              },
              itemCount: favSongList.length,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
