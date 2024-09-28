import 'package:flutter/material.dart';
import 'package:music_player/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
      songName: "So Sick",
      artistName: "Mayonnaise",
      albumArtImagePath: "assets/images/sample1.jpg",
      audioPath: "audio/Mendelssohn.mp3",
    ),
    Song(
      songName: "Sample Song 2",
      artistName: "Some other Artist",
      albumArtImagePath: "assets/images/sample2.jpg",
      audioPath: "audio/Mendelssohn.mp3",
    ),
    Song(
      songName: "Sample Song 3",
      artistName: "Final Artist",
      albumArtImagePath: "assets/images/sample3.jpeg",
      audioPath: "audio/Mendelssohn.mp3",
    ),
  ];

  // current song playing index
  int? _currentSongIndex;

  // getters

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;

  // setters

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    notifyListeners();
  }
}
