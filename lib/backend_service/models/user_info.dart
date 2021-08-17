class UserInfoModel {
  String uid,
      name,
      email,
      userName,
      status,
      profilePhoto,
      country,
      profileState,
      createdAt;
  bool signUpCheckForEmail;
  Map companyContacts;


  UserInfoModel(
      {this.uid,
      this.name,
      this.email,
      this.userName,
      this.status,
      this.profilePhoto,
      this.country,
      this.profileState,
      this.signUpCheckForEmail,
      this.companyContacts,
      this.createdAt});

  Map toMap(UserInfoModel user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['userName'] = user.userName;
    data['status'] = user.status;
    data['profilePhoto'] = user.profilePhoto;
    data['country'] = user.country;
    data['profileState'] = user.profileState;
    data['signUpCheckForEmails'] = user.signUpCheckForEmail;
    data['companyContacts'] = user.companyContacts;
    data['createdAt']= user.createdAt;
    return data;
  }

  factory UserInfoModel.fromMap(Map<String, dynamic> data) {
    return UserInfoModel(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      userName: data['userName'],
      status: data['status'],
      profilePhoto: data['profilePhoto'],
      country: data['country'],
      profileState: data['profileState'],
      signUpCheckForEmail: data['signUpCheckForEmails'],
      companyContacts: data['companyContacts'],
      createdAt:  data['createdAt'],
    );
  }
}
