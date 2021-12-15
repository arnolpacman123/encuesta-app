import 'package:app/database/db.dart';
import 'package:app/schemas/encuesta_schema.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

import 'package:app/models/encuesta.dart';
import 'package:app/styles/styles.dart' as styles;

class ListaEncuestas extends StatefulWidget {
  final Future<List<Encuesta>?>? future;
  const ListaEncuestas({
    Key? key,
    this.future,
  }) : super(key: key);

  @override
  State<ListaEncuestas> createState() => _ListaEncuestasState();
}

class _ListaEncuestasState extends State<ListaEncuestas> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Encuesta>?>(
      future: widget.future,
      builder: (BuildContext context, AsyncSnapshot<List<Encuesta>?> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              Encuesta? encuesta = snapshot.data![index];
              EncuestaSchema encuestaSchema = EncuestaSchema(
                encuesta: encuestaToMap(encuesta),
              );
              DB.insert(encuestaSchema);
              setState(() {
                
              });
              final GlobalKey<ExpansionTileCardState> card = GlobalKey();
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: ExpansionTileCard(
                  key: card,
                  leading: CircleAvatar(child: Text((index + 1).toString())),
                  title: Text(encuesta.titulo!),
                  subtitle: const Text('¡Ver más!'),
                  children: <Widget>[
                    const Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          encuesta.descripcion!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceAround,
                      buttonHeight: 52.0,
                      buttonMinWidth: 90.0,
                      children: <Widget>[
                        TextButton(
                          style: styles.flatButtonStyle,
                          onPressed: () {
                            card.currentState?.collapse();
                          },
                          child: Column(
                            children: const <Widget>[
                              Icon(Icons.close),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Text('Cerrar'),
                            ],
                          ),
                        ),
                        TextButton(
                          style: styles.flatButtonStyle,
                          onPressed: () {
                            // cardB.currentState?.toggleExpansion();
                          },
                          child: Column(
                            children: const <Widget>[
                              Icon(Icons.add_task_outlined),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Text('Realizar encuesta'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 300.0,
                    child: Center(
                      child: Text(
                        'Cargando encuestas',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: SizedBox(
                    height: 60.0,
                    width: 60.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 6.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
