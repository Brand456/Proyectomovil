// To parse this JSON data, do
//
//     final gestionaraviso = gestionaravisoFromMap(jsonString);

import 'dart:convert';

class Aviso {
  Aviso({
    required this.aviso,
    required this.fecha,
    this.id,
    required this.nombreaviso,
    this.picture,
  });

  String aviso;
  String fecha;
  String? id;
  String nombreaviso;
  String? picture;

  factory Aviso.fromJson(String str) => Aviso.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Aviso.fromMap(Map<String, dynamic> json) => Aviso(
        aviso: json["aviso"],
        fecha: json["fecha"],
        id: json["id"],
        nombreaviso: json["nombreaviso"],
        picture: json["picture"],
      );

  Map<String, dynamic> toMap() => {
        "aviso": aviso,
        "fecha": fecha,
        "id": id,
        "nombreaviso": nombreaviso,
        "picture": picture,
      };

  Aviso copy() => Aviso(
        nombreaviso: this.nombreaviso,
        aviso: this.aviso,
        fecha: this.fecha,
        picture: this.picture,
        id: this.id,
      );
}
