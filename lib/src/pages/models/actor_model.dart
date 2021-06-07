import 'package:flutter/cupertino.dart';


class Cast {

  List<Actor> actors = [];

  Cast.fromJsonList( List<dynamic> jsonList){

    if (jsonList == null) return;

    for (var item in jsonList) {
      final actor = new Actor.fromJsonMap(item);
      actors.add(actor);
    }
  }
}

class Actor {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String department;
  String job;

  Actor({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

 Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  getImg(){
    if(profilePath == null){
      return AssetImage('assets/img/no-avatar.png');
    } else {
      return "https://image.tmdb.org/t/p/w500/$profilePath";
    }
  }

}
