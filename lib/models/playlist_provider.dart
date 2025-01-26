import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  List<Song> _playlist = [];
  List<Song> _filteredPlaylist = [];
  final _random = Random();
  int? _currentSongIndex;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isPlaying = false;
  bool _isLoading = false;
  String _searchQuery = '';

  // Extended song data
  final List<String> _artists = [
    'Ed Sheeran', 'Taylor Swift', 'The Weeknd', 'Billie Eilish', 'Drake',
    'Adele', 'Post Malone', 'Ariana Grande', 'Justin Bieber', 'Lady Gaga',
    'Kendrick Lamar', 'Rihanna', 'Bruno Mars', 'Dua Lipa', 'Harry Styles',
    'Beyoncé', 'Travis Scott', 'Katy Perry', 'The Beatles', 'Queen',
    'Michael Jackson', 'Madonna', 'Eminem', 'Coldplay', 'Maroon 5',
    'Pink Floyd', 'Led Zeppelin', 'Nirvana', 'AC/DC', 'Metallica'
  ];

  final List<String> _songPrefixes = [
    'Love', 'Heart', 'Night', 'Dream', 'Sweet', 'Dance', 'Summer', 'Winter',
    'Spring', 'Fall', 'Lost', 'Found', 'Break', 'Make', 'Take', 'Give',
    'Stay', 'Go', 'Run', 'Walk', 'Fly', 'Rise', 'Fall', 'Shine', 'Glow',
    'Dark', 'Light', 'Sun', 'Moon', 'Star', 'Sky', 'Ocean', 'River', 'Mountain',
    'Valley', 'City', 'Street', 'Road', 'Path', 'Way'
  ];

  final List<String> _songSuffixes = [
    'Story', 'Song', 'Dance', 'Romance', 'Dreams', 'Lights', 'Nights',
    'Days', 'Love', 'Heart', 'Soul', 'Mind', 'Life', 'Time', 'Moment',
    'Forever', 'Never', 'Always', 'Sometimes', 'Today', 'Tomorrow', 'Yesterday',
    'Paradise', 'Heaven', 'World', 'Universe', 'Galaxy', 'Star', 'Moon',
    'Sun', 'Rain', 'Storm', 'Wind', 'Fire', 'Ice'
  ];

  final List<String> _genres = [
    'Pop', 'Rock', 'Hip Hop', 'R&B', 'Country', 'Jazz', 'Classical',
    'Electronic', 'Folk', 'Blues', 'Metal', 'Indie', 'Alternative',
    'Dance', 'Reggae', 'Soul', 'Funk', 'Disco', 'Punk', 'Gospel'
  ];

  final List<String> _audioUrls = [
    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3',
    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3',
  ];

  // Real song database (popular songs) to mix with generated ones
  final List<Map<String, String>> _realSongDatabase = [
    {'title': 'Shape of You', 'artist': 'Ed Sheeran'},
    {'title': 'Blinding Lights', 'artist': 'The Weeknd'},
    {'title': 'Bad Guy', 'artist': 'Billie Eilish'},
    {'title': 'Stay With Me', 'artist': 'Sam Smith'},
    {'title': 'Uptown Funk', 'artist': 'Mark Ronson ft. Bruno Mars'},
    {'title': 'Someone Like You', 'artist': 'Adele'},
    {'title': 'Thinking Out Loud', 'artist': 'Ed Sheeran'},
    {'title': 'Rolling in the Deep', 'artist': 'Adele'},
    {'title': 'Blank Space', 'artist': 'Taylor Swift'},
    {'title': 'Watermelon Sugar', 'artist': 'Harry Styles'},
    {'title': 'Bad Romance', 'artist': 'Lady Gaga'},
    {'title': 'Bohemian Rhapsody', 'artist': 'Queen'},
    {'title': 'Thriller', 'artist': 'Michael Jackson'},
    {'title': 'Hey Jude', 'artist': 'The Beatles'},
    {'title': 'Stairway to Heaven', 'artist': 'Led Zeppelin'},
    {'title': 'Smells Like Teen Spirit', 'artist': 'Nirvana'},
    {'title': 'Sweet Child O\' Mine', 'artist': 'Guns N\' Roses'},
    {'title': 'Like a Rolling Stone', 'artist': 'Bob Dylan'},
    {'title': 'Billie Jean', 'artist': 'Michael Jackson'},
    {'title': 'Purple Rain', 'artist': 'Prince'},
  ];

  PlaylistProvider() {
    _initializePlaylist();
    listenToDuration();
  }

  String _generateSongTitle() {
    if (_random.nextDouble() < 0.3) {
      // 30% chance to use a real song
      return _realSongDatabase[_random.nextInt(_realSongDatabase.length)]['title']!;
    } else {
      // 70% chance to generate a new song title
      final usePrefix = _random.nextBool();
      final useSuffix = _random.nextBool();
      final useConnector = _random.nextBool();

      List<String> parts = [];

      if (usePrefix) {
        parts.add(_songPrefixes[_random.nextInt(_songPrefixes.length)]);
      }

      if (useConnector && parts.isNotEmpty) {
        parts.add(['of', 'in', 'and', 'the', 'my', 'your', 'our'][_random.nextInt(7)]);
      }

      if (useSuffix || parts.isEmpty) {
        parts.add(_songSuffixes[_random.nextInt(_songSuffixes.length)]);
      }

      return parts.join(' ');
    }
  }

  String _getArtist() {
    if (_random.nextDouble() < 0.3) {
      // 30% chance to use a real artist
      return _realSongDatabase[_random.nextInt(_realSongDatabase.length)]['artist']!;
    } else {
      // 70% chance to use from artists list
      return _artists[_random.nextInt(_artists.length)];
    }
  }

  Future<void> _initializePlaylist() async {
    _createPlaylistFromDatabase();
    if (_playlist.isNotEmpty && _currentSongIndex == null) {
      _currentSongIndex = 0;
      _filteredPlaylist = List.from(_playlist);
      notifyListeners();
    }
  }

  void _createPlaylistFromDatabase() {
    // Generate 1000 songs initially
    for (int i = 0; i < 1000; i++) {
      _playlist.add(Song(
        songName: _generateSongTitle(),
        artistName: _getArtist(),
        albumArtUrl: 'https://picsum.photos/seed/${_random.nextInt(10000)}/200/200',
        audioUrl: _audioUrls[_random.nextInt(_audioUrls.length)],
      ));
    }
    _filteredPlaylist = List.from(_playlist);
    notifyListeners();
  }

  // Load more songs when needed (e.g., when scrolling)
  void loadMoreSongs([int count = 50]) {
    for (int i = 0; i < count; i++) {
      _playlist.add(Song(
        songName: _generateSongTitle(),
        artistName: _getArtist(),
        albumArtUrl: 'https://picsum.photos/seed/${_random.nextInt(10000)}/200/200',
        audioUrl: _audioUrls[_random.nextInt(_audioUrls.length)],
      ));
    }

    if (_searchQuery.isEmpty) {
      _filteredPlaylist = List.from(_playlist);
    } else {
      search(_searchQuery);
    }

    notifyListeners();
  }

  // Rest of the methods remain the same
  void search(String query) {
    _searchQuery = query.toLowerCase();
    if (_searchQuery.isEmpty) {
      _filteredPlaylist = List.from(_playlist);
    } else {
      _filteredPlaylist = _playlist.where((song) {
        return song.songName.toLowerCase().contains(_searchQuery) ||
            song.artistName.toLowerCase().contains(_searchQuery);
      }).toList();
    }
    notifyListeners();
  }

  Song? get currentSong {
    if (_currentSongIndex == null || _currentSongIndex! >= _playlist.length) {
      return null;
    }
    return _playlist[_currentSongIndex!];
  }

  int? get currentFilteredIndex {
    if (currentSong == null) return null;
    return _filteredPlaylist.indexOf(currentSong!);
  }

  int _getActualIndex(int filteredIndex) {
    if (filteredIndex >= _filteredPlaylist.length) return 0;
    final Song filteredSong = _filteredPlaylist[filteredIndex];
    return _playlist.indexOf(filteredSong);
  }

  Future<void> play() async {
    if (_currentSongIndex == null || _currentSongIndex! >= _playlist.length) return;

    _isLoading = true;
    notifyListeners();

    final String url = _playlist[_currentSongIndex!].audioUrl;
    await _audioPlayer.stop();
    await _audioPlayer.play(UrlSource(url));
    _isPlaying = true;
    _isLoading = false;
    notifyListeners();
  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      if (_currentDuration.inSeconds > 0) {
        resume();
      } else {
        play();
      }
    }
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextSong() {
    if (_currentSongIndex != null) {
      _currentSongIndex = (_currentSongIndex! + 1) % _playlist.length;
      if (_isPlaying) {
        play();
      } else {
        notifyListeners();
      }
    }
  }

  void playPreviousSong() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        _currentSongIndex = _currentSongIndex! - 1;
        if (_isPlaying) {
          play();
        } else {
          notifyListeners();
        }
      }
    }
  }

  void playRandomSong() {
    if (_playlist.isNotEmpty) {
      _currentSongIndex = _random.nextInt(_playlist.length);
      if (_isPlaying) {
        play();
      } else {
        notifyListeners();
      }
    }
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      if (_isPlaying) {
        playNextSong();
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Getters
  List<Song> get playlist => _filteredPlaylist;
  List<Song> get fullPlaylist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // Setters
  set currentSongIndex(int? newIndex) {
    if (newIndex != null) {
      _currentSongIndex = _getActualIndex(newIndex);
    } else {
      _currentSongIndex = newIndex;
    }
    notifyListeners();
  }
}