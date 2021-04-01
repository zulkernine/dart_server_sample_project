import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'dart:io';

void main(List<String> arguments) async {
  var handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addHandler(_echoRequest);

  var server = await io.serve(handler, 'localhost', 8083);

  // Enable content compression
  server.autoCompress = true;

  // var contents = await File('index.html').readAsString();
  // print(contents);

  print('Serving at http://${server.address.host}:${server.port}');
}

Future<shelf.Response> _echoRequest(shelf.Request request) async {
  String content;
  content = await File('index.html').readAsString();
  print(content);
  return shelf.Response.ok(content, headers: {'Content-type': 'text/html'});
}
