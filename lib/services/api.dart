import 'dart:convert';
import 'dart:developer';
import 'dart:io';     
import 'package:http/http.dart' as http; 
import 'package:primeaide/config.dart';



class ApiService {

 
  static Future<dynamic> getConsulted(String info) async{
    log("api.dart:String received:" + info);
     Map<String,String> temp = {
       "args":info
     };
     final response = await http.get('${URLS.BASE_URL}/doc?args=' + Uri.encodeQueryComponent(json.encode(info)));  
   if (response.statusCode == 200) {  
     return response.body;  
   } else {  
     log("Result:" + response.body);
     return "Network Error";  
     
   }  
  }
   
}