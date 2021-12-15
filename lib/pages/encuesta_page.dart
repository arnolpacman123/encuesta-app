import 'package:flutter/material.dart';
import 'package:app/models/encuesta.dart';

class EncuestaPage extends StatefulWidget {
  static const String routeName = 'encuesta-page';
  final Encuesta? encuesta;
  const EncuestaPage({
    Key? key,
    this.encuesta,
  }) : super(key: key);

  @override
  _EncuestaPageState createState() => _EncuestaPageState();
}

class _EncuestaPageState extends State<EncuestaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.encuesta!.titulo!,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.encuesta!.secciones!.length,
        itemBuilder: (BuildContext context, int index) {
          Seccion? seccion = widget.encuesta!.secciones![index];
          return Column(
            children: [
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Card(
                  margin:
                      const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            seccion!.titulo!,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            seccion.preguntas!.length,
                            (index) {
                              final pregunta = seccion.preguntas![index];
                              String valor = pregunta.opciones![0]!.valor!;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${index + 1}. ${pregunta.enunciado}',
                                          textAlign: TextAlign.justify,
                                          style:
                                              const TextStyle(fontSize: 16.0),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(
                                            pregunta.opciones!.length,
                                            (index) {
                                              final opcion =
                                                  pregunta.opciones![index];
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  ListTile(
                                                    title: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 12.0,
                                                      ),
                                                      child:
                                                          Text(opcion!.valor!),
                                                    ),
                                                    leading: Radio<String>(
                                                      value: pregunta
                                                          .opciones![index]!
                                                          .valor!,
                                                      groupValue: valor,
                                                      onChanged: (value) {
                                                        setState(
                                                          () {
                                                            pregunta
                                                                .opciones![
                                                                    index]!
                                                                .valor = value!;
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
            ],
          );
        },
      ),
    );
  }
}
