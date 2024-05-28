import '../models/playlist.dart';
import '../models/song.dart';

class PlaylistProvider {
  static Map<String, Playlist> playlists = {
    'MadeForYouPlaylist1': Playlist(
      imageAsset: 'assets/Made_For_You_1.png',
      songs: [
        Song(
          title: 'GODS',
          artist: 'NewJeans',
          length: '4:15',
          songAsset: 'assets/songs/GODS.mp3',
          imageAsset: 'assets/images/gods.png',
        ),
        Song(
          title: 'Rolling In The Deep',
          artist: 'Adele',
          length: '3:48',
          songAsset: 'assets/songs/Adele - Rolling In The Deep.mp3',
          imageAsset: 'assets/images/rolling.jpg',
        ),
        Song(
          title: 'Alright',
          artist: 'Kendrick Lamar',
          length: '3:14',
          songAsset: 'assets/songs/Alright.mp3',
          imageAsset: 'assets/images/alright.jpg',
        ),
        Song(
          title: 'Havana',
          artist: 'Camila Cabello',
          length: '3:37',
          songAsset: 'assets/songs/Camila Cabello - Havana (Audio) ft. Young Thug.mp3',
          imageAsset: 'assets/images/havana.jpg',
        ),
        Song(
          title: 'Hotline Bling',
          artist: 'Drake',
          length: '4:27',
          songAsset: 'assets/songs/Drake- Hotline Bling (Official Audio).mp3',
          imageAsset: 'assets/images/hotline_bling.jpg',
        ),
      ],
    ),
    'MadeForYouPlaylist2': Playlist(
      imageAsset: 'assets/Made_For_You_2.png',
      songs: [
        Song(
          title: 'One Kiss',
          artist: 'Dua Lipa',
          length: '3:34',
          songAsset: 'assets/songs/Dua Lipa - One Kiss (ft Calvin Harris).mp3',
          imageAsset: 'assets/images/one_kiss.jpg',
        ),
        Song(
          title: 'Shape Of You',
          artist: 'Ed Sheeran',
          length: '3:53',
          songAsset: 'assets/songs/Ed Sheeran - Shape Of You (Audio).mp3',
          imageAsset: 'assets/images/shape_of_you.jpg',
        ),
        Song(
          title: 'Firework',
          artist: 'Katy Perry',
          length: '3:48',
          songAsset: 'assets/songs/Firework (Audio) - Katy Perry.mp3',
          imageAsset: 'assets/images/firework.jpg',
        ),
        Song(
          title: 'Flawlëss',
          artist: 'Yeat',
          length: '2:56',
          songAsset: 'assets/songs/Flawlëss (feat. Lil Uzi Vert) [Official Audio].mp3',
          imageAsset: 'assets/images/yeat.jpg',
        ),
        Song(
          title: 'Gold Digger',
          artist: 'Kanye West',
          length: '3:33',
          songAsset: 'assets/songs/Gold Digger.mp3',
          imageAsset: 'assets/images/gold_digger.jpg',
        ),
      ],
    ),
    'MadeForYouPlaylist3': Playlist(
      imageAsset: 'assets/Made_For_You_3.png',
      songs: [
        Song(
          title: 'Empire State Of Mind',
          artist: 'JAY-Z',
          length: '4:44',
          songAsset: 'assets/songs/JAY-Z - Empire State Of Mind (Feat. Alicia Keys) (Official Audio).mp3',
          imageAsset: 'assets/images/empire_state.jpg',
        ),
        Song(
          title: 'Can\'t Stop The Feeling',
          artist: 'Justin Timberlake',
          length: '4:02',
          songAsset: 'assets/songs/Justin Timberlake - Can\'t Stop The Feeling (audio).mp3',
          imageAsset: 'assets/images/cant_stop_the_feeling.jpg',
        ),
        Song(
          title: 'Bad Romance',
          artist: 'Lady Gaga',
          length: '5:02',
          songAsset: 'assets/songs/Lady Gaga - Bad Romance (Audio).mp3',
          imageAsset: 'assets/images/bad_romance.jpg',
        ),
        Song(
          title: 'Lose Yourself',
          artist: 'Eminem',
          length: '5:29',
          songAsset: 'assets/songs/Lose Yourself (From _8 Mile_ Soundtrack).mp3',
          imageAsset: 'assets/images/lose_yourself.jpg',
        ),
        Song(
          title: 'Uptown Funk',
          artist: 'Mark Ronson ft. Bruno Mars',
          length: '4:37',
          songAsset: 'assets/songs/Mark Ronson - Uptown Funk (Official Audio) ft. Bruno Mars.mp3',
          imageAsset: 'assets/images/uptown_funk.jpg',
        ),
      ],
    ),
    'MadeForYouPlaylist4': Playlist(
      imageAsset: 'assets/Made_For_You_4.png',
      songs: [
        Song(
          title: 'Power',
          artist: 'Jaxson Gamble',
          length: '2:24',
          songAsset: 'assets/songs/Power.mp3',
          imageAsset: 'assets/images/power.jpg',
        ),
        Song(
          title: 'Backyard',
          artist: 'Travis Scott',
          length: '4:37',
          songAsset: 'assets/songs/Travis Scott - Backyard.mp3',
          imageAsset: 'assets/images/backyard.jpg',
        ),
        Song(
          title: 'FE!N',
          artist: 'Travis Scott ft. Playboi Carti',
          length: '3:13',
          songAsset: 'assets/songs/Travis Scott - FE!N (Official Audio) ft. Playboi Carti.mp3',
          imageAsset: 'assets/images/fe!n.jpg',
        ),
        Song(
          title: 'VVV',
          artist: 'YEAT ft. Playboi Carti',
          length: '3:47',
          songAsset: 'assets/songs/YEAT - VVV (ft. Playboi Carti) [PROD. SANIKWAVE].mp3',
          imageAsset: 'assets/images/yeat.jpg',
        ),
        Song(
          title: 'Fighting My Demons',
          artist: 'Ken Carson',
          length: '2:30', //
          songAsset: 'assets/songs/Ken Carson - Fighting My Demons (Official Audio).mp3',
          imageAsset: 'assets/images/fighting_my_demons.jpg',
        ),
        Song(
          title: 'N95',
          artist: 'Kendrick Lamar',
          length: '3:16',
          songAsset: 'assets/songs/Kendrick Lamar - N95 (Official Audio).mp3',
          imageAsset: 'assets/images/N95.jpg',
        ),
      ],
    ),

  };

  static Playlist getPlaylist(String playlistName) {
    return playlists[playlistName]!;
  }
}
