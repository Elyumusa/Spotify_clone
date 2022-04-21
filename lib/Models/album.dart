class Album {
  final List<Artist> artists;
  final String href;
  final String id;
  final List images;
  final String name;
  final String total_tracks;
  final List tracks;
  Album(
      {required this.artists,
      required this.href,
      required this.id,
      required this.images,
      required this.name,
      required this.total_tracks,
      required this.tracks});
  Album.fromJson({required Map<String, dynamic> json})
      : id = json['id'],
        name = json['name'],
        images = json['images'],
        tracks = json['tracks'],
        total_tracks = json['total_tracks'],
        artists = json['artists'],
        href = json['href'];
}

class Track {
  final List<Artist> artists;
  final String id;
  final String name;
  final String href;
  Track.fromJson({required Map<String, dynamic> json})
      : id = json['id'],
        name = json['name'],
        artists = List.generate(json['artists'].length,
            (index) => Artist.fromJson(json: json['artists'][index])),
        href = json['href'];
}

class Artist {
  final String id;
  final String name;
  final String href;
  Artist.fromJson({required Map<String, dynamic> json})
      : id = json['id'],
        name = json['name'],
        href = json['href'];
}

class Image {
  final String height;
  final String url;
  final String width;
  Image.fromJson({required Map<String, dynamic> json})
      : height = json['height'].toString(),
        url = json['url'].toString(),
        width = json['width'].toString();
}
