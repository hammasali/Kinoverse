class TalentHireFavModel {
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
      name,
      country,
      orderBy;

  TalentHireFavModel(
      {this.expert,
      this.englishProficiency,
      this.categories,
      this.skills,
      this.education,
      this.employment,
      this.otherLanguages,
      this.hourlyRate,
      this.professionalOverview,
      this.title,
      this.companyData,
      this.phoneNo,
      this.uid,
      this.name,
      this.country,
      this.orderBy,});

  Map toMap(TalentHireFavModel user) {
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
    data['name'] = user.name;
    data['country'] = user.country;
    data['orderBy'] = user.orderBy;

    return data;
  }

  factory TalentHireFavModel.fromMap(Map<String, dynamic> data) {
    return TalentHireFavModel(
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
      name: data['name'],
      country: data['country'],
      orderBy: data['orderBy'],
    );
  }

  factory TalentHireFavModel.fromMapFavourites(Map<String, dynamic> data) {
    return TalentHireFavModel(
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
      name: data['name'],
      country: data['country'],
      orderBy: data['orderBy'],
    );
  }
}
