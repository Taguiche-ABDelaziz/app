import 'dart:convert';
import 'package:http/http.dart' as http;

class Crud {
  // GET request
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        // ignore: avoid_print
        print("HTTP Error: ${response.statusCode}");
        return {"status": "error", "message": "HTTP Error"};
      }
    } catch (e) {
      // ignore: avoid_print
      print("Catch Error: $e");
      return {"status": "error", "message": e.toString()};
    }
  }

  // POST request
  postRequest(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        // ignore: avoid_print
        print("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      // ignore: avoid_print
      print("Catch Error: $e");
    }
  }
}
