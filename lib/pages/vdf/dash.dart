import 'package:dalmia/components/cards.dart';
import 'package:flutter/material.dart';

class DashTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25),
      color: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: const Text(
                    'Houseolds Covered',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomCard(
                          imageUrl: 'images/household.png',
                          subtitle: 'Total Household',
                          title: '150',
                        ),
                        CustomCard(
                            imageUrl: 'images/shared.png',
                            title: '150',
                            subtitle: 'Mapped Household'),
                        CustomCard(
                            imageUrl: 'images/interv.png',
                            title: '130',
                            subtitle: 'Selected for Intervention'),
                      ],
                    ))
              ],
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: const Text(
                    'Interventions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomCard(
                          imageUrl: 'images/ihouse.png',
                          subtitle: 'Household covered',
                          title: '30',
                        ),
                        CustomCard(
                            imageUrl: 'images/iplanned.png',
                            title: '100',
                            subtitle: 'Intervention plaaned'),
                        CustomCard(
                            imageUrl: 'images/icompleted.png',
                            title: '25',
                            subtitle: 'Household completed'),
                      ],
                    ))
              ],
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20, bottom: 10, top: 20),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Household with additional\n income',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' (per annum)\n'),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      // crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      children: [
                        CustomCard(
                          imageUrl: 'images/income.png',
                          subtitle: 'Less than 25k',
                          title: '70',
                        ),
                        CustomCard(
                          imageUrl: 'images/income.png',
                          title: '40',
                          subtitle: '25k to 50k',
                        ),
                        CustomCard(
                          imageUrl: 'images/income.png',
                          title: '10',
                          subtitle: '50k to 75k',
                        ),
                        CustomCard(
                          imageUrl: 'images/income.png',
                          title: '10',
                          subtitle: '50k to 75k',
                        ),
                        CustomCard(
                          imageUrl: 'images/income.png',
                          title: '10',
                          subtitle: '50k to 75k',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
