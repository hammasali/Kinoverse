class EducationModel {
  String school, areaOfStudy, degree, startDate, endDate, description;

  EducationModel(
      {this.school,
      this.areaOfStudy,
      this.degree,
      this.startDate,
      this.endDate,
      this.description});

  Map toMap(EducationModel user) {
    var data = Map<String, dynamic>();
    data['school'] = user.school;
    data['areaOfStudy'] = user.areaOfStudy;
    data['degree'] = user.degree;
    data['startDate'] = user.startDate;
    data['endDate'] = user.endDate;
    data['description'] = user.description;

    return data;
  }
}
