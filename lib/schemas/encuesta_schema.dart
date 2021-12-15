class EncuestaSchema {
  int? id;
  String? encuesta;
  EncuestaSchema({this.id, this.encuesta});

  factory EncuestaSchema.fromMap(Map<String, dynamic> json) => EncuestaSchema(
    id: json["id"],
    encuesta: json["encuesta"],
  );

  Map<String, dynamic> toMap() => {
        "id": id,
        "encuesta": encuesta,
      };
}
