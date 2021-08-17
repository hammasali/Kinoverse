import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kinoverse/backend_service/models/job_post_model.dart';
import 'package:kinoverse/backend_service/repo/firebase_repo.dart';
import 'package:kinoverse/business_logic/cubit/talent_fav_cubit/talent_fav_cubit.dart';
import 'package:kinoverse/common/TextStyleRes.dart';

import '../../../app.dart';

class JobsTab extends StatefulWidget {
  @override
  _JobsTabState createState() => _JobsTabState();
}

class _JobsTabState extends State<JobsTab> {
  // final jobsTabs = ["Feeds", "Saved", "Search"];

  final jobsTabs = ["Feeds", "Hire", "Save"];
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
              children: [FeedsTab(), SearchTab(), SavedTab()],
            ),
          ),
        )
      ],
    );
  }
}

/// ============= Feeds Tab ===================

class FeedsTab extends StatefulWidget {
  @override
  _FeedsTabState createState() => _FeedsTabState();
}

class _FeedsTabState extends State<FeedsTab> {
  var searchController = TextEditingController();

  final Query _fetchJobPostsOfHirePanel =
      FirebaseRepo.instance.fetchJobPostsOfHirePanel();

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
          _retrieveData(context),
        ],
      ),
    );
  }

  Widget _retrieveData(BuildContext context) => FutureBuilder<QuerySnapshot>(
      future: isSearchExecuted
          ? _fetchSearchData(searchController.text).get()
          : _fetchJobPostsOfHirePanel.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return Center(
            child: TextStyleRes.textUbuntuStyleFont3(
                txtColor: txtDescriptionColor,
                text: "Something went wrong",
                fontSize: 12,
                fontWeight: FontWeight.w700),
          );
        else if (!snapshot.hasData || snapshot.data.size < 1)
          return Center(
            child: TextStyleRes.textUbuntuStyleFont3(
                txtColor: txtDescriptionColor,
                text: "Alas! No data found",
                fontSize: 12,
                fontWeight: FontWeight.w700),
          );
        else if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: getCircularProgress(context)),
          );
        else if (snapshot.connectionState == ConnectionState.done)
          return theJobPosts(snapshot.data.docs);

        return Center(
          child: TextStyleRes.textUbuntuStyleFont3(
              txtColor: txtDescriptionColor,
              text: "Loading...",
              fontSize: 12,
              fontWeight: FontWeight.w700),
        );
      });

  Widget theJobPosts(List<QueryDocumentSnapshot> docs) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: docs.length,
        itemBuilder: (BuildContext context, int index) {
          JobPostModel data =
              JobPostModel.fromMap(docs[index].data(), docs[index].id);

          return FeedItem(
            title: data.jobPost,
            contractType: data.projectPaymentType,
            postedTime: data.postTime,
            description: data.description,
            hoursNeeded: data.timeRequirement,
            duration: data.projectDuration,
            experienceLevel: data.freelancerType,
            rating: 0,
            isPaymentVerified: false,
            amountSpent: "0",
            isSubscribed: false,
            isSubmitted: false,
            isFavourite: false,
            tags: [...data.editingSoftware, ...data.editingPlatform],
            uid: data.uid,
            jobPostModel: data,
          );
        },
      ),
    );
  }

  Query _fetchSearchData(String text) =>
      FirebaseRepo.instance.fetchSearchData(text);
}

class FeedItem extends StatelessWidget {
  final String title;
  final String contractType;
  final String postedTime;
  final String description;
  final String hoursNeeded;
  final String duration;
  final String experienceLevel;
  final String amountSpent;
  final double rating;
  final bool isPaymentVerified;
  final bool isFavourite;
  final bool isSubmitted;
  final bool isSubscribed;
  final String uid;
  final JobPostModel jobPostModel;
  final List<String> tags;

  const FeedItem(
      {this.title,
      this.contractType,
      this.postedTime,
      this.description,
      this.hoursNeeded,
      this.duration,
      this.experienceLevel,
      this.amountSpent,
      this.rating,
      this.isPaymentVerified,
      this.isFavourite,
      this.isSubmitted,
      this.isSubscribed,
      this.tags,
      this.uid,
      this.jobPostModel});

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: getDeviceWidth(context) * 0.45,
                      child: TextStyleRes.textUbuntuStyleFont2(
                          text: title,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                    Spacer(),
                    Expanded(
                        child: TextStyleRes.textUbuntuStyleFont3(
                            txtColor: txtDescriptionColor,
                            text: "$contractType - Posted $postedTime ago",
                            fontSize: 10,
                            fontWeight: FontWeight.w400))
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
                                  text: hoursNeeded,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                              SizedBox(
                                height: 5,
                              ),
                              TextStyleRes.textUbuntuStyleFont3(
                                  txtColor: txtDescriptionColor,
                                  text: "Hours Needed",
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
                          color: isPaymentVerified
                              ? btnColor
                              : txtDescriptionColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        TextStyleRes.textUbuntuStyleFont2(
                            text: "Payment Verified",
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
                            text: "Spent",
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
                //TODO : Subscribe Module Here  ======== >>>>>
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

                /// ============ SUBMIT ICON BUTTON ================

                FutureBuilder<bool>(
                    future: fetchCurrentUserJobPostSubmits(uid),
                    builder: (context, snapshot) {
                      return SubmitWorker(
                          userData: jobPostModel,
                          toggle: snapshot.data ?? false);
                    }),

                /// ============ FAVOURITE ICON BUTTON ================
                FutureBuilder<bool>(
                    future: fetchCurrentUserJobPostFavourites(uid),
                    builder: (context, snapshot) {
                      return FavouriteIconWorker(
                          userData: jobPostModel,
                          toggle: snapshot.data ?? false);
                    }),

                // InkWell(
                //   onTap: () {
                //     ///submit tap
                //   },
                //   child: Row(
                //     children: [
                //       Image.asset(
                //         isSubmitted ? App.submittedIcon : App.submitIcon,
                //         height: 16,
                //       ),
                //       SizedBox(
                //         width: 5,
                //       ),
                //       TextStyleRes.textUbuntuStyleFont3(
                //           txtColor:
                //               isSubmitted ? btnColor : txtDescriptionColor,
                //           text: isSubmitted ? "Submitted" : "Submit",
                //           fontWeight: FontWeight.w400,
                //           fontSize: 10)
                //     ],
                //   ),
                // ),
                // InkWell(
                //   onTap: () {
                //     ///favourite tap
                //   },
                //   child: Row(
                //     children: [
                //       Image.asset(
                //         isFavourite ? App.unFavouriteIcon : App.favouriteIcon,
                //         height: 16,
                //       ),
                //       SizedBox(
                //         width: 5,
                //       ),
                //       TextStyleRes.textUbuntuStyleFont3(
                //           txtColor:
                //               isFavourite ? btnColor : txtDescriptionColor,
                //           text: "Favourite",
                //           fontWeight: FontWeight.w400,
                //           fontSize: 10)
                //     ],
                //   ),
                // ),
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

  Future<bool> fetchCurrentUserJobPostFavourites(data) async =>
      await FirebaseRepo.instance.fetchCurrentUserJobPostFavourites(data);

  Future<bool> fetchCurrentUserJobPostSubmits(data) async =>
      await FirebaseRepo.instance.fetchCurrentUserJobPostSubmits(data);
}

///==================== INVITE BUTTON =======================
class SubmitWorker extends StatefulWidget {
  final JobPostModel userData;
  bool toggle;

  SubmitWorker({Key key, this.userData, this.toggle}) : super(key: key);

  @override
  _SubmitWorkerState createState() => _SubmitWorkerState();
}

class _SubmitWorkerState extends State<SubmitWorker> {
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
              .addWorkerJobSubmits(widget.userData);
        else
          BlocProvider.of<TalentFavCubit>(context)
              .removeWorkerJobSubmits(widget.userData.uid);
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
              text: widget.toggle ? "Submitted" : "Submit",
              fontWeight: FontWeight.w400,
              fontSize: 10)
        ],
      ),
    );
  }
}

///      ==================== FAVOURITE BUTTON ====================

class FavouriteIconWorker extends StatefulWidget {
  final JobPostModel userData;
  bool toggle;

  FavouriteIconWorker({Key key, this.userData, this.toggle}) : super(key: key);

  @override
  _FavouriteIconWorkerState createState() => _FavouriteIconWorkerState();
}

class _FavouriteIconWorkerState extends State<FavouriteIconWorker> {
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
              .addWorkerJobFav(widget.userData);
        else
          BlocProvider.of<TalentFavCubit>(context)
              .removeWorkerJobFav(widget.userData.uid);
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
  }
}

/// ============= Save Tab ===================
class SavedTab extends StatelessWidget {
  final Query _fetchFavJobs = FirebaseRepo.instance.fetchFavJobs();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _retrieveData(context),
    );
  }

  Widget _retrieveData(BuildContext context) => StreamBuilder<QuerySnapshot>(
      stream: _fetchFavJobs.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return Center(
            child: TextStyleRes.textUbuntuStyleFont3(
                txtColor: txtDescriptionColor,
                text: "Something went wrong",
                fontSize: 12,
                fontWeight: FontWeight.w700),
          );
        else if (!snapshot.hasData || snapshot.data.size < 1)
          return Center(
            child: TextStyleRes.textUbuntuStyleFont3(
                txtColor: txtDescriptionColor,
                text: "Alas! No data found",
                fontSize: 12,
                fontWeight: FontWeight.w700),
          );
        else if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: getCircularProgress(context)),
          );
        else if (snapshot.connectionState == ConnectionState.done)
        return Center(
          child: TextStyleRes.textUbuntuStyleFont3(
              txtColor: txtDescriptionColor,
              text: "Loading...",
              fontSize: 12,
              fontWeight: FontWeight.w700),
        );

        return theJobPosts(snapshot.data.docs);
      });

  Widget theJobPosts(List<QueryDocumentSnapshot> docs) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: docs.length,
      itemBuilder: (BuildContext context, int index) {
        JobPostModel data =
        JobPostModel.fromMap(docs[index].data(), docs[index].id);

        return FeedItem(
          title: data.jobPost,
          contractType: data.projectPaymentType,
          postedTime: data.postTime,
          description: data.description,
          hoursNeeded: data.timeRequirement,
          duration: data.projectDuration,
          experienceLevel: data.freelancerType,
          rating: 0,
          isPaymentVerified: false,
          amountSpent: "0",
          isSubscribed: false,
          isSubmitted: false,
          isFavourite: false,
          tags: [...data.editingSoftware, ...data.editingPlatform],
          uid: data.uid,
          jobPostModel: data,
        );
      },
    );
  }

}

                    /// ============= Search Tab ===================

class SearchTab extends StatelessWidget {
  final Query _fetchSubmitJobs = FirebaseRepo.instance.fetchSubmitJobs();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _retrieveData(context),
    );
  }

  Widget _retrieveData(BuildContext context) =>
      StreamBuilder<QuerySnapshot>(
      stream: _fetchSubmitJobs.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return Center(
            child: TextStyleRes.textUbuntuStyleFont3(
                txtColor: txtDescriptionColor,
                text: "Something went wrong",
                fontSize: 12,
                fontWeight: FontWeight.w700),
          );
        else if (!snapshot.hasData || snapshot.data.size < 1)
          return Center(
            child: TextStyleRes.textUbuntuStyleFont3(
                txtColor: txtDescriptionColor,
                text: "Alas! No data found",
                fontSize: 12,
                fontWeight: FontWeight.w700),
          );
        else if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: getCircularProgress(context)),
          );
        else if (snapshot.connectionState == ConnectionState.done)
          return Center(
            child: TextStyleRes.textUbuntuStyleFont3(
                txtColor: txtDescriptionColor,
                text: "Loading...",
                fontSize: 12,
                fontWeight: FontWeight.w700),
          );

        return theJobPosts(snapshot.data.docs);
      });

  Widget theJobPosts(List<QueryDocumentSnapshot> docs) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: docs.length,
      itemBuilder: (BuildContext context, int index) {
        JobPostModel data =
        JobPostModel.fromMap(docs[index].data(), docs[index].id);

        return FeedItem(
          title: data.jobPost,
          contractType: data.projectPaymentType,
          postedTime: data.postTime,
          description: data.description,
          hoursNeeded: data.timeRequirement,
          duration: data.projectDuration,
          experienceLevel: data.freelancerType,
          rating: 0,
          isPaymentVerified: false,
          amountSpent: "0",
          isSubscribed: false,
          isSubmitted: false,
          isFavourite: false,
          tags: [...data.editingSoftware, ...data.editingPlatform],
          uid: data.uid,
          jobPostModel: data,
        );
      },
    );
  }
}
