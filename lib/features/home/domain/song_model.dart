import 'package:music_app/comman/util/enums.dart';

class SongModel {
  String musicId;
  String musicLink;
  String musicName;
  String artistName;
  SongState songState;
  String coverImage;

  SongModel({
    required this.musicId,
    required this.musicName,
    required this.musicLink,
    required this.artistName,
    this.songState = SongState.stopped,
    required this.coverImage,
  });

  SongModel copyWith({
    String? musicId,
    String? musicName,
    String? musicLink,
    String? artistName,
    bool? isFavourite,
    SongState? songState,
    String? coverImage,
  }) {
    return SongModel(
      musicId: musicId ?? this.musicId,
      musicName: musicName ?? this.musicName,
      musicLink: musicLink ?? this.musicLink,
      artistName: artistName ?? this.artistName,
      songState: songState ?? this.songState,
      coverImage:coverImage?? this.coverImage,
    );
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      musicId: map['musicId'],
      musicName: map['musicName'],
      musicLink: map['musicLink'],
      artistName: map['artistName'],
      coverImage: map['coverImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'musicId': musicId,
      'musicName': musicName,
      'musicLink': musicLink,
      'artistName': artistName,
      'coverImage':coverImage,
    };
  }

  @override
  String toString() {
    return 'SongModel(musicId: $musicId, musicName: $musicName, musicLink: $musicLink, artistName: $artistName, songState: $songState coverimage: $coverImage)';
  }
}
