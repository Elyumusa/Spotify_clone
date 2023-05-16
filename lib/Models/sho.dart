import 'package:spotify_clone/Models/album.dart';

class Show {
  final String description;
  final String id;
  final String name;
  final String publisher;
  final List? images;
  List<Episode>? episodes;
  Show(
      {required this.id,
      required this.name,
      required this.publisher,
      this.images,
      this.episodes,
      required this.description});
  Show.fromMap({required Map<String, dynamic> json})
      : id = json['id'],
        name = json['name'],
        publisher = json['publisher'],
        description = json["description"],
        images = json['images'],
        episodes = json['episodes'];
}

class Episode {
  final String name;
  final String release_date;
  final String id;
  final List<ImageModel> images;
  final String description;

  Episode(this.name, this.release_date, this.id, this.images, this.description);
  Episode.fromMap({required Map<String, dynamic> json})
      : id = json['id'],
        name = json['name'],
        release_date = json['release_date'],
        description = json["description"],
        images = json['images'];
}
