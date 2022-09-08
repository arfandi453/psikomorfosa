import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/detail_doctor/views/widgets/review_card.dart';
import 'package:hallo_doctor_client/app/utils/constants/style_constants.dart';

import '../../../utils/constants/constants.dart';
import '../controllers/detail_doctor_controller.dart';

class DetailDoctorView extends GetView<DetailDoctorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor'.tr ,style: TextStyle(fontFamily: "Nunito",fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        foregroundColor: Color.fromRGBO(163, 144, 201, 1),
        centerTitle: true,
      ),
      body: Stack(children: [
        controller.obx((doctor) => Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  buildImage(secondaryColor,
                      doctorProfilePic: doctor!.doctorPicture!),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    doctor.doctorName!,
                    style: doctorNameStyle,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  // Text(
                  //   doctor.categoryName!,
                  //   style: doctorCategoryStyle,
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                  RatingBarIndicator(
                      rating: 4.5,
                      itemCount: 5,
                      itemSize: 20.0,
                      itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Biography'.tr,
                      style: TextStyle(
                        fontFamily: "Nunito",fontWeight:FontWeight.bold

                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    doctor.doctorShortBiography!,
                    style: subTitleTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Review',
                        style: TextStyle(
                            fontFamily: "Nunito",fontWeight:FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('View All'.tr, style: TextStyle(fontFamily: "Nunito",color:Color.fromRGBO(163, 144, 201, 1),fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                  Container(
                    height: 150,
                    width: double.infinity,
                    child: GetBuilder<DetailDoctorController>(
                      builder: (_) {
                        return ListView.builder(
                            itemCount: _.listReview.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return ReviewCard(review: _.listReview[index]);
                            });
                      },
                    ),
                  )
                ]),
              ),
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 80,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(15, 2, 10, 2),
            decoration: BoxDecoration(
              color: mBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: controller.selectedDoctor.doctorPrice != null
                      ? Text(
                          currencySign +
                              ' ' +
                              controller.selectedDoctor.doctorPrice!.toString(),
                          style: priceNumberTextStyle,
                        )
                      : Text(
                          currencySign + ' 0',
                          style: priceNumberTextStyle,
                        ),
                  flex: 2,
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 3, 10),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed('/consultation-date-picker',
                              arguments: [controller.selectedDoctor, null]);
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(150, 149, 238, 1),
                                    Color.fromRGBO(251, 199, 212, 1),
                                  ]
                              )
                          ),
                          child: Text(
                            'Boock Consultation'.tr,
                            style: TextStyle(color: Colors.white, fontFamily: "Nunito"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => controller.toChatDoctor(),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                        gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(150, 149, 238, 1),
                              Color.fromRGBO(251, 199, 212, 1),
                            ]
                        )
                    ),
                    child: Icon(
                      Icons.message_rounded,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

// Builds Profile Image
Widget buildImage(Color color, {String doctorProfilePic = ''}) {
  final defaultImage = doctorProfilePic.isEmpty
      ? AssetImage('assets/images/user.png')
      : NetworkImage(doctorProfilePic);

  return Container(
    child: CircleAvatar(
      radius: 53,
      backgroundColor: Color.fromRGBO(163, 144, 201, 1),
      child: CircleAvatar(
        backgroundImage: defaultImage as ImageProvider,
        radius: 50,
      ),
    ),
  );
}
