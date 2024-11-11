class UserModel{
  final String email,uid;

  UserModel({required this.email,required this.uid});

  factory UserModel.fromJson(Map <String,dynamic>json){
    return UserModel(email: json["email"], uid:json["uid"]);
  }
  Map<String,dynamic> toJson(){
    return {
      "email":email,
      "uid":uid
    };
  }

}