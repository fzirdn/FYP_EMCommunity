class UserModel {

  String? uid;
  String? email;
  String? phoneNum;
  String? password;
  String? confirmPassword;

  UserModel({this.uid, this.email, this.phoneNum});

  // receiving data from server
  factory UserModel.froMap(map)
  {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      phoneNum: map['phoneNum'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email' : email,
      'phoneNum' : phoneNum,

    };
  }

}