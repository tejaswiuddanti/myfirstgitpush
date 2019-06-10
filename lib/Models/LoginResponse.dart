class LoginResponse
{
    String status;
  String message;
  String uid;


  LoginResponse({this.status,this.message,this.uid});

  factory LoginResponse.fromJson(Map<String,dynamic> json)
  {
    return LoginResponse(
      status: json['status'],message: json['message'],uid: json['uid']
    );
  }
}