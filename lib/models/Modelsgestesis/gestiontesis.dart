// To parse this JSON data, do
//
//     final gestionartesis = gestionartesisFromMap(jsonString);

import 'dart:convert';

class Tesis {
  Tesis(
      {required this.correo,
      required this.fechadeinicio,
      required this.lineasdeinvestigacion,
      required this.matricula,
      required this.nameasesor,
      required this.nametesis,
      required this.nametesista,
      this.picture,
      this.id});

  String correo;
  String fechadeinicio;
  String lineasdeinvestigacion;
  int matricula;
  String nameasesor;
  String nametesis;
  String nametesista;
  String? picture;
  String? id;

  factory Tesis.fromJson(String str) => Tesis.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tesis.fromMap(Map<String, dynamic> json) => Tesis(
        correo: json["correo"],
        fechadeinicio: json["fechadeinicio"],
        lineasdeinvestigacion: json["lineasdeinvestigacion"],
        matricula: json["matricula"],
        nameasesor: json["nameasesor"],
        nametesis: json["nametesis"],
        nametesista: json["nametesista"],
        picture: json["picture"],
      );

  Map<String, dynamic> toMap() => {
        "correo": correo,
        "fechadeinicio": fechadeinicio,
        "lineasdeinvestigacion": lineasdeinvestigacion,
        "matricula": matricula,
        "nameasesor": nameasesor,
        "nametesis": nametesis,
        "nametesista": nametesista,
        "picture": picture,
      };

  Tesis copy() => Tesis(
        nameasesor: this.nameasesor,
        nametesis: this.nametesis,
        nametesista: this.nametesista,
        matricula: this.matricula,
        lineasdeinvestigacion: this.lineasdeinvestigacion,
        fechadeinicio: this.fechadeinicio,
        correo: this.correo,
        picture: this.picture,
        id: this.id,
      );
}
