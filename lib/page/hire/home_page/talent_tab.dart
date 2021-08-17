import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kinoverse/backend_service/repo/firebase_repo.dart';
import 'package:kinoverse/business_logic/cubit/talent_fav_cubit/talent_fav_cubit.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/model/hire_talent_fav_model.dart';

import '../../../app.dart';

class HireTalentTab extends StatefulWidget {
  @override
  _JobsTabState createState() => _JobsTabState();
}

class _JobsTabState extends State<HireTalentTab> {
  final jobsTabs = ["Search", "Hire", "Saved"];
  int _currentPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 56,
          width: double.infinity,
          color: btnColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) {
                  final item = jobsTabs[index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _currentPosition = index;
                      });
                    },
                    child: Container(
                      color: _currentPosition == index ? bgColor : btnColor,
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Center(
                          child: TextStyleRes.textUbuntuStyleFont3(
                              text: item,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              txtColor: _currentPosition == index
                                  ? Colors.white
                                  : Colors.grey)),
                    ),
                  );
                },
                itemCount: jobsTabs.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: bgColor,
            child: IndexedStack(
              index: _currentPosition,
              children: [SearchTab(), HireTab(), SavedTab()],
            ),
          ),
        )
      ],
    );
  }
}

/// ==================  SEARCH TAB =========================
class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  var searchController = TextEditingController();
  final Query _fetchWorkerFormFieldsData =
      FirebaseRepo.instance.fetchWorkerFormFieldsData();

  bool isSearchExecuted = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextStyleRes.textUbuntuStyleFont3(
                    txtColor: txtDescriptionColor,
                    text: "Search :  ",
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: btnBorderWhite, width: 1),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: getDeviceWidth(context) * 0.4,
                          child: TextFormField(
                            cursorColor: txtColor,
                            controller: searchController,
                            validator: (value) =>
                                value.trim().isEmpty || value == null
                                    ? 'Field is empty'
                                    : null,
                            onFieldSubmitted: (value) {
                              searchController.text = value;
                              setState(() {
                                isSearchExecuted = true;
                              });
                            },
                            style: TextStyle(
                              fontFamily: App.font2,
                              color: txtColor,
                              fontSize: 12,
                            ),
                            decoration: new InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                // suffixIcon: Icon(
                                //   Icons.search,
                                //   color: btnBorderWhite,
                                // ),
                                contentPadding: EdgeInsets.only(
                                  left: 10,
                                  bottom: 5,
                                  top: 5,
                                ),
                                hintText: "Type here to find jobs...",
                                hintStyle: TextStyle(
                                  fontFamily: App.font2,
                                  color: btnBorderWhite,
                                  fontSize: 10,
                                )),
                          ),
                        ),
                        Icon(
                          Icons.search,
                          color: btnBorderWhite,
                          size: 14,
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    )),
                Spacer(),
                isSearchExecuted
                    ? TextButton(
                        onPressed: () {
                          setState(() {
                            isSearchExecuted = false;
                            searchController.text = '';
                          });
                        },
                        child: TextStyleRes.textUbuntuStyleFont3(
                            txtColor: txtDescriptionColor,
                            text: "Clear Search",
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      )
                    : Container(),

                // Image.asset(
                //   App.filterIcon,
                //   height: 14,
                //   width: 20,
                //   color: btnBorderWhite,
                // ),
                // SizedBox(
                //   width: 5,
                // ),
                // TextStyleRes.textUbuntuStyleFont3(
                //     txtColor: txtDescriptionColor,
                //     text: "Filters",
                //     fontSize: 12,
                //     fontWeight: FontWeight.w700),
              ],
            ),
          ),
          // filter(),
          SizedBox(
            height: 5,
          ),
          _retrieveData(context)
          // Expanded(
          //   child: ListView(
          //     children: [
          //       HireFeedsItem(
          //         description:
          //             "fkd f vdnf vdsfvdsfv dkjsf vdsfjv dsfkjv dksfjv ds fjvd fsv",
          //         hoursNeeded: "Less than 30 hours/week",
          //         duration: "1 year",
          //         experienceLevel: "intermediate",
          //         rating: 0,
          //         isJob100Percent: true,
          //         amountSpent: "0",
          //         isSubscribed: false,
          //         isSubmitted: false,
          //         isFavourite: false,
          //         tags: ["Youtube", "Press"],
          //         jobSuccess: "100",
          //         jobTitle: "Designer",
          //         name: "Michel Jordan",
          //         address: "uhu, Utha",
          //         isTopRated: true,
          //         rate: "75",
          //       ),
          //       HireFeedsItem(
          //         description:
          //             "fkd f vdnf vdsfvdsfv dkjsf vdsfjv dsfkjv dksfjv ds fjvd fsv",
          //         hoursNeeded: "Less than 30 hours/week",
          //         duration: "1 year",
          //         experienceLevel: "intermediate",
          //         rating: 3.5,
          //         isJob100Percent: true,
          //         amountSpent: "0",
          //         isSubscribed: true,
          //         isSubmitted: true,
          //         isFavourite: true,
          //         tags: ["Youtube", "Press"],
          //         jobSuccess: "100",
          //         jobTitle:
          //             "Designer, Developer, Cyber Tech, Software, Hardware, Tester",
          //         name: "Michel Jordan",
          //         address: "uhu, Utha",
          //         isTopRated: false,
          //         rate: "75",
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  ///filters
  filter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          TextStyleRes.textUbuntuStyleFont3(
              txtColor: txtColor,
              text: "Category:",
              fontSize: 10,
              fontWeight: FontWeight.w400),
          SizedBox(
            width: 10,
          ),
          Expanded(child: FilterItem(["tags", "tags"])),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              ///clear Filter Tap
            },
            child: Row(
              children: [
                Image.asset(
                  App.drawerCloseIcon,
                  height: 14,
                  width: 14,
                  color: txtColor,
                ),
                SizedBox(
                  width: 5,
                ),
                TextStyleRes.textUbuntuStyleFont3(
                    txtColor: txtColor,
                    text: "Clear Filter",
                    fontSize: 10,
                    fontWeight: FontWeight.w400)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _retrieveData(BuildContext context) => FutureBuilder<QuerySnapshot>(
      future: isSearchExecuted
          ? _fetchSearchData(searchController.text).get()
          : _fetchWorkerFormFieldsData.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return Center(
            child: TextStyleRes.textUbuntuStyleFont3(
                txtColor: txtDescriptionColor,
                text: "Something went wrong",
                fontSize: 12,
                fontWeight: FontWeight.w700),
          );
        if (!snapshot.hasData)
          return Center(
            child: TextStyleRes.textUbuntuStyleFont3(
                txtColor: txtDescriptionColor,
                text: "Alas! No data found",
                fontSize: 12,
                fontWeight: FontWeight.w700),
          );
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: getCircularProgress(context)),
          );
        if (snapshot.connectionState == ConnectionState.done)
          return theUserInfo(snapshot.data.docs);

        return Center(
          child: TextStyleRes.textUbuntuStyleFont3(
              txtColor: txtDescriptionColor,
              text: "Loading...",
              fontSize: 12,
              fontWeight: FontWeight.w700),
        );
      });

  Widget theUserInfo(List<QueryDocumentSnapshot> data) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          TalentHireFavModel userData =
              TalentHireFavModel.fromMap(data[index].data());

          return HireFeedsItem(
            description: userData.professionalOverview,
            englishProficiency: userData.englishProficiency,
            duration: "1 year",
            experienceLevel: userData.expert,
            rating: 0,
            isJob100Percent: true,
            amountSpent: "0",
            isSubmitted: false,
            isFavourite: false,
            tags: [...userData.skills],
            jobSuccess: "100",
            jobTitle: userData.professionalOverview,
            name: userData.name,
            address: userData.country,
            isTopRated: false,
            rate: userData.hourlyRate,
            uid: userData.uid,
            talentHireFavModel: userData,
            // isSubscribed: false,
          );
        },
      ),
    );
  }



  Query _fetchSearchData(String text) =>
      FirebaseRepo.instance.fetchSearchData(text);
}

class HireFeedsItem extends StatelessWidget {
  final String name;
  final String jobTitle;
  final String address;
  final bool isTopRated;
  final String description;
  final String englishProficiency;
  final String duration;
  final String experienceLevel;
  final String amountSpent;
  final double rating;
  final bool isJob100Percent;
  final bool isFavourite;
  final bool isSubmitted;
  final bool isSubscribed;
  final List<String> tags;
  final String jobSuccess;
  final String rate;
  final String profilePicture;
  final String uid;
  final TalentHireFavModel talentHireFavModel;
  String downloadURL;

  HireFeedsItem(
      {this.description,
      this.englishProficiency,
      this.duration,
      this.experienceLevel,
      this.amountSpent,
      this.rating,
      this.isJob100Percent,
      this.isFavourite,
      this.isSubmitted,
      this.isSubscribed,
      this.tags,
      this.jobSuccess,
      this.name,
      this.jobTitle,
      this.address,
      this.isTopRated,
      this.rate,
      this.profilePicture,
      this.talentHireFavModel,
      this.uid});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //============ PROFILE PICTURE ========================

                    FutureBuilder<String>(
                        future: FirebaseRepo.instance.downloadAllUserURLs(uid),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.data != null)
                            return Container(
                              width: 50,
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.network(snapshot.data)),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                            );

                          return Container(
                            width: 60,
                            child: CircleAvatar(
                              radius: 30,
                              child: Icon(
                                Icons.account_circle_outlined,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              border: new Border.all(
                                color: btnColor,
                                width: 1.0,
                              ),
                            ),
                          );
                          // switch (snapshot.connectionState) {
                          //   case ConnectionState.done:
                          //     if (downloadURL == null) break;
                          //
                          //     return Container(
                          //       width: 60,
                          //       child: ClipRRect(
                          //         borderRadius: BorderRadius.circular(100.0),
                          //         child: FittedBox(
                          //             fit: BoxFit.cover,
                          //             child: Image.network(downloadURL)),
                          //       ),
                          //       decoration: new BoxDecoration(
                          //         shape: BoxShape.circle,
                          //         border: new Border.all(
                          //           color: btnColor,
                          //           width: 1.0,
                          //         ),
                          //       ),
                          //     );
                          //
                          //   default:
                          //     return Container(
                          //       width: 60,
                          //       child: CircleAvatar(
                          //         radius: 30,
                          //         child: Icon(
                          //           Icons.account_circle_outlined,
                          //           color: Colors.white,
                          //           size: 60,
                          //         ),
                          //       ),
                          //       decoration: new BoxDecoration(
                          //         shape: BoxShape.circle,
                          //         border: new Border.all(
                          //           color: btnColor,
                          //           width: 1.0,
                          //         ),
                          //       ),
                          //     );
                          // }
                        }),

                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextStyleRes.textUbuntuStyleFont2(
                              text: name,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                          SizedBox(
                            height: 2,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              txtColor: txtDescriptionColor,
                              text: jobTitle,
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                          SizedBox(
                            height: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 16,
                                color: Colors.white,
                              ),
                              TextStyleRes.textUbuntuStyleFont3(
                                  txtColor: txtDescriptionColor,
                                  text: address,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Spacer(),
                    Visibility(
                      visible: isTopRated,
                      child: Container(
                        color: btnColor,
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: Row(
                          children: [
                            Image.asset(
                              App.topRatedBadge,
                              color: Colors.white,
                              height: 14,
                              width: 14,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            TextStyleRes.textUbuntuStyleFont3(
                                txtColor: txtColor,
                                text: "Top Rated",
                                fontSize: 10,
                                fontWeight: FontWeight.w700),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextStyleRes.textUbuntuStyleFont3(
                        txtColor: txtColor,
                        text: "\$$rate",
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                    TextStyleRes.textUbuntuStyleFont3(
                        txtColor: txtDescriptionColor,
                        text: "/hour",
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextStyleRes.textUbuntuStyleFont3(
                    txtColor: txtColor,
                    text: description,
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 4.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  children: <Widget>[...generate_tags()],
                ),
                SizedBox(
                  height: 10,
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          // width: (getDeviceWidth(context) - 52) / 3,
                          color: backContainerColor,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextStyleRes.textUbuntuStyleFont2(
                                  text: englishProficiency,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                              SizedBox(
                                height: 5,
                              ),
                              TextStyleRes.textUbuntuStyleFont3(
                                  txtColor: txtDescriptionColor,
                                  text: "English Proficiency",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          // width: (getDeviceWidth(context) - 52) / 3,
                          color: backContainerColor,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextStyleRes.textUbuntuStyleFont2(
                                  text: duration,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                              SizedBox(
                                height: 5,
                              ),
                              TextStyleRes.textUbuntuStyleFont3(
                                  txtColor: txtDescriptionColor,
                                  text: "Duration",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          // width: (getDeviceWidth(context) - 52) / 3,
                          color: backContainerColor,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextStyleRes.textUbuntuStyleFont2(
                                  text: experienceLevel,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                              SizedBox(
                                height: 5,
                              ),
                              TextStyleRes.textUbuntuStyleFont3(
                                  txtColor: txtDescriptionColor,
                                  text: "Experience Level",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Container(
                //       width: (getDeviceWidth(context) - 52) / 3,
                //       color: backContainerColor,
                //       padding: EdgeInsets.all(8),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           TextStyleRes.textUbuntuStyleFont2(
                //               text: hoursNeeded,
                //               fontSize: 14,
                //               fontWeight: FontWeight.w400),
                //           SizedBox(
                //             height: 5,
                //           ),
                //           TextStyleRes.textUbuntuStyleFont3(
                //               txtColor: txtDescriptionColor,
                //               text: "Hours Needed",
                //               fontSize: 14,
                //               fontWeight: FontWeight.w400),
                //         ],
                //       ),
                //     ),
                //     SizedBox(
                //       height: 10,
                //     ),
                //     Container(
                //       width: (getDeviceWidth(context) - 52) / 3,
                //       color: backContainerColor,
                //       padding: EdgeInsets.all(8),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           TextStyleRes.textUbuntuStyleFont2(
                //               text: duration,
                //               fontSize: 14,
                //               fontWeight: FontWeight.w400),
                //           SizedBox(
                //             height: 5,
                //           ),
                //           TextStyleRes.textUbuntuStyleFont3(
                //               txtColor: txtDescriptionColor,
                //               text: "Duration",
                //               fontSize: 14,
                //               fontWeight: FontWeight.w400),
                //         ],
                //       ),
                //     ),
                //     SizedBox(
                //       height: 10,
                //     ),
                //     Container(
                //       width: (getDeviceWidth(context) - 52) / 3,
                //       color: backContainerColor,
                //       padding: EdgeInsets.all(8),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           TextStyleRes.textUbuntuStyleFont2(
                //               text: experienceLevel,
                //               fontSize: 14,
                //               fontWeight: FontWeight.w400),
                //           SizedBox(
                //             height: 5,
                //           ),
                //           TextStyleRes.textUbuntuStyleFont3(
                //               txtColor: txtDescriptionColor,
                //               text: "Experience Level",
                //               fontSize: 14,
                //               fontWeight: FontWeight.w400),
                //         ],
                //       ),
                //     )
                //   ],
                // ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: RatingBar.builder(
                        ignoreGestures: true,
                        itemSize: 24,
                        unratedColor: txtDescriptionColor,
                        initialRating: rating,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: btnColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          App.verifiedIcon,
                          height: 16,
                          color:
                              isJob100Percent ? btnColor : txtDescriptionColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        TextStyleRes.textUbuntuStyleFont2(
                            text: "$jobSuccess% Job Success",
                            fontSize: 10,
                            fontWeight: FontWeight.w400)
                      ],
                    ),
                    Row(
                      children: [
                        TextStyleRes.textUbuntuStyleFont2(
                            text: "\$$amountSpent",
                            fontSize: 10,
                            fontWeight: FontWeight.w700),
                        SizedBox(
                          width: 10,
                        ),
                        TextStyleRes.textUbuntuStyleFont2(
                            text: "Earned",
                            fontSize: 10,
                            fontWeight: FontWeight.w400)
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    ///View more Tap
                  },
                  child: Row(
                    children: [
                      TextStyleRes.textUbuntuStyleFont3(
                          text: "View More",
                          txtColor: txtDescriptionColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w700),
                      Icon(
                        Icons.expand_more,
                        color: txtDescriptionColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: backContainerColor,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //TODO: SUBSCRIBE MODULE HERE  ======= >>>>>>>>>> ========

                // InkWell(
                //   onTap: () {
                //     ///subscribe tap
                //   },
                //   child: Row(
                //     children: [
                //       Image.asset(
                //         isSubscribed ? App.unSubscribeIcon : App.subscribeIcon,
                //         height: 16,
                //       ),
                //       SizedBox(
                //         width: 5,
                //       ),
                //       TextStyleRes.textUbuntuStyleFont3(
                //           txtColor:
                //               isSubscribed ? btnColor : txtDescriptionColor,
                //           text: isSubscribed ? "Unsubscribe" : "Subscribe",
                //           fontWeight: FontWeight.w400,
                //           fontSize: 10)
                //     ],
                //   ),
                // ),
                /// ============ INVITE ICON BUTTON ================

                FutureBuilder<bool>(
                    future: _fetchCurrentUserInvites(uid),
                    builder: (context, snapshot) {
                      return Invites(
                          userData: talentHireFavModel,
                          toggle: snapshot.data ?? false);
                    }),

                /// ============ FAVOURITE ICON BUTTON ================
                FutureBuilder<bool>(
                    future: _fetchCurrentUserFavourites(uid),
                    builder: (context, snapshot) {
                      return FavouriteIcon(
                          talentHireFavModel, snapshot.data ?? false);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///tagItem
  tagItem() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: btnBorderWhite, width: 1),
      ),
      padding: EdgeInsets.all(8),
      child: TextStyleRes.textUbuntuStyleFont2(
          text: "Youtube", fontSize: 15, fontWeight: FontWeight.w400),
    );
  }

  ///list
  generate_tags() {
    return tags.map((tag) => get_chip(tag)).toList();
  }

  get_chip(name) {
    return Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: InputChip(
        backgroundColor: Colors.transparent,
        labelStyle: TextStyle(color: txtColor),
        label: TextStyleRes.textUbuntuStyleFont3(
            txtColor: txtColor,
            text: "$name",
            fontSize: 10,
            fontWeight: FontWeight.w400),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: btnBorderWhite, width: 1),
          borderRadius: BorderRadius.circular(0),
        ),
      ),
    );
  }

  getAllURLs(String uid) async {
    downloadURL = await FirebaseRepo.instance.downloadAllUserURLs(uid);
  }

  Future<bool> _fetchCurrentUserInvites(data) async =>
      await FirebaseRepo.instance.fetchCurrentUserInvited(data);

  Future<bool> _fetchCurrentUserFavourites(data) async =>
      await FirebaseRepo.instance.fetchCurrentUserFavourites(data);
}

///==================== INVITE BUTTON =======================
class Invites extends StatefulWidget {
  final TalentHireFavModel userData;
  bool toggle;

  Invites({this.userData, this.toggle});

  @override
  _InvitesState createState() => _InvitesState();
}

class _InvitesState extends State<Invites> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          // Here we changing the icon.
          widget.toggle = !widget.toggle;
        });
        if (widget.toggle)
          BlocProvider.of<TalentFavCubit>(context)
              .addTalentInvite(widget.userData);
        else
          BlocProvider.of<TalentFavCubit>(context)
              .removeTalentInvite(widget.userData.uid);
      },
      child: Row(
        children: [
          Image.asset(
            widget.toggle ? App.submittedIcon : App.submitIcon,
            height: 16,
          ),
          SizedBox(
            width: 5,
          ),
          TextStyleRes.textUbuntuStyleFont3(
              txtColor: widget.toggle ? btnColor : txtDescriptionColor,
              text: widget.toggle ? "Invited" : "Invite to job",
              fontWeight: FontWeight.w400,
              fontSize: 10)
        ],
      ),
    );

    return TextButton(
        child: widget.toggle ? Text('UnInvite') : Text('Invite'),
        onPressed: () {
          setState(() {
            // Here we changing the icon.
            widget.toggle = !widget.toggle;
          });
          if (widget.toggle)
            BlocProvider.of<TalentFavCubit>(context)
                .addTalentInvite(widget.userData);
          else
            BlocProvider.of<TalentFavCubit>(context)
                .removeTalentInvite(widget.userData.uid);
        });
  }
}

///==================== FAVOURITE BUTTON ====================
class FavouriteIcon extends StatefulWidget {
  final TalentHireFavModel userData;
  bool toggle;

  FavouriteIcon(this.userData, this.toggle);

  @override
  _FavouriteIconState createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          // Here we changing the icon.
          widget.toggle = !widget.toggle;
        });
        if (widget.toggle)
          BlocProvider.of<TalentFavCubit>(context)
              .addTalentFav(widget.userData);
        else
          BlocProvider.of<TalentFavCubit>(context)
              .removeTalentFav(widget.userData.uid);
      },
      child: Row(
        children: [
          Image.asset(
            widget.toggle ? App.unFavouriteIcon : App.favouriteIcon,
            height: 16,
          ),
          SizedBox(
            width: 5,
          ),
          TextStyleRes.textUbuntuStyleFont3(
              txtColor: widget.toggle ? btnColor : txtDescriptionColor,
              text: "Favourite",
              fontWeight: FontWeight.w400,
              fontSize: 10)
        ],
      ),
    );

    // return InkWell(
    //   onTap: () {
    //     setState(() {
    //       // Here we changing the icon.
    //       widget.toggle = !widget.toggle;
    //     });
    //     if (widget.toggle)
    //       BlocProvider.of<TalentFavCubit>(context)
    //           .addTalentFav(widget.userData);
    //     else
    //       BlocProvider.of<TalentFavCubit>(context)
    //           .removeTalentFav(widget.userData.uid);
    //   },
    //   child: Image.asset(
    //     widget.toggle ? App.favouriteIcon : App.unFavouriteIcon,
    //     height: 16,
    //   ),
    // );
  }
}

///==================== FILTER ITEM =========================
class FilterItem extends StatelessWidget {
  final List<String> tags;

  const FilterItem(this.tags);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        spacing: 4.0, // gap between adjacent chips
        runSpacing: 4.0, // gap between lines
        children: <Widget>[...generate_tags()],
      ),
    );
  }

  ///list
  generate_tags() {
    return tags.map((tag) => get_chip(tag)).toList();
  }

  get_chip(name) {
    return Theme(
      data: ThemeData(canvasColor: btnBorderWhite),
      child: InputChip(
        backgroundColor: btnBorderWhite,
        labelStyle: TextStyle(color: Colors.black),
        label: TextStyleRes.textUbuntuStyleFont3(
            txtColor: Colors.black,
            text: "$name",
            fontSize: 10,
            fontWeight: FontWeight.w400),
        shape: RoundedRectangleBorder(
          // side: BorderSide(color: btnBorderWhite, width: 1),
          borderRadius: BorderRadius.circular(0),
        ),
      ),
    );
  }
}

class HireTab extends StatefulWidget {
  @override
  _HireTabState createState() => _HireTabState();
}

class _HireTabState extends State<HireTab> {
  var searchController = TextEditingController();

  final Query _fetchInvitesUser = FirebaseRepo.instance.fetchInvitedUsers();

  bool isSearchExecuted = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextStyleRes.textUbuntuStyleFont3(
                    txtColor: txtDescriptionColor,
                    text: "Search:",
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: btnBorderWhite, width: 1),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 180,
                          child: TextFormField(
                            cursorColor: txtColor,
                            controller: searchController,
                            validator: (value) =>
                                value.trim().isEmpty || value == null
                                    ? 'Field is empty'
                                    : null,
                            onFieldSubmitted: (value) {
                              searchController.text = value;
                              setState(() {
                                isSearchExecuted = true;
                              });
                            },
                            style: TextStyle(
                              fontFamily: App.font2,
                              color: txtColor,
                              fontSize: 12,
                            ),
                            decoration: new InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                // suffixIcon: Icon(
                                //   Icons.search,
                                //   color: btnBorderWhite,
                                // ),
                                contentPadding: EdgeInsets.only(
                                  left: 10,
                                  bottom: 5,
                                  top: 5,
                                ),
                                hintText: "Type here to find jobs...",
                                hintStyle: TextStyle(
                                  fontFamily: App.font2,
                                  color: btnBorderWhite,
                                  fontSize: 10,
                                )),
                          ),
                        ),
                        Icon(
                          Icons.search,
                          color: btnBorderWhite,
                          size: 14,
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    )),
                Spacer(),
                isSearchExecuted
                    ? TextButton(
                        onPressed: () {
                          setState(() {
                            isSearchExecuted = false;
                            searchController.text = '';
                          });
                        },
                        child: TextStyleRes.textUbuntuStyleFont3(
                            txtColor: txtDescriptionColor,
                            text: "Clear Search",
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      )
                    : Container(),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: isSearchExecuted
                  ? _fetchSearchData(searchController.text).snapshots()
                  : _fetchInvitesUser.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return Center(
                    child: TextStyleRes.textUbuntuStyleFont3(
                        txtColor: txtDescriptionColor,
                        text: "Something went wrong",
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  );
                if (!snapshot.hasData)
                  return Center(
                    child: TextStyleRes.textUbuntuStyleFont3(
                        txtColor: txtDescriptionColor,
                        text: "Alas! No data found",
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  );
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(
                    child: Padding(
                        padding: EdgeInsets.all(16),
                        child: getCircularProgress(context)),
                  );

                return theUserInfo(snapshot.data.docs);
              }),
        ],
      ),
    );
  }

  Widget theUserInfo(List<QueryDocumentSnapshot> data) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          TalentHireFavModel userData =
              TalentHireFavModel.fromMap(data[index].data());
          print(userData.uid);

          return HireFeedsItem(
            description: userData.professionalOverview,
            englishProficiency: userData.englishProficiency,
            duration: "1 year",
            experienceLevel: userData.expert,
            rating: 0,
            isJob100Percent: true,
            amountSpent: "0",
            isSubmitted: false,
            isFavourite: false,
            tags: [...userData.skills],
            jobSuccess: "100",
            jobTitle: userData.professionalOverview,
            name: userData.name,
            address: userData.country,
            isTopRated: false,
            rate: userData.hourlyRate,
            uid: userData.uid,
            talentHireFavModel: userData,
            // isSubscribed: false,
          );
        },
      ),
    );
  }

  Query _fetchSearchData(String text) =>
      FirebaseRepo.instance.fetchHireTabSearchData(text);
}

class SavedTab extends StatefulWidget {
  @override
  _SavedTabState createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {
  var searchController = TextEditingController();

  final Query _fetchFavUser = FirebaseRepo.instance.fetchFavUsers();

  bool isSearchExecuted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextStyleRes.textUbuntuStyleFont3(
                    txtColor: txtDescriptionColor,
                    text: "Search:",
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: btnBorderWhite, width: 1),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 180,
                          child: TextFormField(
                            cursorColor: txtColor,
                            controller: searchController,
                            validator: (value) =>
                                value.trim().isEmpty || value == null
                                    ? 'Field is empty'
                                    : null,
                            onFieldSubmitted: (value) {
                              searchController.text = value;
                              setState(() {
                                isSearchExecuted = true;
                              });
                            },
                            style: TextStyle(
                              fontFamily: App.font2,
                              color: txtColor,
                              fontSize: 12,
                            ),
                            decoration: new InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                // suffixIcon: Icon(
                                //   Icons.search,
                                //   color: btnBorderWhite,
                                // ),
                                contentPadding: EdgeInsets.only(
                                  left: 10,
                                  bottom: 5,
                                  top: 5,
                                ),
                                hintText: "Type here to find jobs...",
                                hintStyle: TextStyle(
                                  fontFamily: App.font2,
                                  color: btnBorderWhite,
                                  fontSize: 10,
                                )),
                          ),
                        ),
                        Icon(
                          Icons.search,
                          color: btnBorderWhite,
                          size: 14,
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    )),
                Spacer(),
                isSearchExecuted
                    ? TextButton(
                        onPressed: () {
                          setState(() {
                            isSearchExecuted = false;
                            searchController.text = '';
                          });
                        },
                        child: TextStyleRes.textUbuntuStyleFont3(
                            txtColor: txtDescriptionColor,
                            text: "Clear Search",
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      )
                    : Container(),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: isSearchExecuted
                  ? _fetchSearchData(searchController.text).snapshots()
                  : _fetchFavUser.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return Center(
                    child: TextStyleRes.textUbuntuStyleFont3(
                        txtColor: txtDescriptionColor,
                        text: "Something went wrong",
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  );
                if (!snapshot.hasData)
                  return Center(
                    child: TextStyleRes.textUbuntuStyleFont3(
                        txtColor: txtDescriptionColor,
                        text: "Alas! No data found",
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  );
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(
                    child: Padding(
                        padding: EdgeInsets.all(16),
                        child: getCircularProgress(context)),
                  );

                return theUserInfo(snapshot.data.docs);
              }),
        ],
      ),
    );
  }

  Widget theUserInfo(List<QueryDocumentSnapshot> data) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          TalentHireFavModel userData =
              TalentHireFavModel.fromMap(data[index].data());
          print(userData.uid);

          return HireFeedsItem(
            description: userData.professionalOverview,
            englishProficiency: userData.englishProficiency,
            duration: "1 year",
            experienceLevel: userData.expert,
            rating: 0,
            isJob100Percent: true,
            amountSpent: "0",
            isSubmitted: false,
            isFavourite: false,
            tags: [...userData.skills],
            jobSuccess: "100",
            jobTitle: userData.professionalOverview,
            name: userData.name,
            address: userData.country,
            isTopRated: false,
            rate: userData.hourlyRate,
            uid: userData.uid,
            talentHireFavModel: userData,
            // isSubscribed: false,
          );
        },
      ),
    );
  }

  Query _fetchSearchData(String text) =>
      FirebaseRepo.instance.fetchFavTabSearchData(text);
}
