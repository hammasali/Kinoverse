import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/business_logic/bloc/chat_bloc/chat_bloc.dart';
import 'package:kinoverse/business_logic/bloc/fields/fields_bloc.dart';
import 'package:kinoverse/business_logic/bloc/job_bloc/job_bloc.dart';
import 'package:kinoverse/business_logic/bloc/reg_bloc/reg_bloc.dart';
import 'package:kinoverse/business_logic/cubit/fields_profile_photo_cubit/fields_photo_cubit.dart';
import 'package:kinoverse/business_logic/cubit/job_active_cubit/job_active_cubit.dart';
import 'package:kinoverse/core/route_pass.dart';
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
import 'package:kinoverse/page/worker/education/education_page.dart';
import 'package:kinoverse/page/worker/employment/employment_page.dart';
import 'package:kinoverse/page/worker/expertise_page/expertise_level_page.dart';
import 'package:kinoverse/page/worker/expertise_page/expertise_page.dart';
import 'package:kinoverse/page/worker/getting_started_page/getting_started_page1.dart';
import 'package:kinoverse/page/worker/getting_started_page/getting_started_page2.dart';
import 'package:kinoverse/page/worker/home_page/home_page.dart';
import 'package:kinoverse/page/worker/hourly_rate/hourly_rate_page.dart';
import 'package:kinoverse/page/worker/landing_page/landing_page.dart';
import 'package:kinoverse/page/worker/language/language_page.dart';
import 'package:kinoverse/page/worker/location/location_page.dart';
import 'package:kinoverse/page/worker/login_page/login.dart';
import 'package:kinoverse/page/worker/my_jobs/get_paid_page.dart';
import 'package:kinoverse/page/worker/my_jobs/submit_work_page.dart';
import 'package:kinoverse/page/worker/phone/phone_page.dart';
import 'package:kinoverse/page/worker/profile_overview/profile_overview_extension_page.dart';
import 'package:kinoverse/page/worker/profile_overview/profile_overview_page.dart';
import 'package:kinoverse/page/worker/profile_photo/profile_photo_page.dart';
import 'package:kinoverse/page/worker/sign_up/sign_up.dart';
import 'package:kinoverse/page/worker/sign_up/sign_up_2.dart';
import 'package:kinoverse/page/worker/title_overview/title_overview_page.dart';

class MyAppRoutes {
  RegBloc _regBloc = RegBloc();
  FieldsBloc _fieldsBloc = FieldsBloc();
  FieldsPhotoCubit _fieldsPhotoCubit = FieldsPhotoCubit();
  JobBloc _jobBloc = JobBloc();
  JobActiveCubit _jobActiveCubit = JobActiveCubit();
  ChatBloc _chatBloc = ChatBloc();

  Route onGenerateRoute(RouteSettings routeSettings) {
    try {
      switch (routeSettings.name) {
        //==================== AUTH ROUTES  ================================

        case LandingPage.routeName:
          return MaterialPageRoute(builder: (_) => LandingPage());

        case Login.routeName:
          return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: _regBloc,
                    child: Login(),
                  ));

        case SignUp.routeName:
          return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: _regBloc,
                    child: SignUp(),
                  ));

        case SignUp2.routeName:
          final args = routeSettings.arguments as SignUp2Args;
          return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: _regBloc,
                    child: SignUp2(args.email, args.isGoogle),
                  ));

        case HomePage.routeName:
          return MaterialPageRoute(builder: (_) => HomePage());

        // ======================= WORK ROUTES ==========================

        case GettingStartedPage1.routeName:
          return MaterialPageRoute(builder: (_) => GettingStartedPage1());

        case GettingStartedPage2.routeName:
          return MaterialPageRoute(builder: (_) => GettingStartedPage2());

        case CategoryPage.routeName:
          return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                    value: _fieldsBloc,
                    child: CategoryPage(),
                  ));

        case ExpertisePage.routeName:
          return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                    value: _fieldsBloc,
                    child: ExpertisePage(routeSettings.arguments),
                  ));

        case ExpertiseLevelPage.routeName:
          return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                    value: _fieldsBloc,
                    child: ExpertiseLevelPage(),
                  ));

        case EducationPage.routeName:
          return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                    value: _fieldsBloc,
                    child: EducationPage(routeSettings.arguments),
                  ));

        case EmploymentPage.routeName:
          return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                    value: _fieldsBloc,
                    child: EmploymentPage(routeSettings.arguments),
                  ));

        case LanguagePage.routeName:
          return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                    value: _fieldsBloc,
                    child: LanguagePage(routeSettings.arguments),
                  ));

        case HourlyRatePage.routeName:
          return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                    value: _fieldsBloc,
                    child: HourlyRatePage(routeSettings.arguments),
                  ));

        case TitleOverviewPage.routeName:
          return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                    value: _fieldsBloc,
                    child: TitleOverviewPage(),
                  ));

        case ProfilePhotoPage.routeName:
          return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                    value: _fieldsPhotoCubit,
                    child: ProfilePhotoPage(),
                  ));

        case LocationPage.routeName:
          return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                    value: _fieldsBloc,
                    child: LocationPage(),
                  ));

        case PhonePage.routeName:
          return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                    value: _fieldsBloc,
                    child: PhonePage(),
                  ));

        case ProfileOverviewPage.routeName:
          return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                    value: _fieldsBloc,
                    child: ProfileOverviewPage(routeSettings.arguments),
                  ));

        case ProfileOverViewExtensionPage.routeName:
          final args =
              routeSettings.arguments as ProfileOverViewExtensionPageArgs;
          return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                    value: _fieldsBloc,
                    child: ProfileOverViewExtensionPage(
                      args.isSubmitted,
                    ),
                  ));

        case SubmitWorkPage.routeName:
          return MaterialPageRoute(builder: (context) => SubmitWorkPage());

        case GetPaidPage.routeName:
          return MaterialPageRoute(builder: (context) => GetPaidPage());

        // ======================= HIRE ROUTES ==========================

        case HireSignupPage.routeName:
          final args = routeSettings.arguments as HireSignupPageArgs;
          return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: _fieldsBloc,
                    child: HireSignupPage(
                      name: args.name,
                      country: args.country,
                    ),
                  ));

        case HireHomePage.routeName:
          return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                    value: _fieldsBloc,
                    child: HireHomePage(),
                  ));

        case PostJobPage1.routeName:
          return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: _jobBloc,
                    child: PostJobPage1(routeSettings.arguments),
                  ));

        case PostJobPage2.routeName:
          return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: _jobBloc,
                    child: PostJobPage2(routeSettings.arguments),
                  ));

        case PostJobPage3.routeName:
          return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: _jobBloc,
                    child: PostJobPage3(routeSettings.arguments),
                  ));

        case PostJobPage4.routeName:
          return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: _jobBloc,
                    child: PostJobPage4(routeSettings.arguments),
                  ));

        case PostJobPage5.routeName:
          return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: _jobBloc,
                    child: PostJobPage5(routeSettings.arguments),
                  ));

        case PostJobPage6.routeName:
          return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: _jobBloc,
                    child: PostJobPage6(routeSettings.arguments),
                  ));

        case PostJobPage7.routeName:
          return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: _jobBloc,
                    child: PostJobPage7(),
                  ));

        case PreviewJobPage1.routeName:
          return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: _jobBloc,
                    child: PreviewJobPage1(routeSettings.arguments),
                  ));

        case PreviewJobPage2.routeName:
          return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: _jobBloc,
                    child: PreviewJobPage2(routeSettings.arguments),
                  ));

        case HireChatPage.routeName:
          final args = routeSettings.arguments as HireChatPageArgs;
          return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: _chatBloc,
                    child: HireChatPage(
                      uid: args.uid,
                      name: args.name,
                      photoUrl: args.photoUrl,
                    ),
                  ));

        case ContractPage.routeName:
          return MaterialPageRoute(builder: (context) => ContractPage());

        case HirePayNow.routeName:
          return MaterialPageRoute(builder: (context) => HirePayNow());

        default:
          return null;
      }
    } catch (e) {
      print(e);
    }
  }

  void dispose() async {
    _regBloc.close();
    _fieldsBloc.close();
    _jobBloc.close();
    _fieldsPhotoCubit.close();
    _jobActiveCubit.close();
    _chatBloc.close();
  }
}
