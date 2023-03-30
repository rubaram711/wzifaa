import 'package:flutter/material.dart';
import 'package:wazefaa/consts/colors.dart';
import 'package:wazefaa/widgets/reusable_rating_row.dart';
import 'package:wazefaa/widgets/reusable_save_button.dart';
import 'package:wazefaa/widgets/reusable_share_button.dart';

class ReusableCompanyCard extends StatelessWidget {
  const ReusableCompanyCard({
    Key? key,
    //required this.infoMap,
    required this.isWeInDetailsPage,
    required this.id,
    required this.title,
    required this.jobsCount,
    required this.rating,
    required this.review,
    required this.content,
    required this.logo,
  }) : super(key: key);
  // final Map<String, dynamic> infoMap;
  final bool isWeInDetailsPage;
  final String id;
  final String title;
  final String jobsCount;
  final String rating;
  final String review;
  final String content;
  final String logo;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isWeInDetailsPage
            ? null
            : Navigator.pushNamed(context, '/company_details', arguments: {
                'id': id,
                'title': title,
                'jobsCount': jobsCount,
                'rating': rating,
                'review': review,
                'content': content,
                'logo': logo
              });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: kBgColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                ReusableSaveButton(),
                SizedBox(
                  width: 20,
                ),
                ReusableShareButton(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 32,
                    child: Image.asset(logo)),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        title,
                        style: const TextStyle(
                            color: kThirdColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        ReusableRatingRow(rating: int.parse(rating)),
                        const SizedBox(
                          width: 15,
                        ),
                        review == ''
                            ? const Text('(Review 0)')
                            : Text('(Review $review)'),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    isWeInDetailsPage
                        ? const SizedBox()
                        : Row(
                            children: [
                              Icon(
                                Icons.cases_rounded,
                                size: 17,
                                color: Colors.grey[700],
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              jobsCount == '0'
                                  ? const Text('لا يوجد وظائف شاغرة')
                                  : Text('يوجد $jobsCount وظيفة شاغرة'),
                            ],
                          )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
