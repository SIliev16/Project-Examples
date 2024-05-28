import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/playlist.dart';

class PlaylistScreen extends StatelessWidget {
  final Playlist playlist;

  const PlaylistScreen({Key? key, required this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Helper function to build a song card
    Widget _buildSongCard(String songImageAsset, String title, String artist, String length) {
      return Card(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade800, width: 1),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: ListTile(
          leading: Image.asset(songImageAsset, width: 50, height: 50),
          title: Text(title),
          subtitle: Text(artist),
          trailing: Text(
            length,
            style: TextStyle(fontWeight: FontWeight.bold), // Bolder song length
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Made For You'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            alignment: Alignment.center,
            child: Image.asset(
              playlist.imageAsset,
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "This playlist is specifically generated to your music taste and previous listens.",
              style: TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: playlist.songs.length,
              itemBuilder: (context, index) {
                final song = playlist.songs[index];
                return _buildSongCard(
                  song.imageAsset,
                  song.title,
                  song.artist,
                  song.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
