import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spotify_clone/Models/sho.dart';
import 'package:spotify_clone/Models/album.dart';

class API {
  final _clientsecret = "cf11767ee8a9476181c4312221ae630a";
  final _client_id = "ecdcb5ad7fa7470ca45a8ed28902da42";
  final _main_url = "https://api.spotify.com/v1";
  authorize() async {
    final str = "$_client_id:$_clientsecret";
    final bytes = utf8.encode(str);
    final base64Str = base64.encode(bytes);
    print("basestr: $base64Str");
    final url = Uri.https(
      "accounts.spotify.com",
      "/api/token",
    ); //Uri.parse(_main_url);
    try {
      var response = await http.post(url,
          headers: {"Authorization": "Basic $base64Str"},
          body: {"grant_type": "client_credentials"});
      print("response body: ${response.body}");
      return response;
    } on Exception catch (e) {
      print("e: $e");
      return "Error occured";
    }
  }

  Future getShow(String id) async {
    var r = await authorize();
    if (r != "Error occured") {
      var jsonResponse = jsonDecode(r.body) as Map<String, dynamic>;
      var access_token = jsonResponse['access_token'];
      final url =
          Uri.https("api.spotify.com", "/v1/shows/$id", {"market": "US"});
      try {
        var response = await http.get(
          url,
          headers: {
            "Authorization": "Bearer $access_token"
          }, /* body: {"grant_type": "client_credentials"}*/
        );
        //print("re: ${response.body}");
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        String track = jsonResponse["tracks"]["items"][0]['name'];
        return Show(
            id: jsonResponse['id'],
            name: jsonResponse['name'],
            publisher: jsonResponse['publisher'],
            images: jsonResponse['images'].map((image) {
              return ImageModel.fromJson(json: image);
            }).toList(),
            episodes: jsonResponse['episodes']['items'].map((episode) {
              return Episode(
                  episode['name'],
                  episode['release_date'],
                  episode['id'],
                  episode['images'].map((image) {
                    return ImageModel.fromJson(json: image);
                  }).toList(),
                  episode['description']);
            }).toList(),
            description: jsonResponse['description']);
      } on Exception catch (e) {
        print("e $e");
        rethrow;
      }
    } else {
      print("Error occured");
      throw "Error occured";
    }
  }

  Future getShows(String id) async {
    var r = await authorize();
    if (r != "Error occured") {
      var jsonResponse = jsonDecode(r.body) as Map<String, dynamic>;
      var access_token = jsonResponse['access_token'];
      final url = Uri.https(
          "api.spotify.com", "/v1/shows/", {"market": "US", "ids": id});
      try {
        var response = await http.get(
          url,
          headers: {
            "Authorization": "Bearer $access_token"
          }, /* body: {"grant_type": "client_credentials"}*/
        );
        // print("re: ${response.body}");
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        //String track = jsonResponse["tracks"]["items"][0]['name'];
        print("sho: ${jsonResponse['shows'][0]['images'][0]['url']}");
        List<Show> finalList =
            List.generate(jsonResponse['shows'].length, (index) {
          print("print image: ${jsonResponse['shows'][index]['images']}");
          return Show(
              id: jsonResponse['shows'][index]['id'],
              name: jsonResponse['shows'][index]['name'],
              publisher: jsonResponse['shows'][index]['publisher'],
              images: //jsonResponse['shows'][index]['images'],
                  jsonResponse['shows'][index]['images'].map((image) {
                print("current image: ${image['height']}");
                return ImageModel.fromJson(json: image);
              }).toList(),
              /*episodes: jsonResponse['shows'][index]['episodes']['items']
                  .map((episode) {
                return Episode(
                    episode['name'],
                    episode['release_date'],
                    episode['id'],
                    episode['images'].map((image) {
                      return ImageModel.fromJson(json: image);
                    }).toList(),
                    episode['description']);
              }).toList(),*/
              description: jsonResponse['shows'][index]['description']);
        });
        print("finally good");
        return finalList;
      } on Exception catch (e) {
        print("e $e");
        rethrow;
      }
    } else {
      print("Error occured");
      throw "Error occured";
    }
  }

  Future getAlbum(String album_id) async {
    Map album = {};
    var r = await authorize();
    if (r != "Error occured") {
      var jsonResponse = jsonDecode(r.body) as Map<String, dynamic>;
      var access_token = jsonResponse['access_token'];
      final url = Uri.https("api.spotify.com", "/v1/albums/$album_id");
      try {
        var response = await http.get(
          url,
          headers: {
            "Authorization": "Bearer $access_token"
          }, /* body: {"grant_type": "client_credentials"}*/
        );
        // print("re: ${response.body}");
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        String track = jsonResponse["tracks"]["items"][0]['name'];
        album['Album'] = Album(
            href: jsonResponse['href'],
            id: jsonResponse['id'],
            name: jsonResponse['name'],
            total_tracks: jsonResponse['total_tracks'].toString(),
            tracks: List.generate(
                jsonResponse['tracks']["items"].length,
                (index) => Track.fromJson(
                    json: jsonResponse['tracks']["items"][index])).map((track) {
              track.images = List.generate(
                  jsonResponse['images'].length,
                  (index) =>
                      ImageModel.fromJson(json: jsonResponse['images'][index]));
              return track;
            }).toList(),
            images: List.generate(
                jsonResponse['images'].length,
                (index) =>
                    ImageModel.fromJson(json: jsonResponse['images'][index])),
            artists: List.generate(
                jsonResponse['artists'].length,
                (index) =>
                    Artist.fromJson(json: jsonResponse['artists'][index])));
        //print("tracks: ${album["Album"].tracks}");
        return album['Album'];
      } on Exception catch (e) {
        print("e $e");
        rethrow;
      }
    }
  }

  Future getAlbums(String album_ids) async {
    List albums = [];
    var r = await authorize();
    if (r != "Error occured") {
      var jsonResponse = jsonDecode(r.body) as Map<String, dynamic>;
      var access_token = jsonResponse['access_token'];

      final url = Uri.https(
          "api.spotify.com", "/v1/albums/", {"market": "US", "ids": album_ids});
      try {
        print("elyu papa try");
        var response = await http.get(
          url,
          headers: {
            "Authorization": "Bearer $access_token"
          }, /* body: {"grant_type": "client_credentials"}*/
        );
        // print("re in elyu: ${response.body}");
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        String track = jsonResponse['albums'][1]["tracks"]["items"][0]['href'];
        print("track: $track");
        albums = List.generate(jsonResponse['albums'].length, (index) {
          final currentAlbum = jsonResponse['albums'][index];
          return Album(
              href: currentAlbum['href'],
              id: currentAlbum['id'],
              name: currentAlbum['name'],
              total_tracks: currentAlbum['total_tracks'].toString(),
              tracks: List.generate(
                  currentAlbum['tracks']["items"].length,
                  (i) => Track.fromJson(
                      json: currentAlbum['tracks']["items"][i])).map((track) {
                track.images = List.generate(
                    currentAlbum['images'].length,
                    (i) =>
                        ImageModel.fromJson(json: currentAlbum['images'][i]));
                return track;
              }).toList(),
              images: List.generate(currentAlbum['images'].length,
                  (i) => ImageModel.fromJson(json: currentAlbum['images'][i])),
              artists: List.generate(currentAlbum['artists'].length,
                  (i) => Artist.fromJson(json: currentAlbum['artists'][i])));
        });
        print("tracks in elyupapa : ${albums.length}");
        return albums;
      } on Exception catch (e) {
        print("error in elyu $e");
        rethrow;
      }
    }
  }

  Future search(String query) async {
    var r = await authorize();
    if (r != "Error occured") {
      var jsonResponse = jsonDecode(r.body) as Map<String, dynamic>;
      var access_token = jsonResponse['access_token'];
      final url = Uri.https("api.spotify.com", "/v1/search",
          {'q': "$query", "type": "track,artist"});
      try {
        var response = await http.get(
          url,
          headers: {
            "Authorization": "Bearer $access_token"
          }, /* body: {"grant_type": "client_credentials"}*/
        );
        print("re: ${response.body}");
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

        return List.generate(jsonResponse['tracks']["items"].length, (index) {
          Track t =
              Track.fromJson(json: jsonResponse['tracks']["items"][index]);
          t.images = List.generate(
              jsonResponse['tracks']["items"][index]['album']['images'].length,
              (i) => ImageModel.fromJson(
                  json: jsonResponse['tracks']["items"][index]['album']
                      ['images'][i]));
          return t;
        });
      } on Exception catch (e) {
        print("e $e");
        // rethrow;
      }
    }
  }
}
