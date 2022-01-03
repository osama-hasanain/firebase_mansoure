import 'dart:convert';

import 'package:http/http.dart' as http;

class FirebaseMessaging{

  static void sendMessage({
    required String title,
    required String body,
    required String toId,
  })async{
    final data ={
      "to" : "/topics/$toId",
      "notification":{
        "title":title,
        "body":body,
        "sound":"default"
      },
      "android":{
        "priority":"HIGH",
        "notification":{
          "notification_priority":"PRIORITY_MAX",
          "sound":"default",
          "default_sound":true,
          "default_vibrate_timings":true,
          "default_light_settings":true
        }
      },
      "data" : {
        "type":"order",
        "id":"85",
        "click_action":"FLUTTER_NOTIFICATION_CLICK"
      }
    };
    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=AAAAIG11bbg:APA91bH6m6QKqOLJdh4gv-4DDYSvlleeHmotbFAxR'
          'twKbFRM3u9USiyCxSmpUvReVO-6MJH2u4VG-NRRRLO3Zx5bFWjkBpwYZCPsxiqOb1Okf2W'
          'MsKzKUtMkk3rXHz0nQ26O9dCPVr-_'
    };

    final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers
    );
  }
}