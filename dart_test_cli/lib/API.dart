import 'dart:typed_data';

import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'dart:io';

class Api {
  Router get router {
    final router = Router();

    // return json object
    router.get('/json', handleJson);

    //Return an archieved file
    router.get('/archieve', handleArchieve);

    router.all('/<ignored|.*>', (Request request) => Response.notFound('null'));

    return router;
  }

  Future<Response> handleJson(Request request) async {
    String json;

    try {
      var myUri = Uri.parse('./assets/sample_data.json');
      var jsonFile = File.fromUri(myUri);
      await jsonFile.readAsString().then((value) {
        json = value;
        print('reading of json bytes is completed');
      }).catchError((onError) {
        print('Exception Error while reading json from path:' +
            onError.toString());
      });
    } catch (e) {
      print(e);
      return Response.internalServerError(body: 'Canot find json data');
    }

    print(json);
    return Response.ok(json, headers: {'Content-type': 'application/json'});
  }

  Future<Response> handleArchieve(Request request) async {
    Uint8List bytes;

    try {
      var myUri = Uri.parse('./assets/compressed_code.tar.xz');
      var jsonFile = File.fromUri(myUri);
      await jsonFile.readAsBytes().then((value) {
        bytes = Uint8List.fromList(value); 
        print('reading of archieved bytes is completed');
      }).catchError((onError) {
        print('Exception Error while reading archieved from path:' +
            onError.toString());
      });
    } catch (e) {
      print(e);
      return Response.internalServerError(body: 'Canot find json data');
    }

    print(bytes);
    return Response.ok(bytes, headers: {'Content-type': 'application/zip'});
  }

}
