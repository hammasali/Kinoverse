import 'package:flutter/material.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_route.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/page/hire/home_page/jobs_tab.dart';

import '../../../app.dart';

class ContractPage extends StatefulWidget {
  static const String routeName = '/contract_page';
  @override
  _ContractPageState createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {
  final jobsTabs = ["Summary", "Payment", "Transactions"];
  int _currentPosition = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: btnColor,
        title: TextStyleRes.textStyleFont1(
            text: "Contract",
            fontSize: 14,
            fontWeight: FontWeight.w700,
            textColor: Colors.white),
      ),
      body: Column(
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
                children: [SummaryTab(), PaymentTab(), TransactionTab()],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SummaryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    App.calendarIcon,
                    height: 16,
                    width: 16,
                    color: txtDescriptionColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextStyleRes.textUbuntuStyleFont3(
                      txtColor: txtDescriptionColor,
                      text: "March 20, 2021",
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  ///deposit Tap
                },
                child: Container(
                  width: 140,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: btnBorderWhite,
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        size: 14,
                        color: bgColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextStyleRes.textUbuntuStyleFont3(
                          txtColor: bgColor,
                          text: "Add Deposit",
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          HireJobItem("Deposit", App.depositIcon, "1200"),
          SizedBox(
            height: 10,
          ),
          HireJobItem("Debit", App.depositIcon, "370"),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextStyleRes.textUbuntuStyleFont3(
                      txtColor: Colors.white,
                      text: "Payment Option 1:",
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 35,
                    width: 140,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Image.asset(
                      App.paypalLogo,
                      height: 35,
                      width: 100,
                    ),
                  )
                ],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: btnColor, width: 1),
                ),
                child: TextStyleRes.textUbuntuStyleFont3(
                    txtColor: Colors.white,
                    text: "Active",
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextStyleRes.textUbuntuStyleFont3(
                      txtColor: Colors.white,
                      text: "Payment Option 2:",
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 35,
                    width: 140,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Row(
                      children: [
                        Image.asset(
                          App.bankIcon,
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        TextStyleRes.textUbuntuStyleFont3(
                            txtColor: Colors.black,
                            text: "Bank Account",
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ],
                    ),
                  )
                ],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: btnColor, width: 1),
                ),
                child: TextStyleRes.textUbuntuStyleFont3(
                    txtColor: Colors.white,
                    text: "Active",
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          Spacer(),
          Center(
            child: MaterialButton(
              height: 35.0,
              elevation: 5,
              color: btnColor,
              textColor: Colors.white,
              child: Text(
                'Pay Now',
                textScaleFactor: 1.0,
              ),
              onPressed: () {
                ///PayNow Press
              },
            ),
          )
        ],
      ),
    );
  }
}

class PaymentTab extends StatefulWidget {
  @override
  _PaymentTabState createState() => _PaymentTabState();
}

class _PaymentTabState extends State<PaymentTab> {
  // var isPayoneer = false;
  // var isMasterCard = false;
  // var isBank = false;
  // var isPaypal = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HireJobItem("Budget", App.budgetIcon, "450"),
          SizedBox(
            height: 10,
          ),
          Row(
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
                        text: "Test User",
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
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
                            text: "location",
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          jobItem(context),
          SizedBox(
            height: 10,
          ),
          TextStyleRes.textUbuntuStyleFont2(
              text: "Others filmmakers on this contract:",
              fontSize: 14,
              fontWeight: FontWeight.w700),
          SizedBox(
            height: 5,
          ),
          OtherFreelancerItem("image", "Test User", "location"),
          SizedBox(
            height: 10,
          ),
          TextStyleRes.textUbuntuStyleFont2(
              text: "Payment Method:",
              fontSize: 14,
              fontWeight: FontWeight.w700),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              ///milestones Tap
            },
            child: Container(
              width: 200,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: btnBorderWhite, width: 1),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    size: 14,
                    color: txtColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextStyleRes.textUbuntuStyleFont2(
                      text: "Add or Edit Milestones",
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              ///Payment options Tap
              showDialog(
                  context: context, builder: (_) => CustomPaymentDialogue());
            },
            child: Container(
              width: 200,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: btnBorderWhite, width: 1),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    size: 14,
                    color: txtColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextStyleRes.textUbuntuStyleFont2(
                      text: "Payment options",
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ],
              ),
            ),
          ),
          Spacer(),
          bottomButtons(context),
        ],
      ),
    );
  }

  ///job item
  jobItem(BuildContext context) {
    return Container(
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
                        text: "Job title",
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: btnColor, width: 1)),
                    child: TextStyleRes.textUbuntuStyleFont3(
                        txtColor: txtColor,
                        text: "Active",
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              TextStyleRes.textUbuntuStyleFont3(
                  txtColor: txtDescriptionColor,
                  text: "Due 21 March, 2021",
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
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
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                Icon(
                  Icons.expand_more,
                  color: txtDescriptionColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///bottomButtons
  bottomButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: btnColor, width: 1),
              ),
              height: 35.0,
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CommonWidget.squareButton(
                text: "BACK",
                fontSize: 12.0,
                textColor: Colors.white,
              ),
            ),
          ),
          Spacer(),
          MaterialButton(
            height: 35.0,
            elevation: 5,
            color: btnColor,
            textColor: Colors.white,
            child: Text(
              'Submit for Payment',
              textScaleFactor: 1.0,
            ),
            onPressed: () {
              ///submit for payment tap
              CommonRoutePage().gotoHirePayNowPage(context);
            },
          ),
        ],
      ),
    );
  }

  // showCustomDialog(context) {
  //   return showDialog(
  //     context: context,
  //     // barrierDismissible: false,
  //     builder: (_) => Align(
  //       alignment: Alignment.topCenter,
  //       child: Container(
  //         padding: EdgeInsets.only(top: 120, bottom: 8, left: 16, right: 16),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Center(
  //               child: TextStyleRes.textUbuntuStyleFont2(
  //                   text: "Payment Options",
  //                   fontWeight: FontWeight.w700,
  //                   fontSize: 14),
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             Container(
  //               padding: EdgeInsets.all(16),
  //               color: txtDescriptionColor,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   GestureDetector(
  //                     onTap: () {
  //                       setState(() {
  //                         isPaypal = true;
  //                         isPayoneer = false;
  //                         isMasterCard = false;
  //                         isBank = false;
  //                       });
  //                     },
  //                     child: Row(
  //                       children: [
  //                         Image.asset(
  //                           App.paypalLogo,
  //                           height: 50,
  //                           width: 100,
  //                         ),
  //                         Spacer(),
  //                         Image.asset(
  //                           isPaypal ? App.selectedIcon : App.unselectedIcon,
  //                           height: 16,
  //                           width: 16,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   GestureDetector(
  //                     onTap: () {
  //                       setState(() {
  //                         isPaypal = false;
  //                         isPayoneer = true;
  //                         isMasterCard = false;
  //                         isBank = false;
  //                       });
  //                     },
  //                     child: Row(
  //                       children: [
  //                         Image.asset(
  //                           App.payoneerLogo,
  //                           height: 50,
  //                           width: 80,
  //                         ),
  //                         Spacer(),
  //                         Image.asset(
  //                           isPayoneer ? App.selectedIcon : App.unselectedIcon,
  //                           height: 16,
  //                           width: 16,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   GestureDetector(
  //                     onTap: () {
  //                       setState(() {
  //                         isPaypal = false;
  //                         isPayoneer = false;
  //                         isMasterCard = true;
  //                         isBank = false;
  //                       });
  //                     },
  //                     child: Row(
  //                       children: [
  //                         Image.asset(
  //                           App.mastercardIcon,
  //                           height: 40,
  //                           width: 80,
  //                         ),
  //                         Spacer(),
  //                         Image.asset(
  //                           isMasterCard
  //                               ? App.selectedIcon
  //                               : App.unselectedIcon,
  //                           height: 16,
  //                           width: 16,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 20,
  //                   ),
  //                   GestureDetector(
  //                     onTap: () {
  //                       setState(() {
  //                         isPaypal = false;
  //                         isPayoneer = false;
  //                         isMasterCard = false;
  //                         isBank = true;
  //                       });
  //                     },
  //                     child: Row(
  //                       children: [
  //                         Image.asset(
  //                           App.bankIcon,
  //                           height: 20,
  //                           width: 20,
  //                         ),
  //                         SizedBox(
  //                           width: 10,
  //                         ),
  //                         TextStyleRes.textUbuntuStyleFont3(
  //                             text: "Back Account",
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.w400,
  //                             txtColor: Colors.black),
  //                         Spacer(),
  //                         Image.asset(
  //                           isBank ? App.selectedIcon : App.unselectedIcon,
  //                           height: 16,
  //                           width: 16,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       MaterialButton(
  //                         height: 30.0,
  //                         elevation: 5,
  //                         color: bgColor,
  //                         textColor: Colors.white,
  //                         child: Text(
  //                           'Cancel',
  //                           textScaleFactor: 1.0,
  //                         ),
  //                         onPressed: () {
  //                           ///Cancel Tap
  //                           Navigator.pop(context);
  //                         },
  //                       ),
  //                       SizedBox(
  //                         width: 10,
  //                       ),
  //                       MaterialButton(
  //                         height: 30.0,
  //                         elevation: 5,
  //                         color: btnColor,
  //                         textColor: Colors.white,
  //                         child: Text(
  //                           'Submit',
  //                           textScaleFactor: 1.0,
  //                         ),
  //                         onPressed: () {
  //                           ///submit tap
  //                         },
  //                       ),
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

class CustomPaymentDialogue extends StatefulWidget {
  @override
  _CustomPaymentDialogueState createState() => _CustomPaymentDialogueState();
}

class _CustomPaymentDialogueState extends State<CustomPaymentDialogue> {
  var isPayoneer = false;
  var isMasterCard = false;
  var isBank = false;
  var isPaypal = true;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.only(top: 100, bottom: 8, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: TextStyleRes.textUbuntuStyleFont2(
                    text: "Payment Options",
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(16),
                color: txtDescriptionColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isPaypal = true;
                          isPayoneer = false;
                          isMasterCard = false;
                          isBank = false;
                        });
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            App.paypalLogo,
                            height: 50,
                            width: 100,
                          ),
                          Spacer(),
                          Image.asset(
                            isPaypal ? App.selectedIcon : App.unselectedIcon,
                            height: 16,
                            width: 16,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isPaypal = false;
                          isPayoneer = true;
                          isMasterCard = false;
                          isBank = false;
                        });
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            App.payoneerLogo,
                            height: 50,
                            width: 80,
                          ),
                          Spacer(),
                          Image.asset(
                            isPayoneer ? App.selectedIcon : App.unselectedIcon,
                            height: 16,
                            width: 16,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isPaypal = false;
                          isPayoneer = false;
                          isMasterCard = true;
                          isBank = false;
                        });
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            App.mastercardIcon,
                            height: 40,
                            width: 80,
                          ),
                          Spacer(),
                          Image.asset(
                            isMasterCard
                                ? App.selectedIcon
                                : App.unselectedIcon,
                            height: 16,
                            width: 16,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isPaypal = false;
                          isPayoneer = false;
                          isMasterCard = false;
                          isBank = true;
                        });
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            App.bankIcon,
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              text: "Back Account",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              txtColor: Colors.black),
                          Spacer(),
                          Image.asset(
                            isBank ? App.selectedIcon : App.unselectedIcon,
                            height: 16,
                            width: 16,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          height: 30.0,
                          elevation: 5,
                          color: bgColor,
                          textColor: Colors.white,
                          child: Text(
                            'Cancel',
                            textScaleFactor: 1.0,
                          ),
                          onPressed: () {
                            ///Cancel Tap
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                          height: 30.0,
                          elevation: 5,
                          color: btnColor,
                          textColor: Colors.white,
                          child: Text(
                            'Submit',
                            textScaleFactor: 1.0,
                          ),
                          onPressed: () {
                            ///submit tap
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OtherFreelancerItem extends StatelessWidget {
  final String image;
  final String name;
  final String address;
  const OtherFreelancerItem(this.image, this.name, this.address);
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
                    text: name, fontSize: 14, fontWeight: FontWeight.w700),
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
                        fontSize: 12,
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
                    /// add to payment tap
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        App.addPeopleIcon,
                        color: Colors.white,
                        width: 12,
                        height: 12,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      TextStyleRes.textUbuntuStyleFont3(
                          txtColor: txtColor,
                          text: "Add to Payment",
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TransactionTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextStyleRes.textUbuntuStyleFont2(
          text: "Transactions Tab", fontSize: 14, fontWeight: FontWeight.w400),
    );
  }
}
