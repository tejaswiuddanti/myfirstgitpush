class CommonResponse{
  String status;
  String message;
  CommonResponse({this.status,this.message});
  factory CommonResponse.fromJson(Map<String,dynamic>json){
    return CommonResponse(status: json['status']
    ,message: json['message']);
  }
}