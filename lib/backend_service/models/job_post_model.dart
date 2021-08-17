class JobPostModel {
  String jobPost, categories, postTime, projectRate;
  List<dynamic> projectQuestion, editingPlatform, editingSoftware;
  var description,
      projectType,
      // projectQuestion,
      freelancerType,
      // editingPlatform,
      // editingSoftware,
      jobState,
      freelancerQuantity,
      talentType,
      englishLevel,
      projectDuration,
      timeRequirement,
      projectPaymentType,
      orderBy,
      uid,
      jobActiveStatus;

  JobPostModel(
      {this.jobPost,
      this.categories,
      this.description,
      this.postTime,
      this.projectType,
      this.projectQuestion,
      this.editingSoftware,
      this.editingPlatform,
      this.freelancerType,
      this.talentType,
      this.freelancerQuantity,
      this.jobState,
      this.englishLevel,
      this.projectRate,
      this.projectDuration,
      this.timeRequirement,
      this.projectPaymentType,
      this.uid,
      this.orderBy,
      this.jobActiveStatus});

  Map toMap(JobPostModel info) {
    var data = Map<String, dynamic>();

    data['categories'] = info.categories;
    data['jobPost'] = info.jobPost;
    data['description'] = info.description;
    data['postTime'] = info.postTime;
    data['projectType'] = info.projectType;
    data['projectQuestion'] = info.projectQuestion;
    data['freelancerType'] = info.freelancerType;
    data['editingSoftware'] = info.editingSoftware;
    data['editingPlatform'] = info.editingPlatform;
    data['talentType'] = info.talentType;
    data['freelancerQuantity'] = info.freelancerQuantity;
    data['jobState'] = info.jobState;
    data['englishLevel'] = info.englishLevel;
    data['projectRate'] = info.projectRate;
    data['projectDuration'] = info.projectDuration;
    data['timeRequirement'] = info.timeRequirement;
    data['projectPaymentType'] = info.projectPaymentType;
    data['orderBy'] = info.orderBy;
    data['jobActiveStatus'] = info.jobActiveStatus;
    return data;
  }

  factory JobPostModel.fromMap(
      [Map<String, dynamic> data, String userJobPostId]) {
    return JobPostModel(
        categories: data['categories'],
        jobPost: data['jobPost'],
        description: data['description'],
        postTime: data['postTime'],
        projectType: data['projectType'],
        projectQuestion: data['projectQuestion'],
        freelancerType: data['freelancerType'],
        editingSoftware: data['editingSoftware'],
        editingPlatform: data['editingPlatform'],
        talentType: data['talentType'],
        freelancerQuantity: data['freelancerQuantity'],
        jobState: data['jobState'],
        englishLevel: data['englishLevel'],
        projectRate: data['projectRate'],
        projectDuration: data['projectDuration'],
        timeRequirement: data['timeRequirement'],
        projectPaymentType: data['projectPaymentType'],
        uid: userJobPostId,
        jobActiveStatus: data['jobActiveStatus']);
  }
}
