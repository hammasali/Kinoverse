import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kinoverse/backend_service/models/worker_form.dart';
import 'package:kinoverse/backend_service/repo/firebase_repo.dart';


part 'fields_event.dart';

part 'fields_state.dart';

class FieldsBloc extends Bloc<FieldsEvent, FieldsState> {
  dynamic expert,
      englishProficiency,
      education,
      employment,
      otherLanguages,
      hourlyRate,
      professionalOverview,
      title,
      companyData,
      phoneNo,
      categories,
      skills;

  WorkerFormModel workerFormModel;

  FieldsBloc([
    this.expert = '',
    this.englishProficiency = '',
    this.education = '',
    this.employment = '',
    this.otherLanguages = '',
    this.hourlyRate = '',
    this.professionalOverview = '',
    this.title = '',
    this.companyData = '',
    this.phoneNo = '',
    this.categories = '',
    this.skills = '',
  ]) : super(FieldsInitial());

  @override
  Stream<FieldsState> mapEventToState(
    FieldsEvent event,
  ) async* {
    try {
      //=====================SignUpScreen3===========================
      if (event is NextButtonEventScreen3) {
        if (event.categories.isNotEmpty) {
          yield FieldLoadingState();
          categories = event.categories;

          yield FieldSuccessfulState();
        } else
          throw ('Please choose at least 1 category');
      }
      //=====================SignUpScreen4===========================
      else if (event is NextButtonEventScreen4) {
        if (event.skills.isNotEmpty) {
          yield FieldLoadingState();
          skills = event.skills;

          yield FieldSuccessfulState(_updateModel());
        } else
          throw ('Please provide at least 1 skill');
      }
      //=====================SignUpScreen5===========================
      else if (event is NextButtonEventScreen5) {
        expert = event.expert;

        yield FieldSuccessfulState();
      }
      //=====================SignUpScreen6===========================
      else if (event is NextButtonEventScreen6) {
        // ignore: null_aware_in_condition
        if (event.userMapData.isNotEmpty) {
          yield FieldLoadingState();
          education = event.userMapData;

          yield FieldSuccessfulState(_updateModel());
        }
        else
        throw ('Please provide your education details');
      }
      //=====================SignUpScreen7===========================
      else if (event is NextButtonEventScreen7) {
        // ignore: null_aware_in_condition
        if (event?.userEmploymentMapData?.isNotEmpty) {
          yield FieldLoadingState();
          employment = event.userEmploymentMapData;

          yield FieldSuccessfulState(_updateModel());
        }
        else
        throw ('Please add your past experience');
      }
      //=====================SignUpScreen8===========================
      else if (event is NextButtonEventScreen8) {
        if (event.englishProficiency != null) {
          yield FieldLoadingState();
          englishProficiency = event.englishProficiency;
          otherLanguages = event.otherLanguages;

          yield FieldSuccessfulState(_updateModel());
        }
        else
        throw ('Please select your english proficiency');
      }
      //=====================SignUpScreen9===========================
      else if (event is NextButtonEventScreen9) {
        hourlyRate = event.hourlyRate;
        print(hourlyRate);

        yield FieldSuccessfulState(_updateModel());
      }
      //=====================SignUpScreen10===========================
      else if (event is NextButtonEventScreen10) {
        title = event.title;
        professionalOverview = event.professionalOverview;

        yield FieldSuccessfulState();
      }
      //=====================SignUpScreen11===========================
      // else if (event is NextButtonEventScreen11) {
      //   yield FieldLoadingState();
      //   await FirebaseRepo.instance
      //       .uploadProfileWithMetadata(filePath: event.file)
      //       .whenComplete(() => emit(FieldSuccessfulState()));
      // }
      //=====================SignUpScreen12===========================
      else if (event is NextButtonEventScreen12) {
        companyData = event.userData;

        yield FieldSuccessfulState();
      }
      //=====================Preview Profile===========================
      else if (event is NextButtonEventScreen13) {
        phoneNo = event.phoneNo;

        yield FieldSuccessfulState(_updateModel());
      }
      //=====================Submit SignUpScreen14===========================
      else if (event is SubmitButtonEventScreen14) {
        yield FieldLoadingState();
        await postFieldData();
      }

      //=====================SignUpScreenExtension14===========================

      else if (event is SaveButtonEventScreen14) {
        FirebaseRepo.instance
            .addNameAndCountryDataInDB(event.name, event.country);
        yield FieldSuccessfulState(_updateModel());
      }

      //=====================SubmitButtonHireEvent===========================
      else if (event is SubmitButtonHireEvent) {
        yield FieldLoadingState();
        FirebaseRepo.instance.uploadProfileWithMetadata(
            filePath: event?.file, hireData: event?.hireModel);
        yield FieldSuccessfulState();
      }
    } on FirebaseException catch (e) {
      yield FieldUnsuccessfulState(message: e.message);
    } catch (e) {
      yield FieldUnsuccessfulState(message: e.toString());
    }
  }

  Map _updateModel() {
    workerFormModel = WorkerFormModel(
        categories: this.categories??'',
        skills: this.skills,
        hourlyRate: this.hourlyRate,
        title: this.title,
        phoneNo: this.phoneNo,
        companyData: this.companyData,
        professionalOverview: this.professionalOverview,
        otherLanguages: this.otherLanguages,
        englishProficiency: this.englishProficiency,
        employment: this.employment,
        education: this.education,
        expert: this.expert);
    var data = workerFormModel.toMap(workerFormModel);
    return data;
  }

  Future<void> postFieldData() async {
    var orderBy = DateTime.now().millisecondsSinceEpoch.toString();
    workerFormModel = WorkerFormModel(
        categories: this.categories,
        skills: this.skills,
        hourlyRate: this.hourlyRate,
        title: this.title,
        phoneNo: this.phoneNo,
        companyData: this.companyData,
        professionalOverview: this.professionalOverview,
        otherLanguages: this.otherLanguages,
        englishProficiency: this.englishProficiency,
        employment: this.employment,
        education: this.education,
        expert: this.expert,
        uid: FirebaseRepo.instance.getCurrentUser().uid,
        orderBy: orderBy);

    var data = workerFormModel.toMap(workerFormModel);

    await FirebaseRepo.instance
        .submitWorkerFieldsData(data)
        .whenComplete(() => emit(FieldSuccessfulState()));
  }
}
