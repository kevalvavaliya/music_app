import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:music_app/comman/util/constants.dart';
import 'package:music_app/features/home/domain/song_model.dart';
import 'package:music_app/features/home/presentation/song_detail_screen.dart';
import 'package:music_app/features/home/presentation/widgets/song_list_item.dart';

class HomeTabViewScreen extends StatelessWidget {
  const HomeTabViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // paginated firestore list view
      body: FirestoreListView<SongModel>(
        query: FirebaseFirestore.instance
            .collection(Constants.SONGS_COLLECTION)
            .withConverter(
              fromFirestore: (snapshot, options) =>
                  SongModel.fromMap(snapshot.data()!),
              toFirestore: (song, options) => song.toMap(),
            ),
        pageSize: 10,
        itemBuilder: (context, doc) {
          return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SongDetailScreen(
                        song: doc.data(),
                      ))),
              child: SongListItem(song: doc.data()));
        },
      ),
    );
  }
}