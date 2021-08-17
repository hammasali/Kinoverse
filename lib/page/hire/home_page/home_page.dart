import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/backend_service/repo/firebase_repo.dart';
import 'package:kinoverse/business_logic/cubit/logout_cubit/logout_cubit.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/page/hire/home_page/alert_tab.dart';
import 'package:kinoverse/page/hire/home_page/jobs_tab.dart';
import 'package:kinoverse/page/hire/home_page/message_tab.dart';
import 'package:kinoverse/page/hire/home_page/talent_tab.dart';
import 'package:kinoverse/page/worker/home_page/home_page.dart';
import 'package:kinoverse/page/worker/landing_page/landing_page.dart';

class HireHomePage extends StatefulWidget {
  static const String routeName = '/hireHome_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HireHomePage> {
  final tabNames = ["Talent", "Jobs", "Messages", "Alerts"];
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutCubit, LogoutState>(
      bloc: BlocProvider.of<LogoutCubit>(context),
      listener: (context, state) {
        if (state is LogoutSuccessState)
          return Navigator.pushNamedAndRemoveUntil<dynamic>(
            context,
            LandingPage.routeName,
            (route) => false, //if you want to disable back feature set to false
          );
      },
      builder: (context, state) {
        if (state is LogoutLoadingState) return _loadingScreen();

        return _homeScreen();
      },
    );
  }

  Widget _homeScreen() => Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          elevation: 0,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Image.asset(
                App.menuIcon,
                height: 24,
                width: 24,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: PopupMenuButton<String>(
                elevation: 12,
                color: bgColor,
                onSelected: (val) {
                  print("$val clicked");
                },
                child: FutureBuilder<String>(
                    future: FirebaseRepo.instance.downloadURL(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.data != null)
                        return CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(snapshot.data)
                        );

                      return CircleAvatar(
                        child: Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                        backgroundColor: Colors.white,
                      );
                    }),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: "profile",
                    child: ListTile(
                      tileColor: bgColor,
                      leading: Image.asset(
                        App.profileIcon,
                        height: 24,
                      ),
                      title: TextStyleRes.textUbuntuStyleFont2(
                          text: "Profile",
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  PopupMenuItem(
                    value: "switch account",
                    child: ListTile(
                      tileColor: bgColor,
                      leading: Image.asset(
                        App.switchIcon,
                        height: 24,
                      ),
                      title: TextStyleRes.textUbuntuStyleFont2(
                          text: "Switch Account",
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                      onTap: () => Navigator.pushNamedAndRemoveUntil<dynamic>(
                        context,
                        HomePage.routeName,
                        (route) =>
                            false, //if you want to disable back feature set to false
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: "Logout",
                    child: ListTile(
                      tileColor: bgColor,
                      leading: Image.asset(
                        App.logoutIcon,
                        height: 24,
                      ),
                      title: TextStyleRes.textUbuntuStyleFont2(
                          text: "Logout",
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            )
          ],
          title: TextStyleRes.textStyleFont1(
              text: tabNames[_currentTab],
              fontSize: 14,
              fontWeight: FontWeight.w700,
              textColor: Colors.white),
          backgroundColor: btnColor,
          centerTitle: true,
        ),
        drawer: Drawer(
          child: Container(
            color: btnColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 8),
                  height: 150,
                  child: InkWell(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          App.drawerCloseIcon,
                          height: 16,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TextStyleRes.textUbuntuStyleFont2(
                            text: "close",
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: bgColor,
                  padding:
                      EdgeInsets.only(left: 20, right: 8, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Image.asset(
                        App.statsIcon,
                        height: 16,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: "My Stats",
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 8, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Image.asset(
                        App.reportIcon,
                        height: 16,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: "Reports",
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 8, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Image.asset(
                        App.disputesIcon,
                        height: 16,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: "Disputes",
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 16, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Image.asset(
                        App.covidIcon,
                        height: 16,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: "Covid-19 Resources",
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                      Spacer(),
                      Image.asset(
                        App.linkIcon,
                        height: 16,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 16, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Image.asset(
                        App.communityIcon,
                        height: 16,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: "Community & Forums",
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                      Spacer(),
                      Image.asset(
                        App.linkIcon,
                        height: 16,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 16, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Image.asset(
                        App.helpIcon,
                        height: 16,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: "Help",
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                      Spacer(),
                      Image.asset(
                        App.linkIcon,
                        height: 16,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 16, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Image.asset(
                        App.supportIcon,
                        height: 16,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: "Support",
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                      Spacer(),
                      Image.asset(
                        App.linkIcon,
                        height: 16,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 8, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Image.asset(
                        App.settingIcon,
                        height: 16,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: "Setting",
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
                  child: Image.asset(
                    App.logo,
                    height: 80,
                    width: 180,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: IndexedStack(
          index: _currentTab,
          children: [
            HireTalentTab(),
            HireJobsTab(),
            HireMessageTab(),
            HireAlertTab()
          ],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: bgColor,
              primaryColor: btnColor,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: btnColor))),
          child: BottomNavigationBar(
            selectedItemColor: Colors.white,
            unselectedItemColor: btnColor,
            elevation: 20,
            currentIndex: _currentTab,
            backgroundColor: bgColor,
            showUnselectedLabels: true,
            onTap: (position) {
              setState(() {
                _currentTab = position;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "Talent"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.note_add), label: "Jobs"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message), label: "Messages"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notification_important), label: "Alerts"),
            ],
          ),
        ),
      );

  Widget _loadingScreen() => Scaffold(
        backgroundColor: bgColor,
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextStyleRes.textStyleFont1(
                  textColor: Colors.white,
                  text: 'Logging Out...',
                  fontSize: 12,
                  fontWeight: FontWeight.w800),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: getCircularProgress(context),
              ),
            ],
          ),
        ),
      );
}
