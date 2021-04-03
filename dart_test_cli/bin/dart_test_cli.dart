import 'package:dart_test_cli/API.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'dart:io';

void main(List<String> arguments) async {
  final app = Router();

  app.get('/', _defaultRoute);

  app.mount('/api/', Api().router);

  app.all('/<ignored|.*>', (Request request) {
    return Response.notFound('Page not found');
  });

  var server = await io.serve(app , 'localhost', 8083);

  print('Serving at http://${server.address.host}:${server.port}');
}

Future<Response> _defaultRoute(Request request) async {
  String content;
  content = await File('./web/index.html').readAsString();
  print(content);
  return Response.ok(content, headers: {'Content-type': 'text/html'});
}
