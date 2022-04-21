import 'dart:convert';
import 'package:http/http.dart' as http;
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

  Future getKygoAlbum(String album_id) async {
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
        print("re: ${response.body}");
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
                    json: jsonResponse['tracks']["items"][index])),
            images: List.generate(jsonResponse['images'].length,
                (index) => Image.fromJson(json: jsonResponse['images'][index])),
            artists: List.generate(
                jsonResponse['artists'].length,
                (index) =>
                    Artist.fromJson(json: jsonResponse['artists'][index])));
        print("tracks: ${album["Album"].tracks}");
        return album['Album'];
      } on Exception catch (e) {
        print("e $e");
        rethrow;
      }
    }
  }

  Future getShows() async {}
}
