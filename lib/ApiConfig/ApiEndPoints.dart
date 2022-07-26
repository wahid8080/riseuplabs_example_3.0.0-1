
class ApiEndPoints{

  final String baseUrl = "https://api.mail.tm/";

  final String domain = 'domains';
  final String createAccount = 'accounts';
  final String getToken = 'token';

}


String nullConverter(dynamic data){
  if(data!=null){
    return data.toString();
  }else{
    return "-";
  }
}
