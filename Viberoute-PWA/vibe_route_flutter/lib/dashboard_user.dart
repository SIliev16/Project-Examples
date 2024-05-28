import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:vibe_route_flutter/playlist_screen.dart';
import 'package:vibe_route_flutter/providers/playlist_provider.dart';

import 'models/playlist.dart';

class DashboardUser extends StatelessWidget {
  // Images for 'My Playlists'
  List<String> myPlaylistsImages = [
    'assets/images/yeat.jpg',
    'assets/images/fe!n.jpg',
    'assets/images/N95.jpg',
    'assets/images/lose_yourself.jpg',
  ];

// Images for 'Made For You'
  List<String> madeForYouImages = [
    'assets/Made_For_You_1.png',
    'assets/Made_For_You_2.png',
    'assets/Made_For_You_3.png',
    'assets/Made_For_You_4.png',
  ];

// 'Made For You' Playlists

  List<String> madeForYouPlaylists = [
    'MadeForYouPlaylist1',
    'MadeForYouPlaylist2',
    'MadeForYouPlaylist3',
    'MadeForYouPlaylist4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text('Dashboard',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo-noname.png'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('My Playlists'),
              _buildHorizontalCarousel(
                context,
                myPlaylistsImages,
                    (index) {
                },
              ),
              _buildSectionTitle('Made for you'),
              _buildHorizontalCarousel(
                context,
                madeForYouImages,
                    (index) {
                  Playlist playlist = PlaylistProvider.getPlaylist(madeForYouPlaylists[index]);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PlaylistScreen(
                        playlist: playlist,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, '/ride_started');
              },
              label: const Text(
                'Start Ride',
                style: TextStyle(
                    color: Color(0xFFFEFFF6),
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0
                ),
              ),
              backgroundColor: const Color(0xFFFF5313),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildHorizontalCarousel(BuildContext context, List<String> imageAssets, Function(int) onTap) {
    return Container(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageAssets.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              width: 170,
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageAssets[index]),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      ),
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
