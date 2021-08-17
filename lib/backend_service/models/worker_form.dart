class WorkerFormModel {
  var expert,
      englishProficiency,
      categories,
      skills,
      education,
      employment,
      otherLanguages,
      hourlyRate,
      professionalOverview,
      title,
      companyData,
      phoneNo,
      uid,
      orderBy;

  WorkerFormModel(
      {this.categories,
      this.skills,
      this.expert,
      this.phoneNo,
      this.professionalOverview,
      this.title,
      this.hourlyRate,
      this.otherLanguages,
      this.englishProficiency,
      this.employment,
      this.education,
      this.companyData,
      this.uid,
      this.orderBy});

  Map toMap(WorkerFormModel user) {
    var data = Map<String, dynamic>();

    data['categories'] = user.categories;
    data['skills'] = user.skills;
    data['expert'] = user.expert;
    data['education'] = user.education;
    data['employment'] = user.employment;
    data['englishProficiency'] = user.englishProficiency;
    data['otherLanguages'] = user.otherLanguages;
    data['professionalOverview'] = user.professionalOverview;
    data['title'] = user.title;
    data['companyData'] = user.companyData;
    data['phoneNo'] = user.phoneNo;
    data['hourlyRate'] = user.hourlyRate;
    data['uid'] = user.uid;
    data['orderBy'] = user.orderBy;

    return data;
  }

  factory WorkerFormModel.fromMap(Map<String, dynamic> data) {

    return WorkerFormModel(
      categories: data['categories'],
      skills: data['skills'],
      expert: data['expert'],
      education: data['education'],
      employment: data['employment'],
      englishProficiency: data['englishProficiency'],
      otherLanguages: data['otherLanguages'],
      professionalOverview: data['professionalOverview'],
      title: data['title'],
      companyData: data['companyData'],
      phoneNo: data['phoneNo'],
      hourlyRate: data['hourlyRate'],
      uid: data['uid'],
      orderBy: data['orderBy'],
    );
  }
}
