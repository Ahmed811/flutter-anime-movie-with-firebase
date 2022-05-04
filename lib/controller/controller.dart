import 'package:anim_movies/models/movie_model.dart';
import 'package:anim_movies/services/movies_services/movies_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Controller with ChangeNotifier {
  var url = "";
  var moviesDetails;
  getDatabaseMovies() async {
    await FirebaseFirestore.instance
        .collection('movies-list')
        .get()
        .then((value) {
      print(value.docs[0]['movies-url']);
      url = value.docs[0]['movies-url'];
      MovieServices().getMovieDetails(url);
      //     .then((data) {
      //   // moviesDetails.add(data);
      //   // moviesDetails = data;
      //   // print(moviesDetails);
      //   notifyListeners();
      // });
      // print("movies: ${moviesDetails}");
    });

    return MovieServices().getMovieDetails(url);
  }
}
