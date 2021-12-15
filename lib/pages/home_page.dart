// import 'package:app/widgets/lista_encuestas.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app/pages/encuesta_page.dart';
import 'package:app/schemas/encuesta_schema.dart';
import 'package:app/database/db.dart';
import 'package:app/provider/connection_status_model.dart';
import 'package:app/models/encuesta.dart';
import 'package:app/services/encuesta_service.dart';
import 'package:app/styles/styles.dart' as styles;

class HomePage extends StatefulWidget {
  static const String routeName = 'home-page';
  final List<Encuesta>? encuestas;
  const HomePage({
    Key? key,
    this.encuestas,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  bool encuestasSaved = false;

  Future<void> updateState() async {
    int cantidadEncuestas = await DB.countEncuestas();
    setState(() {
      encuestasSaved = cantidadEncuestas > 0;
    });
  }

  @override
  void initState() {
    super.initState();
    updateState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Lista de encuestas')),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ConnectionStatusModel(),
        child: Consumer<ConnectionStatusModel>(
          builder: (_, model, __) {
            return model.isOnline
                ? encuestasSaved
                    ? listaEncuestas(
                        future: DB.obtenerEncuestas(),
                        bandera: false,
                      )
                    : listaEncuestas(
                        future: EncuestaService.obtenerEncuestas(),
                        bandera: true,
                      )
                : encuestasSaved
                    ? listaEncuestas(
                        future: DB.obtenerEncuestas(),
                        bandera: false,
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Text('NO HAY ACCESO A INTERNET'),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Debe conectarse a internet y cargar las encuestas al menos una vez',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
          },
        ),
      ),
    );
  }

  Widget listaEncuestas({
    Future<List<Encuesta>?>? future,
    required bool bandera,
  }) {
    return FutureBuilder<List<Encuesta>?>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List<Encuesta>?> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              Encuesta? encuesta = snapshot.data![index];
              if (bandera) {
                EncuestaSchema encuestaSchema = EncuestaSchema(
                  encuesta: encuestaToMap(encuesta),
                );
                DB.insert(encuestaSchema);
                updateState();
              }

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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => EncuestaPage(
                                  encuesta: encuesta,
                                ),
                              ),
                            );
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
