class UserModel {
  String? uId;
  String? name;
  String? email;
  String? phoneNumber;
  String? homeAddress;
  String? businessAddress;
  String? profileImage;
 

  UserModel({
    this.uId,
    this.name,
    this.phoneNumber,
    this.email,
    this.homeAddress,
    this.businessAddress,
    this.profileImage
});
  UserModel.fromJson(Map<String, dynamic> json){
    uId = json['uId'];
    name = json['name'];
    email = json['email'];
    phoneNumber=json['phoneNumber'];
    homeAddress = json['homeAddress'];
    businessAddress = json['businessAddress'];
    profileImage= json['profileImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId':uId,
      'name':name,
      'email':email,
      'phoneNumber': phoneNumber,
      'homeAddress':homeAddress,
      'businessAddress': businessAddress,
      'profileImage': profileImage,
    };
  }
}