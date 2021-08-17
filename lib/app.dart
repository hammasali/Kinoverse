import 'package:flutter/material.dart';

bool isLight = true;

class App {
  static const font1 = "Courier Prime";
  static const font2 = "Ubuntu";

  static const root = 'assets/image/';
  static const logo = '$root' + 'logo.png';
  static const landing1 = '$root' + 'landing1.png';
  static const landing2 = '$root' + 'landing2.jpg';
  static const landing3 = '$root' + 'landing3.jpg';
  static const gallary = '$root' + 'gallary.png';
  static const vactor = '$root' + 'Vector.png';
  static const edit = '$root' + 'edit.png';
  static const location = '$root' + 'location.png';
  static const envelope = '$root' + 'envelope.png';
  static const search = '$root' + 'search.png';
  static const download = '$root' + 'download.png';
  static const Useremail = '$root' + 'Useremail.png';
  static const Password = '$root' + 'Password.png';
  static const closeCircle = '$root' + 'close.png';
  static const closeCircleDark = '$root' + 'closedarkgrey.png';
  static const categoryIcon = '$root' + 'category.png';
  static const educationIcon = '$root' + 'education.png';
  static const employmentIcon = '$root' + 'employment.png';
  static const expertiseIcon = '$root' + 'expertise.png';
  static const hourlyRateIcon = '$root' + 'hourlyrate.png';
  static const expertiseLevelIcon = '$root' + 'expertiselevel.png';
  static const microphoneIcon = '$root' + 'microphone.png';
  static const phoneIcon = '$root' + 'phone.png';
  static const playIcon = '$root' + 'play.png';
  static const profilePhotoIcon = '$root' + 'profilephoto.png';
  static const rateGraphIcon = '$root' + 'rategraph.png';
  static const titleIcon = '$root' + 'title.png';
  static const attachedIcon = '$root' + 'attached.png';
  static const attachmentIcon = '$root' + 'attachment.png';
  static const audioIcon = '$root' + 'audio.png';
  static const backIcon = '$root' + 'back.png';
  static const communityIcon = '$root' + 'community.png';
  static const covidIcon = '$root' + 'covid.png';
  static const disputesIcon = '$root' + 'disputes.png';
  static const favouriteIcon = '$root' + 'favourite.png';
  static const helpIcon = '$root' + 'help.png';
  static const linkIcon = '$root' + 'link.png';
  static const logoutIcon = '$root' + 'logout.png';
  static const menuIcon = '$root' + 'menu.png';
  static const moreIcon = '$root' + 'more.png';
  static const profileIcon = '$root' + 'profile.png';
  static const reportIcon = '$root' + 'report.png';
  static const sendIcon = '$root' + 'send.png';
  static const settingIcon = '$root' + 'setting.png';
  static const statsIcon = '$root' + 'stats.png';
  static const submitIcon = '$root' + 'submit.png';
  static const submittedIcon = '$root' + 'submited.png';
  static const subscribeIcon = '$root' + 'subscribe.png';
  static const supportIcon = '$root' + 'support.png';
  static const switchIcon = '$root' + 'switch.png';
  static const unFavouriteIcon = '$root' + 'unfavourite.png';
  static const unSubscribeIcon = '$root' + 'unsubscribe.png';
  static const verifiedIcon = '$root' + 'verified.png';
  static const myJobsIcon = '$root' + 'myjobs.png';
  static const drawerCloseIcon = '$root' + 'drawerclose.png';
  static const mailIcon = '$root' + 'mail.png';
  static const deleteIcon = '$root' + 'delete.png';
  static const calendarIcon = '$root' + 'calendar.png';
  static const budgetIcon = '$root' + 'budget.png';
  static const escrowIcon = '$root' + 'escrow.png';
  static const milestoneIcon = '$root' + 'milestone.png';
  static const pendingIcon = '$root' + 'pending.png';
  static const remainingIcon = '$root' + 'remaining.png';
  static const reviewIcon = '$root' + 'review.png';
  static const workProgressIcon = '$root' + 'workprogress.png';
  static const filterIcon = '$root' + 'filter.png';
  static const addPeopleIcon = '$root' + 'addpeople.png';
  static const bankIcon = '$root' + 'bank.png';
  static const bonusIcon = '$root' + 'bonus.png';
  static const complexProjectIcon = '$root' + 'complexproject.png';
  static const depositIcon = '$root' + 'deposit.png';
  static const freelancerIcon = '$root' + 'freelancer.png';
  static const mastercardIcon = '$root' + 'Mastercard.png';
  static const moreFreelancerIcon = '$root' + 'morefreelancer.png';
  static const oneTimeProjectIcon = '$root' + 'onetimeproject.png';
  static const ongoingIcon = '$root' + 'ongoing.png';
  static const payoneerLogo = '$root' + 'PayoneerLogo.png';
  static const selectedIcon = '$root' + 'selected.png';
  static const topRatedBadge = '$root' + 'topratedbadge.png';
  static const unselectedIcon = '$root' + 'unselected.png';
  static const uploadIcon = '$root' + 'upload.png';
  static const paypalLogo = '$root' + 'PayPalLogo.png';
  static const debitIcon = '$root' + 'debit.png';
  static const chargeIcon = '$root' + 'charge.png';
  static const fixPriceIcon = '$root' + 'fixprice.png';
  static const hourlyHourIcon = '$root' + 'hourlyhour.png';

  ///bottomNev text
  static const messages = '$root' + 'messages.png';
  static const jobs = '$root' + 'jobs.png';
  static const talent = '$root' + 'talent.png';
  static const alert = '$root' + 'alert.png';
  static const drawerIcon = '$root' + 'drawerIcon.png';

  static Route createRoute({Widget page}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.fastLinearToSlowEaseIn;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

getColorIcon() {
  if (isLight) {
    return getColorPrimary();
  } else {
    return Colors.white;
  }
}

Color bgColor = Color(0x00ff3E4346);
Color btnColor = Color(0x00ffA60000);
Color txtColor = Color(0x00ffF5F5F5);
Color txtDescriptionColor = Color(0x00ff929292);
Color colorWhite = Color(0x00ffF7F7FA);
Color btnBorderWhite = Color(0x00ff929292);
Color shadowColorBlack = Color(0xFF343739);
Color blackText = Color(0xFF3E4345);
Color backContainerColor = Color(0xFF2B2F30);

Color colorBrown = Colors.brown;
Color colorTextPara = Color(0x00ff73777F);
Color colorAppSignUp = Color.fromRGBO(94, 93, 200, 1);
Color colorBgTextField = Color.fromRGBO(245, 245, 245, 1);
Color colorAppTheme = Color.fromRGBO(58, 77, 219, 1);
Color colorBlack = Color(0x00ff000000);
Color colorSelectedMenu = Colors.green[300];
Map<int, Color> colorMat = {
  50: Color.fromRGBO(65, 20, 139, .1),
  100: Color.fromRGBO(65, 20, 139, .2),
  200: Color.fromRGBO(65, 20, 139, .3),
  300: Color.fromRGBO(65, 20, 139, .4),
  400: Color.fromRGBO(65, 20, 139, .5),
  500: Color.fromRGBO(65, 20, 139, .6),
  600: Color.fromRGBO(65, 20, 139, .7),
  700: Color.fromRGBO(65, 20, 139, .8),
  800: Color.fromRGBO(65, 20, 139, .9),
  900: Color.fromRGBO(65, 20, 139, 1),
};

getColorPrimary() {
  if (isLight) {
    return MaterialColor(0x00ff3E4346, colorMat);
  } else {
    return Colors.green;
  }
}

getColorBorder() {
  if (isLight) {
    return Colors.green;
  } else {
    return Colors.green;
  }
}

getColorBg() {
  if (isLight) {
    return Color(0x00ffFFF9F9);
  } else {
    return Color(0x00ffFFF9F9);
  }
}

getMatColorBg() {
  if (isLight) {
    return Colors.white;
  } else {
    return Colors.white;
  }
}

Route createRoute({Widget page}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.fastLinearToSlowEaseIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

getDeviceHeight(context) {
  return MediaQuery.of(context).size.height;
}

getDeviceWidth(context) {
  return MediaQuery.of(context).size.width;
}

getCircularProgress(context) {
  return CircularProgressIndicator.adaptive(
    strokeWidth: 1.1,
    backgroundColor: Color(0x00ffA60000),
    valueColor: new AlwaysStoppedAnimation<Color>(Color(0x00ffffffff)),
  );
}
