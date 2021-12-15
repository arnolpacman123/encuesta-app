import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:app/models/encuesta.dart';

class EncuestaService {
  static const String urlNoRelacional =
      'https://sistema-de-encuestas-api.herokuapp.com/encuesta';
  static final Logger logger = Logger();

  static Future<List<Encuesta>?> obtenerEncuestas() async {
    const url = urlNoRelacional;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final encuestas = encuestasFromMap(response.body);
      return encuestas;
    }
    return null;
  }
}
