import '../../../app.dart';
import 'landing_page.dart';

class LandingPageViewModel {
  LandingPageState state;
  List<String> image = [
    App.landing1,
    App.landing2,
    App.landing3,
  ];
  List<String> title = [
    'A Global Filmmaker Network For Hire',
    'Find Interesting Projects And Submit Proposals',
    'Collaborate On The Go!'
  ];
  List<String> subTitle = [
    'Find any professional and agencies for any projects.',
    'Easy find work, chat, and collaborate on the go.',
    'Chat, share files, and complete projects.'
  ];

  LandingPageViewModel(LandingPageState state) {
    this.state = state;
  }
}
