import 'dart:convert';
import 'dart:developer';     
import 'package:http/http.dart' as http; 
import 'package:flutter_login_demo/config.dart';



class ApiService {

 
  static Future<dynamic> getConsulted(String info) async{
    log("api.dart:String received:" + info);
     Map<String,String> temp = {
       "args":info
     };
      String query = '${URLS.BASE_URL}/doc?args=' + Uri.encodeQueryComponent(info);
      log(query);
     final response = await http.post('${URLS.BASE_URL}/doc?' + Uri.encodeQueryComponent(json.encode(temp)));  
   if (response.statusCode == 200) {  
     return json.decode(response.body);  
   } else {  
     return "Network Error";  
   }  
  }
   
}