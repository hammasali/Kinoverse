import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:kinoverse/backend_service/models/job_post_model.dart';
import 'package:kinoverse/backend_service/repo/firebase_repo.dart';

part 'job_event.dart';

part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  var jobPost,
      categories,
      description,
      projectType,
      projectQuestion,
      freelancerType,
      editingPlatform,
      editingSoftware,
      jobState,
      freelancerQuantity,
      talentType,
      englishLevel,
      projectDuration,
      projectRate,
      timeRequirement,
      projectPaymentType;

  JobPostModel jobPostModel;

  JobBloc() : super(JobInitial());

  @override
  Stream<JobState> mapEventToState(
    JobEvent event,
  ) async* {
    // TODO: implement mapEventToState

    try {
      //==============================  JobScreen1Event ========================
      if (event is JobScreen1Event) {
        jobPost = event.jobPost;
        categories = event.categories;
        print('$jobPost $categories');
        yield JobSuccessfulState(_updateModel());
      }

      //==============================  JobScreenEvent2 ========================

      else if (event is JobScreenEvent2) {
        description = event.description;
        yield JobSuccessfulState(_updateModel());
      }
      //==============================  JobScreenEvent3 ========================

      else if (event is JobScreenEvent3) {
        projectType = event.projectType;
        projectQuestion = event.projectQuestion;
        yield JobSuccessfulState(_updateModel());
      }

      //==============================  JobScreenEvent4 ========================

      else if (event is JobScreenEvent4) {
        freelancerType = event.freelancerType;
        editingPlatform = event.editingPlatform;
        editingSoftware = event.editingSoftware;
        yield JobSuccessfulState(_updateModel());
      }

      //==============================  JobScreenEvent5 ========================

      else if (event is JobScreenEvent5) {
        jobState = event.jobState;
        freelancerQuantity = event.freelancerQuantity;
        talentType = event.talentType;
        yield JobSuccessfulState(_updateModel());
      }

      //==============================  JobScreenEvent 6 ========================

      else if (event is JobScreenEvent6) {
        projectDuration = event.projectDuration;
        projectRate = event.projectRate;
        projectPaymentType = event.projectPaymentType;
        yield JobSuccessfulState(_updateModel());
      }

      //==============================  JobScreenEvent 7 ========================

      else if (event is PreviewPostJob) {
        englishLevel = event.englishLevel;
        timeRequirement = event.timeRequirement;
        yield JobSuccessfulState(_updateModel());
      }
      //==============================  Submit =================================
      else if (event is SubmitEvent) {
        yield JobLoadingState();
        _postJob();
      }
    } on FirebaseException catch (e) {
      yield JobUnSuccessfulState(e.message);
    } catch (e) {
      if (e == 'JobScreenEvent3')
        yield JobUnSuccessfulState('Please Select Project type');
      else if (e == 'JobScreenEvent4')
        yield JobUnSuccessfulState('Please Select freelancer type');
    }
  }

  Map _updateModel() {
    ///Dummy Data
    // jobPostModel = JobPostModel(
    //     jobPost: 'Web design',
    //     categories: 'Editor',
    //     description:
    //         'The Production House needs multiple Scriptwriters for multiple titles.',
    //     projectDuration: 'More than 6 Months',
    //     projectQuestion:
    //         'Do you have suggestions to make this project run successfully?',
    //     editingPlatform: 'Post-Editing',
    //     editingSoftware: 'After Affect',
    //     freelancerType: 'Expert',
    //     jobState: 'Only Kinoverse users can find this job',
    //     talentType: 'Freelancer',
    //     projectRate: '300-400',
    //     timeRequirement: "Less than 30 hours a week",
    //     projectPaymentType: "Hourly Rate");

    jobPostModel = JobPostModel(
        jobPost: this.jobPost,
        categories: this.categories,
        description: this.description,
        projectDuration: this.projectDuration,
        projectQuestion: this.projectQuestion,
        editingPlatform: this.editingPlatform,
        editingSoftware: this.editingSoftware,
        freelancerType: this.freelancerType,
        jobState: this.jobState,
        talentType: this.talentType,
        projectRate: this.projectRate,
        timeRequirement: this.timeRequirement,
        projectPaymentType: this.projectPaymentType);

    var data = jobPostModel.toMap(jobPostModel);
    return data;
  }

  _postJob() async {
    String _dateTime =
        DateFormat('EEE, MMM d, ' 'yyyy h:mm a').format(DateTime.now());
    var orderBy = DateTime.now().millisecondsSinceEpoch.toString();

    jobPostModel = JobPostModel(
        categories: this.categories,
        jobPost: this.jobPost,
        postTime: _dateTime,
        projectType: this.projectType,
        projectQuestion: this.projectQuestion,
        editingPlatform: this.editingPlatform,
        editingSoftware: this.editingSoftware,
        freelancerType: this.freelancerType,
        talentType: this.talentType,
        projectDuration: this.projectDuration,
        projectRate: this.projectRate,
        jobState: this.jobState,
        englishLevel: this.englishLevel,
        freelancerQuantity: this.freelancerQuantity,
        timeRequirement: this.timeRequirement,
        description: this.description,
        projectPaymentType: this.projectPaymentType,
        jobActiveStatus: true,
        orderBy: orderBy,
        uid: '');

    await FirebaseRepo.instance
        .previewJobPostData(jobPostModel.toMap(jobPostModel))
        .whenComplete(() => emit(JobSuccessfulState()));
  }
}
