class HireModel {
  String profileImage, owner, phoneNumber, vatId, address, timeZone;

  HireModel(
      {this.profileImage,
      this.owner,
      this.phoneNumber,
      this.vatId,
      this.address,
      this.timeZone});

  Map toMap(HireModel user) {
    var data = Map<String, dynamic>();

    data['profileImage'] = user.profileImage;
    data['owner'] = user.owner;
    data['phoneNo'] = user.phoneNumber;
    data['address']= user.address;
    data['timeZone']=user.timeZone;
    data['vatId']=user.vatId;

    return data;
  }


  factory HireModel.fromMap(Map<String, dynamic> data) {
    return HireModel(
      profileImage: data['profileImage'],
      owner: data['owner'],
      phoneNumber: data['phoneNo'],
      address: data['address'],
      timeZone: data['timeZone'],
      vatId: data['vatId'],
    );
  }
}
