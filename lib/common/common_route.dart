import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kinoverse/Page/worker/getting_started_page/getting_started_page1.dart';
import 'package:kinoverse/Page/worker/getting_started_page/getting_started_page2.dart';
import 'package:kinoverse/Page/worker/sign_up/sign_up.dart';
import 'package:kinoverse/Page/worker/sign_up/sign_up_2.dart';
import 'package:kinoverse/page/hire/chat_page/chat_page.dart';
import 'package:kinoverse/page/hire/home_page/home_page.dart';
import 'package:kinoverse/page/hire/payment/contract_page.dart';
import 'package:kinoverse/page/hire/payment/paynow_page.dart';
import 'package:kinoverse/page/hire/post_job/post_job_1.dart';
import 'package:kinoverse/page/hire/post_job/post_job_2.dart';
import 'package:kinoverse/page/hire/post_job/post_job_3.dart';
import 'package:kinoverse/page/hire/post_job/post_job_4.dart';
import 'package:kinoverse/page/hire/post_job/post_job_5.dart';
import 'package:kinoverse/page/hire/post_job/post_job_6.dart';
import 'package:kinoverse/page/hire/post_job/post_job_7.dart';
import 'package:kinoverse/page/hire/post_job/preview_job_1.dart';
import 'package:kinoverse/page/hire/post_job/preview_job_2.dart';
import 'package:kinoverse/page/hire/signup_pgae/signup_page.dart';
import 'package:kinoverse/page/worker/category_page/category_page.dart';
import 'package:kinoverse/page/worker/chat_page/chat_page.dart';
import 'package:kinoverse/page/worker/education/education_page.dart';
import 'package:kinoverse/page/worker/employment/employment_page.dart';
import 'package:kinoverse/page/worker/expertise_page/expertise_level_page.dart';
import 'package:kinoverse/page/worker/expertise_page/expertise_page.dart';
import 'package:kinoverse/page/worker/home_page/home_page.dart';
import 'package:kinoverse/page/worker/hourly_rate/hourly_rate_page.dart';
import 'package:kinoverse/page/worker/language/language_page.dart';
import 'package:kinoverse/page/worker/location/location_page.dart';
import 'package:kinoverse/page/worker/login_page/login.dart';
import 'package:kinoverse/page/worker/my_jobs/get_paid_page.dart';
import 'package:kinoverse/page/worker/my_jobs/my_jobs.dart';
import 'package:kinoverse/page/worker/my_jobs/submit_work_page.dart';
import 'package:kinoverse/page/worker/phone/phone_page.dart';
import 'package:kinoverse/page/worker/profile_overview/profile_overview_page.dart';
import 'package:kinoverse/page/worker/profile_photo/profile_photo_page.dart';
import 'package:kinoverse/page/worker/title_overview/title_overview_page.dart';

class CommonRoutePage {
  navigatorPop(BuildContext context) {
    Navigator.pop(context);
  }

  ///Worker Route
  //CONVERTED
  gotoSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUp(),
      ),
    );
  }

  //CONVERTED
  gotoSignUp2(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUp2(),
      ),
    );
  }

  //CONVERTED
  gotoLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Login(),
      ),
    );
  }

  //CONVERTED
  gotoGettingStartedPage1(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GettingStartedPage1(),
      ),
    );
  }

  //CONVERTED
  gotoGettingStartedPage2(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GettingStartedPage2(),
      ),
    );
  }

  //CONVERTED
  gotoCategoryPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryPage()),
    );
  }

  //CONVERTED
  gotoExpertisePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExpertisePage()),
    );
  }

  //CONVERTED
  gotoExpertiseLevelPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExpertiseLevelPage()),
    );
  }

  //CONVERTED
  gotoEducationPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EducationPage()),
    );
  }

  //CONVERTED
  gotoEmploymentPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmploymentPage()),
    );
  }

  //CONVERTED
  gotoLanguagePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LanguagePage()),
    );
  }

  //CONVERTED
  gotoHourlyRate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HourlyRatePage()),
    );
  }

  //CONVERTED
  gotoTitleOverviewPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TitleOverviewPage()),
    );
  }

  //CONVERTED
  gotoProfilePhotoPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePhotoPage()),
    );
  }

  //CONVERTED
  gotoLocationPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationPage()),
    );
  }

  //CONVERTED
  gotoPhonePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PhonePage()),
    );
  }

  //CONVERTED
  gotoProfileOverviewPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileOverviewPage()),
    );
  }

  //CONVERTED
  gotoHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  gotoMyJobs(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyJobs()),
    );
  }

  gotoChatPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatPage()),
    );
  }

  //CONVERTED
  gotoGetPaidPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GetPaidPage()),
    );
  }

  //CONVERTED
  gotoSubmitWorkPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SubmitWorkPage()),
    );
  }

  //CONVERTED
  gotoHireSignupPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HireSignupPage()),
    );
  }

  //Converted
  gotoHireHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HireHomePage()),
    );
  }

  gotoHireChatPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HireChatPage()),
    );
  }

  gotoHirePaymentPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContractPage()),
    );
  }

  gotoHirePayNowPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HirePayNow()),
    );
  }

  //CONVERTED
  gotoPostJobPage1(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostJobPage1()),
    );
  }

  //CONVERTED
  gotoPostJobPage2(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostJobPage2()),
    );
  }

  //CONVERTED
  gotoPostJobPage3(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostJobPage3()),
    );
  }

  //CONVERTED
  gotoPostJobPage4(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostJobPage4()),
    );
  }

  //CONVERTED
  gotoPostJobPage5(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostJobPage5()),
    );
  }

  //CONVERTED
  gotoPostJobPage6(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostJobPage6()),
    );
  }

  //CONVERTED
  gotoPostJobPage7(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostJobPage7()),
    );
  }

  //CONVERTED
  gotoPreviewJobPage1(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PreviewJobPage1()),
    );
  }

  //CONVERTED
  gotoPreviewJobPage2(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PreviewJobPage2()),
    );
  }

  static goToScreen(BuildContext context, screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}
