class userModel {
  String? uid;
  String? fullname;
  String? email;
  String? profilepic;
  userModel({this.uid, this.email, this.fullname, this.profilepic});

  userModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["fullname"];
    email = map["email"];
    profilepic = map["profilepic"];
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullname": fullname,
      "email": email,
      "profilepic": profilepic
    };
  }
}
