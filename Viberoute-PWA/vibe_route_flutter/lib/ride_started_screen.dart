import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibe_route_flutter/providers/playlist_provider.dart';
import 'models/playlist.dart';
import 'models/song.dart';

class RideStartedScreen extends StatefulWidget {
  final String playlistName;

  RideStartedScreen({this.playlistName = 'MadeForYouPlaylist4'});

  @override
  _RideStartedScreenState createState() => _RideStartedScreenState();
}

class _RideStartedScreenState extends State<RideStartedScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  double volume = 1.0;
  Playlist? playlist;
  Song? currentSong;
  int currentSongIndex = 0;

  @override
  void initState() {
    super.initState();
    playlist = PlaylistProvider.getPlaylist(widget.playlistName);
    setupAudio();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      if (duration != Duration.zero) {
        setState(() {
          position = newPosition > duration ? duration : newPosition;
        });
      }
    });
    audioPlayer.onPlayerCompletion.listen((event) {
      playNext();
    });
  }

  Future<void> setupAudio() async {
    if (playlist?.songs.isNotEmpty == true) {
      await audioPlayer.setUrl(playlist!.songs.first.songAsset, isLocal: true);
      await audioPlayer.play(playlist!.songs.first.songAsset, isLocal: true);
      setState(() {
        currentSong = playlist!.songs.first;
        isPlaying = true;
      });
    }
  }

  Duration parseSongLength(String length) {
    List<String> parts = length.split(':');
    return Duration(minutes: int.parse(parts[0]), seconds: int.parse(parts[1]));
  }

  Future<void> playSong(Song song) async {
    Duration songDuration = parseSongLength(song.length);
    await audioPlayer.setUrl(song.songAsset, isLocal: true);
    await audioPlayer.setVolume(volume);
    setState(() {
      currentSong = song;
      duration = songDuration;
      isPlaying = true;
    });
    audioPlayer.play(song.songAsset, isLocal: true);
  }

  void togglePlayPause() {
    if (isPlaying) {
      audioPlayer.pause();
    } else {
      audioPlayer.resume();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void playNext() {
    if (currentSongIndex < (playlist?.songs.length ?? 0) - 1) {
      currentSongIndex++;
      playSong(playlist!.songs[currentSongIndex]);
    } else {
      currentSongIndex = 0;
      playSong(playlist!.songs[currentSongIndex]);
    }
  }

  void playPrevious() {
    if (currentSongIndex > 0) {
      currentSongIndex--;
      playSong(playlist!.songs[currentSongIndex]);
    }
  }

  void seek(double value) {
    final newPosition = Duration(seconds: value.toInt());
    audioPlayer.seek(newPosition);

    setState(() {
      position = newPosition;
    });
  }

  void changeVolume(double newVolume) {
    final clampedVolume = newVolume.clamp(0.0, 1.0);
    audioPlayer.setVolume(clampedVolume);
    setState(() => volume = clampedVolume);
  }


  @override
  void dispose() {
    audioPlayer.onPlayerStateChanged.drain();
    audioPlayer.onDurationChanged.drain();
    audioPlayer.onAudioPositionChanged.drain();
    audioPlayer.onPlayerCompletion.drain();
    audioPlayer.dispose();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  Widget build(BuildContext context) {
    final songImage = currentSong?.imageAsset ?? 'assets/images/alright.png';
    final songTitle = currentSong?.title ?? 'Unknown Title';
    final songArtist = currentSong?.artist ?? 'Unknown Artist';
    final songDuration = formatTime(duration);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            SizedBox(height: 20),
            Image.asset(
              songImage,
              width: MediaQuery.of(context).size.width * 0.6,
            ),
            Text(
              songTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              songArtist,
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  formatTime(position),
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  songDuration,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Color(0xFFFFC100),
                thumbColor: Color(0xFFFFC100),
              ),
              child: Slider(
                value: position.inSeconds.toDouble(),
                min: 0,
                max: duration.inSeconds.toDouble(),
                onChanged: (value) {
                  if (duration.inSeconds > 0) {
                    seek(value);
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous, size: 36),
                  onPressed: playPrevious,
                ),
                IconButton(
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, size: 36),
                  onPressed: togglePlayPause,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next, size: 36),
                  onPressed: playNext,
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.volume_down),
                  onPressed: () => changeVolume(volume - 0.1),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Color(0xFFFFC100),
                    thumbColor: Color(0xFFFFC100),
                  ),
                  child: Slider(
                    value: volume,
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    onChanged: changeVolume,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.volume_up),
                  onPressed: () => changeVolume(volume + 0.1),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                audioPlayer.stop();
                Navigator.of(context).pushReplacementNamed('/ride_finished');
              },
              child: Text(
                'Finish Ride',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFFF5313),
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              ),
            ),

            Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF403101),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.house, size: 30),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 30),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(MaterialCommunityIcons.history, size: 30),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings, size: 30),
          label: '',
        ),
      ],
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: const Color(0xFFFEFFF6),
    );
  }

}
