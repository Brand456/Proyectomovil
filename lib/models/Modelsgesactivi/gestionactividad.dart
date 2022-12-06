// To parse this JSON data, do
//
//     final gestionartesis = gestionartesisFromMap(jsonString);

import 'dart:convert';

class Act {
  Act(
      {required this.entregableindi,
      required this.fechadefin,
      required this.fechadeinicio,
      required this.nombreactividad,
      this.picture,
      this.id});

  String entregableindi;
  String fechadefin;
  String fechadeinicio;
  String nombreactividad;
  String? picture;
  String? id;

  factory Act.fromJson(String str) => Act.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Act.fromMap(Map<String, dynamic> json) => Act(
        entregableindi: json["entregableindi"],
        fechadefin: json["fechadefin"],
        fechadeinicio: json["fechadeinicio"],
        nombreactividad: json["nombreactividad"],
        picture: json["picture"],
      );

  Map<String, dynamic> toMap() => {
        "entregableindi": entregableindi,
        "fechadefin": fechadefin,
        "fechadeinicio": fechadeinicio,
        "nombreactividad": nombreactividad,
        "picture": picture,
      };

  Act copy() => Act(
        entregableindi: this.entregableindi,
        fechadefin: this.fechadefin,
        nombreactividad: this.nombreactividad,
        fechadeinicio: this.fechadeinicio,
        picture: this.picture,
        id: this.id,
      );
}
