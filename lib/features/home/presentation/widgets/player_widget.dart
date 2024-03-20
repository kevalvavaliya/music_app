import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/comman/util/enums.dart';
import 'package:music_app/features/home/domain/song_model.dart';
import 'package:music_app/features/home/presentation/controller/songs_provider.dart';
import 'package:music_app/features/home/presentation/widgets/player_button.dart';
import 'package:provider/provider.dart';

class PlayerWidget extends StatefulWidget {
  final AudioPlayer player;
  final SongModel song;
  const PlayerWidget({
    required this.player,
    required this.song,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _PlayerWidgetState();
  }
}

class _PlayerWidgetState extends State<PlayerWidget> {
  Duration? _duration;
  Duration? _position;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;


  String get _durationText => _duration?.toString().split('.').first ?? '';

  String get _positionText => _position?.toString().split('.').first ?? '';

  AudioPlayer get player => widget.player;

  @override
  void initState() {
    super.initState();
    // Use initial values from player
    player.getDuration().then(
          (value) => setState(() {
            _duration = value;
          }),
        );
    player.getCurrentPosition().then(
          (value) => setState(() {
            _position = value;
          }),
        );
    _initStreams();
  }

  @override
  void setState(VoidCallback fn) {
    // Subscriptions only can be closed asynchronously,
    // therefore events can occur after widget has been disposed.
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If the current song is playing then show player button and slider according to its state.
    final songsProvider = context.watch<SongsProvider>();
    SongState songState =  songsProvider.isSongCurrentPlaying(widget.song)? songsProvider.getCurrentPlayingSongState():SongState.stopped;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Player button 
        PlayerButton(songState: songState, song: widget.song),
        
        // slider
        songState == SongState.stopped
            ? Slider(
                onChanged: (value) {},
                value: 0.0,
              )
            : Slider(
                onChanged: (value) {
                  final duration = _duration;
                  if (duration == null) {
                    return;
                  }
                  final position = value * duration.inMilliseconds;
                  player.seek(Duration(milliseconds: position.round()));
                },
                value: (_position != null &&
                        _duration != null &&
                        _position!.inMilliseconds > 0 &&
                        _position!.inMilliseconds < _duration!.inMilliseconds)
                    ? _position!.inMilliseconds / _duration!.inMilliseconds
                    : 0.0,
              ),
        songState == SongState.stopped
            ? const Text(
                '00:00/00:00',
                style: const TextStyle(fontSize: 16.0),
              )
            : Text(
                _position != null
                    ? '$_positionText / $_durationText'
                    : _duration != null
                        ? _durationText
                        : '',
                style: const TextStyle(fontSize: 16.0),
              ),
      ],
    );
  }

  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = player.onPositionChanged.listen(
      (p) => setState(() => _position = p),
    );
   
  }

  
  
}
