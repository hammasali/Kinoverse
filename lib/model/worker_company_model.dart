class WorkerCompanyModel {
  String country, streetAddress, city, postalCode;

  WorkerCompanyModel(
      {this.country, this.streetAddress, this.city, this.postalCode});

  Map toMap(WorkerCompanyModel user) {
    var data = Map<String, dynamic>();
    data['city'] = user.city;
    data['country'] = user.country;
    data['streetAddress'] = user.streetAddress;
    data['postalCode'] = user.postalCode;

    return data;
  }
}
