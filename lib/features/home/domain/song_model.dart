import 'package:music_app/comman/util/enums.dart';

class SongModel {
  String musicId;
  String musicLink;
  String musicName;
  String artistName;
  bool isFavourite;
  SongState songState;

  SongModel({
    required this.musicId,
    required this.musicName,
    required this.musicLink,
    required this.artistName,
    this.isFavourite = false,
    this.songState = SongState.stopped,
  });

  SongModel copyWith({
    String? musicId,
    String? musicName,
    String? musicLink,
    String? artistName,
    bool? isFavourite,
    SongState? songState,
  }) {
    return SongModel(
      musicId: musicId ?? this.musicId,
      musicName: musicName ?? this.musicName,
      musicLink: musicLink ?? this.musicLink,
      artistName: artistName ?? this.artistName,
      isFavourite: isFavourite ?? this.isFavourite,
      songState: songState??this.songState,
    );
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      musicId: map['musicId'],
      musicName: map['musicName'],
      musicLink: map['musicLink'],
      artistName: map['artistName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'musicId': musicId,
      'musicName': musicName,
      'musicLink': musicLink,
      'artistName': artistName,
    };
  }

  @override
    String toString() {
      return 'SongModel(musicId: $musicId, musicName: $musicName, musicLink: $musicLink, artistName: $artistName, isFavourite: $isFavourite, songState: $songState)';
    }
  
}
