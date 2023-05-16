class Album {
  List? artists;
  final String href;
  final String id;
  List? images;
  final String name;
  final String total_tracks;
  List? tracks;
  Album(
      {this.artists,
      required this.href,
      required this.id,
      this.images,
      required this.name,
      required this.total_tracks,
      this.tracks});
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
  List? artists;
  final String id;
  final String name;
  final String href;
  List? images;
  Track.fromJson({required Map<String, dynamic> json})
      : id = json['id'],
        name = json['name'],
        /*images = List.generate(json['album']['images'].length,
            (index) => Image.fromJson(json: json['album']['images'][index])),*/
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

class ImageModel {
  final String height;
  final String url;
  final String width;
  ImageModel.fromJson({required Map<String, dynamic> json})
      : height = json['height'].toString(),
        url = json['url'].toString(),
        width = json['width'].toString();
}
