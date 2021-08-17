import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/backend_service/models/job_post_model.dart';
import 'package:kinoverse/backend_service/repo/firebase_repo.dart';
import 'package:kinoverse/business_logic/cubit/job_active_cubit/job_active_cubit.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_route.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/page/hire/payment/contract_page.dart';
import 'package:kinoverse/page/hire/post_job/post_job_1.dart';

import '../../../app.dart';

class HireJobsTab extends StatefulWidget {
  @override
  _JobsTabState createState() => _JobsTabState();
}

class _JobsTabState extends State<HireJobsTab> {
  final jobsTabs = ["All", "Posting", "Contract"];
  int _currentPosition = 0;

  void _update(int currentPosition) {
    setState(() => _currentPosition = currentPosition);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<JobActiveCubit>(
      create: (_) => JobActiveCubit(),
      lazy: true,
      child: Column(
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
                children: [
                  AllTab(update: _update),
                  PostingTab(),
                  ContractTab()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ============== ALL TABS ==================
class AllTab extends StatelessWidget {
  final Future<int> _getJobPost =
      FirebaseRepo.instance.fetchCurrentUserJobPostLength();
  final Future<int> _getContract =
      FirebaseRepo.instance.fetchCurrentUserContractsLength();
  final ValueChanged<int> update;

  AllTab({this.update});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
                border: Border.all(color: btnBorderWhite, width: 1)),
            child: Row(
              children: [
                FutureBuilder(
                    future: _getJobPost,
                    builder:
                        (BuildContext context, AsyncSnapshot<int> snapshot) {
                      if (snapshot.hasError)
                        return TextStyleRes.textUbuntuStyleFont3(
                            txtColor: txtColor,
                            text: "Something went wrong",
                            fontSize: 12,
                            fontWeight: FontWeight.w400);

                      return Expanded(
                        child: InkWell(
                          onTap: () => update(1),
                          child: TextStyleRes.textUbuntuStyleFont3(
                              txtColor: txtColor,
                              text: "Posting (${snapshot.data ?? 0})",
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      );
                    }),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 12,
                  color: btnBorderWhite,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
                border: Border.all(color: btnBorderWhite, width: 1)),
            child: Row(
              children: [
                FutureBuilder(
                    future: _getContract,
                    builder:
                        (BuildContext context, AsyncSnapshot<int> snapshot) {
                      if (snapshot.hasError)
                        return TextStyleRes.textUbuntuStyleFont3(
                            txtColor: txtColor,
                            text: "Something went wrong",
                            fontSize: 12,
                            fontWeight: FontWeight.w400);

                      return Expanded(
                        child: InkWell(
                          onTap: () => update(2),
                          child: TextStyleRes.textUbuntuStyleFont3(
                              txtColor: txtColor,
                              text: "Contracts (${snapshot.data ?? 0})",
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      );
                    }),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 12,
                  color: btnBorderWhite,
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //TODO: CATALOG MODULE HERE ======== >>>>>>>
              //  Container(
              //     height: 35,
              //     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              //     decoration: BoxDecoration(
              //         border: Border.all(color: btnColor, width: 1)),
              //     child: TextStyleRes.textUbuntuStyleFont3(
              //         txtColor: txtColor,
              //         text: "Catalog",
              //         fontSize: 12,
              //         fontWeight: FontWeight.w300),
              //   ),
              SizedBox(
                width: 20,
              ),
              CommonWidget.squareButton(
                text: "Post New Job",
                fontSize: 12.0,
                height: 35.0,
                width: 150.0,
                containerColor: btnColor,
                textColor: txtColor,
                onTap: () {
                  //CommonRoutePage().gotoPostJobPage1(context);
                  Navigator.of(context).pushNamed(PostJobPage1.routeName);
                },
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),

          //TODO: JOB TEMPLATES MODULE HERE ========= >>>>>>>>> =========

          // Container(
          //   color: backContainerColor,
          //   padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       TextStyleRes.textUbuntuStyleFont3(
          //           txtColor: txtColor,
          //           text: "COVID 19",
          //           fontSize: 14,
          //           fontWeight: FontWeight.w700),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       TextStyleRes.textUbuntuStyleFont3(
          //           txtColor: txtColor,
          //           text:
          //               "See how other businesses are connecting with expert to adjust in this uncertain times. Choose a job template to quickly fill projects you need now.",
          //           fontSize: 12,
          //           fontWeight: FontWeight.w400),
          //       SizedBox(height: 10),
          //       Row(
          //         children: [
          //           SizedBox(
          //             width: 20,
          //           ),
          //           InkWell(
          //             onTap: () {
          //               ///job template press
          //             },
          //             child: Container(
          //               padding:
          //                   EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          //               decoration: BoxDecoration(
          //                   color: bgColor,
          //                   border: Border.all(color: btnColor, width: 1)),
          //               child: TextStyleRes.textUbuntuStyleFont3(
          //                   txtColor: txtColor,
          //                   text: "See Job Templates",
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.w300),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}

class JobFeedItem extends StatefulWidget {
  final String budget;
  final String title;
  final String contractType;
  final String postedTime;
  final String description;
  final String hoursNeeded;
  final String duration;
  final String experienceLevel;
  final String uid;
  final List<dynamic> tags;
  final bool jobActiveStatus;
  bool isExpanded;

  String _jobStatus;

  JobFeedItem(
      {this.title,
      this.contractType,
      this.postedTime,
      this.description,
      this.hoursNeeded,
      this.duration,
      this.experienceLevel,
      this.tags,
      this.jobActiveStatus,
      this.isExpanded,
      this.budget,
      this.uid}) {
    if (jobActiveStatus == true)
      _jobStatus = 'Active';
    else
      _jobStatus = 'Hidden';
  }

  @override
  _JobFeedItemState createState() => _JobFeedItemState();
}

class _JobFeedItemState extends State<JobFeedItem> {
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: getDeviceWidth(context) * 0.55,
                          child: TextStyleRes.textUbuntuStyleFont2(
                              text: widget.title,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                        Spacer(),
                        InkWell(
                          highlightColor: Colors.grey,
                          onTap: () => BlocProvider.of<JobActiveCubit>(context)
                              .jobActiveBtn(widget.uid, widget.jobActiveStatus),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                                border: Border.all(color: btnColor, width: 1)),
                            child: TextStyleRes.textUbuntuStyleFont3(
                                txtColor: txtColor,
                                text: "${widget._jobStatus}",
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    TextStyleRes.textUbuntuStyleFont3(
                        txtColor: txtDescriptionColor,
                        text:
                            "${widget.contractType} - Posted ${widget.postedTime}",
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextStyleRes.textUbuntuStyleFont3(
                    txtColor: txtColor,
                    text: widget.description,
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
                                  text: widget.hoursNeeded,
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
                                  text: widget.duration,
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
                                  text: widget.experienceLevel,
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
                //               text: widget.hoursNeeded,
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
                //       width: 10,
                //     ),
                //     Container(
                //       width: (getDeviceWidth(context) - 52) / 3,
                //       color: backContainerColor,
                //       padding: EdgeInsets.all(8),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           TextStyleRes.textUbuntuStyleFont2(
                //               text: widget.duration,
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
                //       width: 10,
                //     ),
                //     Container(
                //       width: (getDeviceWidth(context) - 52) / 3,
                //       color: backContainerColor,
                //       padding: EdgeInsets.all(8),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           TextStyleRes.textUbuntuStyleFont2(
                //               text: widget.experienceLevel,
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
                Visibility(
                    visible: widget.isExpanded,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HireJobItem(
                            "Budget", App.budgetIcon, "${widget.budget}"),
                        SizedBox(
                          height: 10,
                        ),

                        //TODO: FREELANCER CONTRACTED MODULE HERE>>>>> ====== >

                        // TextStyleRes.textUbuntuStyleFont2(
                        //     text: "Freelancers Contracted:",
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w700),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // FreelancerItem("image", "Tester", "Uganda"),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // FreelancerItem("image", "Tester", "Uganda"),
                      ],
                    )),

                InkWell(
                  onTap: () {
                    ///View more Tap
                    setState(() {
                      widget.isExpanded = !widget.isExpanded;
                    });
                  },
                  child: Row(
                    children: [
                      TextStyleRes.textUbuntuStyleFont3(
                          text: widget.isExpanded ? "View Less" : "View More",
                          txtColor: txtDescriptionColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      Icon(
                        widget.isExpanded
                            ? Icons.expand_less
                            : Icons.expand_more,
                        color: txtDescriptionColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
    return widget.tags.map((tag) => get_chip(tag)).toList();
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
}

class FreelancerItem extends StatelessWidget {
  final String image;
  final String name;
  final String address;

  const FreelancerItem(this.image, this.name, this.address);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 40,
            child: CircleAvatar(
              radius: 20,
              child: Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
                size: 40,
              ),
            ),
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              border: new Border.all(
                color: btnColor,
                width: 1.0,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextStyleRes.textUbuntuStyleFont2(
                    text: name, fontSize: 10, fontWeight: FontWeight.w400),
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
                        fontSize: 8,
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
          Container(
            color: btnColor,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    CommonRoutePage().gotoHirePaymentPage(context);
                  },
                  child: TextStyleRes.textUbuntuStyleFont3(
                      txtColor: txtColor,
                      text: "Pay Filmmaker",
                      fontSize: 10,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// =================== POSTING TAB ======================

class PostingTab extends StatelessWidget {
  var searchController = TextEditingController();
  final Query _getCurrentUserJobPost =
      FirebaseRepo.instance.fetchCurrentUserJobPost();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: btnBorderWhite, width: 1),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: getDeviceWidth(context) * 0.55,
                              child: TextFormField(
                                cursorColor: txtColor,
                                controller: searchController,
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
                                    hintText: "Search job postings...",
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
                              width: 10,
                            )
                          ],
                        )),
                    Spacer(),
                    Image.asset(
                      App.filterIcon,
                      height: 14,
                      width: 20,
                      color: btnBorderWhite,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    TextStyleRes.textUbuntuStyleFont3(
                        txtColor: txtDescriptionColor,
                        text: "Filters",
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CommonWidget.squareButton(
                  text: "Post a New Job",
                  fontSize: 12.0,
                  height: 40.0,
                  width: 150.0,
                  containerColor: btnColor,
                  textColor: txtColor,
                  onTap: () {
                    //CommonRoutePage().gotoPostJobPage1(context);
                    Navigator.of(context).pushNamed(PostJobPage1.routeName);
                  },
                ),
              ],
            ),
          ),

          // TODO : REMOVE THIS BUTTON LATER

          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ContractPage.routeName);
              },
              child: Text('Test Button Navigate to Contract Page')),

          StreamBuilder<QuerySnapshot>(
              stream: _getCurrentUserJobPost.snapshots(),
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
                        text: "Alas, no data found",
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  );

                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(
                    child: Padding(
                        padding: EdgeInsets.all(16),
                        child: getCircularProgress(context)),
                  );

                return theJobPosts(snapshot.data.docs);
              }),
          // Expanded(
          //   child: ListView(
          //     children: [
          //       JobFeedItem(
          //         title: "Testing title",
          //         contractType: "Hourly",
          //         postedTime: "10 min",
          //         description:
          //             "Description of the job Description of the job Description of the job Description of the job ",
          //         hoursNeeded: "Less than 30 hours/week",
          //         duration: "1 year",
          //         experienceLevel: "intermediate",
          //         tags: ["Youtube", "Press"],
          //         jobStatus: "Active",
          //         budget: "450",
          //         isExpanded: false,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget theJobPosts(List<QueryDocumentSnapshot<Object>> docs) {
    return Expanded(
      child: ListView.builder(
          itemCount: docs.length,
          itemBuilder: (BuildContext context, int index) {
            JobPostModel data = JobPostModel.fromMap(docs[index].data());
            return JobFeedItem(
              title: data.jobPost,
              contractType: data.projectPaymentType,
              postedTime: data.postTime,
              description: data.description,
              hoursNeeded: data.timeRequirement,
              duration: data.projectDuration,
              experienceLevel: data.freelancerType,
              tags: [...data.editingPlatform, ...data.editingSoftware],
              jobActiveStatus: data.jobActiveStatus,
              budget: data.projectRate,
              uid: docs[index].id,
              isExpanded: false,
            );
          }),
    );
  }
}

class ContractTab extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: btnBorderWhite, width: 1),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: getDeviceWidth(context) * 0.55,
                              child: TextFormField(
                                cursorColor: txtColor,
                                controller: searchController,
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
                                    hintText: "Search job postings...",
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
                              width: 10,
                            )
                          ],
                        )),
                    Spacer(),
                    Image.asset(
                      App.filterIcon,
                      height: 14,
                      width: 20,
                      color: btnBorderWhite,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    TextStyleRes.textUbuntuStyleFont3(
                        txtColor: txtDescriptionColor,
                        text: "Filters",
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CommonWidget.squareButton(
                  text: "Post a New Job",
                  fontSize: 12.0,
                  height: 40.0,
                  width: 150.0,
                  containerColor: btnColor,
                  textColor: txtColor,
                  onTap: () {
                    //CommonRoutePage().gotoPostJobPage1(context);
                    Navigator.of(context).pushNamed(PostJobPage1.routeName);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                JobFeedItem(
                  title: "Testing title",
                  contractType: "Hourly",
                  postedTime: "10 min",
                  description:
                      "fkd f vdnf vdsfvdsfv dkjsf vdsfjv dsfkjv dksfjv ds fjvd fsv",
                  hoursNeeded: "Less than 30 hours/week",
                  duration: "1 year",
                  experienceLevel: "intermediate",
                  tags: ["Youtube", "Press"],
                  jobActiveStatus: true,
                  budget: "450",
                  isExpanded: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HireJobItem extends StatelessWidget {
  final String title;
  final String iconName;
  final String price;

  const HireJobItem(this.title, this.iconName, this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backContainerColor,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          Container(
            color: btnColor,
            padding: EdgeInsets.all(3),
            child: Image.asset(
              iconName,
              color: Colors.black,
              height: 15,
              width: 15,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          TextStyleRes.textUbuntuStyleFont3(
              txtColor: txtDescriptionColor,
              text: title,
              fontSize: 12,
              fontWeight: FontWeight.w700),
          Spacer(),
          TextStyleRes.textUbuntuStyleFont3(
              txtColor: txtColor,
              text: "\$$price",
              fontSize: 12,
              fontWeight: FontWeight.w700),
        ],
      ),
    );
  }
}
