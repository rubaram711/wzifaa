import 'package:flutter/material.dart';
import 'package:wazefaa/consts/colors.dart';
import 'package:wazefaa/widgets/reusable_review_row.dart';
import 'package:wazefaa/widgets/reusable_save_button.dart';
import 'package:wazefaa/widgets/reusable_share_button.dart';

class ReusableCareerCard extends StatelessWidget {
  const ReusableCareerCard({
    Key? key,
    required this.isWeInDetailsPage,
    required this.id,
    required this.title,
    required this.location,
    required this.views,
    required this.content,
    required this.logo,
    required this.company,
  }) : super(key: key);
  final bool isWeInDetailsPage;
  final String id;
  final String title;
  final String company;
  final String location;
  final String views;
  final String content;
  final String logo;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isWeInDetailsPage
            ? null
            : Navigator.pushNamed(context, '/career_details', arguments: {
                'id': id,
                'title': title,
                'company': company,
                'location': location,
                'views': views,
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
                    isWeInDetailsPage
                        ? const SizedBox()
                        : const Text('وظائف شاغرة'),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.push_pin,
                          size: 17,
                          color: Colors.grey[700],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(location,)
                      ],
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            isWeInDetailsPage
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: kSecondaryColor)),
                        child: Center(
                          child: Text(
                            company,
                            style: const TextStyle(
                                color: kSecondaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      ReusableReviewRow(
                        review: views,
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
