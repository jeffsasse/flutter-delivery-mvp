import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tobbund/repository/UserRepository.dart';
import 'connectivity_provider.dart';
import 'dart:convert';
import 'dart:async';

const base_url = "http://176.235.91.74:6245";
//const base_url = "http://192.168.21.150:6245";
//const base_url = "http://testmobil.ncts.com.tr:6245";


//api helper
class ApiHelper {
  //get method
  Future<Map> doGetRequest(String endPoint) async {
    await ConnectivityProvider().connectionListen();
    String url = "http://176.235.91.74:6245";
    //String url = "http://192.168.21.150:6245";
//    String url = "http://testmobil.ncts.com.tr:6245";
    print(url);
    var response = await http.get(url);
    return json.decode(response.body);
  }

  //post method
  Future<Map> doBodyPostRequest(String endPoint, Map params) async {
    await ConnectivityProvider().connectionListen();
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    String body = json.encode(params);
    String url;
    url = "$base_url/$endPoint";
    print(url);
    print(body);
    try {
      HttpClientRequest request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      if (UserRepository().user?.token != null)
        request.headers
            .set('Authorization', 'Bearer ${UserRepository().user.token}');

      if (body != "null") {
        request.add(utf8.encode(body));
      }
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();
      return json.decode(reply);
    } catch (e) {
      print(e.toString());
      return {"status": "failed"};
    }
  }

  Future<List> doListPostRequest(String endPoint, Map params) async {
    await ConnectivityProvider().connectionListen();
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    String body = json.encode(params);
    String url;
    url = "$base_url/$endPoint";
    print(url);
    print(body);

    try {
      HttpClientRequest request = await client.postUrl(Uri.parse(url));

      request.headers.set('content-type', 'application/json');

      if (UserRepository().user?.token != null)
        request.headers
            .set('Authorization', 'Bearer ${UserRepository().user.token}');

      if (body != "null") {
        request.add(utf8.encode(body));
      }
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();
      print(reply);

      return json.decode(reply);
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}

//import 'package:http/http.dart' as http;
//import 'dart:convert';
//import 'dart:async';
//
////api helper
//class ApiHelper {
//
//  //get method
//  Future<Map> doGetRequest(String endPoint) async {
//    String url = "https://192.168.21.211:5010/";
//    print(url);
//    var response = await http.get(url);
//    return json.decode(response.body);
//  }
//
//  //post method
//  Future<Map> doBodyPostRequest(String endPoint, Map params) async {
//    String body = json.encode(params);
//    String url;
//    url = "https://192.168.21.211:5010/$endPoint";
//    print(url);
//    print(body);
//    try{
//      var response = await http.post(url,
//        headers: {
//          "Content-Type": "application/json"
//        },
//        body: body,
//      );
//      return json.decode(response.body);
//
//    }catch(e){
//      return {
//        "status":"failed"
//      };
//    }
//  }
//}
//
