import 'dart:convert' as convert;
import 'dart:convert';

import 'package:anim_movies/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieServices {
  getMovieDetails(String uri) async {
    var url = Uri.parse(uri);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      //print(jsonDecode(response.body));
      // print(MovieModel.fromJson(convert.jsonDecode(response.body[0])));
      return json.decode(utf8.decode(response.bodyBytes));
    }
  }
}
