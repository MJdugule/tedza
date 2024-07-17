import 'dart:convert';

class ApiException implements Exception{
   String message = "";

  ApiException.fromResponse(int? statusCode, dynamic error){
    error = jsonDecode(error.body);
    getType() {
      if (error['message'].runtimeType == List<dynamic>) {
        return error['message'][0];
      } else {
        return error['message'];
      }
    }
    

    if (statusCode != 200 ) {
      if (statusCode != 201){ 
       switch (statusCode) {
      case 400:
        message = getType();
        break;
      case 401:
         message = getType();
         break;
      case 403:
         message = getType();
         break;
      case 404:
         message = getType();
         break;
      case 500:
      // print(error['message']);
         message = getType();
         break;
      case 422:
         message = getType();
         break;
      case 502:
         message = 'Bad gateway';
         break;
      default:
         message = 'Oops something went wrong';
         break;
    }
    }else{
      message = "null";
    }
    }else{
      message = "null";
    }
   
  }
  
  ApiException.fromMultipartResponse(int? statusCode, dynamic error){
    error = jsonDecode(error) ;
    

    if (statusCode != 200 ) {
      if (statusCode != 201){ 
       switch (statusCode) {
      case 400:
        message = error['message'];
        break;
      case 401:
         message = error['message'];
         break;
      case 403:
         message = error['message'];
         break;
      case 404:
         message = error['message'];
         break;
      case 500:
      // print(error['message']);
         message = 'Oops something went wrong';
         break;
      case 422:
         message = error['message'];
         break;
      case 502:
         message = 'Bad gateway';
         break;
      default:
         message = 'Oops something went wrong';
         break;
    }
    }else{
      message = "null";
    }
    }else{
      message = "null";
    }
   
  }

  @override
  String toString() => message;
}