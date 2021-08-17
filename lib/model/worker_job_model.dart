class WorkerJobModel {
  String company, city, country, title, start, end, description;
  bool currentlyWorking;

  WorkerJobModel(
      {this.company,
      this.city,
      this.country,
      this.title,
      this.start,
      this.end,
      this.description,
      this.currentlyWorking});

  Map toMap(WorkerJobModel user) {
    var data = Map<String, dynamic>();
    data['company'] = user.company;
    data['city'] = user.city;
    data['country'] = user.country;
    data['title'] = user.title;
    data['start'] = user.start;
    data['end'] = user.end;
    data['description'] = user.description;
    data['currentlyWorking'] = user.currentlyWorking;

    return data;
  }
}
