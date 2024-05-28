class Song {
  final String title;
  final String artist;
  final String length;
  final String songAsset;
  final String imageAsset;

  Song({
    required this.title,
    required this.artist,
    required this.length,
    required this.songAsset,
    required this.imageAsset,
  });

  Duration get duration {
    final parts = length.split(':');
    return Duration(minutes: int.parse(parts[0]), seconds: int.parse(parts[1]));
  }
}
