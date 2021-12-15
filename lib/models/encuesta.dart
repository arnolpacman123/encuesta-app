// To parse this JSON data, do
//
//     final encuestas = encuestaFromMap(jsonString);

import 'dart:convert';

List<Encuesta> encuestasFromMap(String str) => List<Encuesta>.from(
      json.decode(str).map(
            (x) => Encuesta.fromMap(x),
          ),
    );

String encuestasToMap(List<Encuesta> data) => json.encode(
      List<dynamic>.from(
        data.map((x) => x.toMap()),
      ),
    );

Encuesta encuestaFromMap(String str) => Encuesta.fromMap(json.decode(str));

String encuestaToMap(Encuesta data) => json.encode(data.toMap());

class Encuesta {
  Encuesta({
    this.id,
    this.titulo,
    this.descripcion,
    this.estado,
    this.secciones,
    this.aplicacionesEncuestas,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.preguntas,
  });

  final String? id;
  final String? titulo;
  final String? descripcion;
  final bool? estado;
  final List<Seccion?>? secciones;
  final List<dynamic>? aplicacionesEncuestas;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final List<Pregunta>? preguntas;

  factory Encuesta.fromMap(Map<String, dynamic> json) => Encuesta(
        id: json["_id"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        estado: json["estado"],
        secciones: json["secciones"] == null
            ? null
            : List<Seccion>.from(
                json["secciones"].map((x) => Seccion.fromMap(x))),
        aplicacionesEncuestas: json["aplicaciones_encuestas"] == null
            ? null
            : List<dynamic>.from(json["aplicaciones_encuestas"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        v: json["__v"],
        preguntas: json["preguntas"] == null
            ? null
            : List<Pregunta>.from(
                json["preguntas"].map((x) => Pregunta.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "titulo": titulo,
        "descripcion": descripcion,
        "estado": estado,
        "secciones": secciones == null
            ? null
            : List<dynamic>.from(secciones!.map((x) => x!.toMap())),
        "aplicaciones_encuestas": aplicacionesEncuestas == null
            ? null
            : List<dynamic>.from(aplicacionesEncuestas!.map((x) => x)),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "__v": v,
        "preguntas": preguntas == null
            ? null
            : List<dynamic>.from(preguntas!.map((x) => x.toMap())),
      };
}

class Seccion {
  Seccion({
    this.id,
    this.titulo,
    this.descripcion,
    this.estado,
    this.preguntas,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  final String? id;
  final String? titulo;
  final String? descripcion;
  final bool? estado;
  final List<Pregunta>? preguntas;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Seccion.fromMap(Map<String, dynamic> json) => Seccion(
        id: json["_id"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        estado: json["estado"],
        preguntas: List<Pregunta>.from(
            json["preguntas"].map((x) => Pregunta.fromMap(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "titulo": titulo,
        "descripcion": descripcion,
        "estado": estado,
        "preguntas": List<dynamic>.from(preguntas!.map((x) => x.toMap())),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "__v": v,
      };
}

class Pregunta {
  Pregunta({
    this.id,
    this.enunciado,
    this.estado,
    this.tipoPregunta,
    this.opciones,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  final String? id;
  final String? enunciado;
  final bool? estado;
  final TipoPregunta? tipoPregunta;
  final List<Opcion?>? opciones;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Pregunta.fromMap(Map<String, dynamic> json) => Pregunta(
        id: json["_id"],
        enunciado: json["enunciado"],
        estado: json["estado"],
        tipoPregunta: TipoPregunta.fromMap(json["tipo_pregunta"]),
        opciones:
            List<Opcion>.from(json["opciones"].map((x) => Opcion.fromMap(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "enunciado": enunciado,
        "estado": estado,
        "tipo_pregunta": tipoPregunta!.toMap(),
        "opciones": List<dynamic>.from(opciones!.map((x) => x!.toMap())),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "__v": v,
      };
}

class Opcion {
  Opcion({
    this.id,
    this.valor,
    this.estado,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  final String? id;
  late final String? valor;
  final bool? estado;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Opcion.fromMap(Map<String, dynamic> json) => Opcion(
        id: json["_id"],
        valor: json["valor"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "valor": valor,
        "estado": estado,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "__v": v,
      };
}

class TipoPregunta {
  TipoPregunta({
    this.id,
    this.estado,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.nombre,
  });

  final String? id;
  final bool? estado;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? nombre;

  factory TipoPregunta.fromMap(Map<String, dynamic> json) => TipoPregunta(
        id: json["_id"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        v: json["__v"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "estado": estado,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "__v": v,
        "nombre": nombre,
      };
}
