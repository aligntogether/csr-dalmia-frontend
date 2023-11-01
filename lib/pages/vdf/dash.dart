import 'package:dalmia/components/cards.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class DashTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
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
                    'Households Summary',
                    style: TextStyle(
                      fontSize: CustomFontTheme.headingSize,
                      fontWeight: CustomFontTheme.headingwt,
                    ),
                  ),
                ),
                FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      // spacing: 50,
                      children: [
                        CustomCard(
                          imageUrl: 'images/t_house.png',
                          subtitle: 'Total Household',
                          title: '150',
                          bg: Color.fromARGB(255, 252, 215, 184),
                          textcolor: Color(0xFFB94216),
                        ),
                        CustomCard(
                          imageUrl: 'images/m_house.png',
                          title: '150',
                          subtitle: 'Mapped Household',
                          bg: Color.fromARGB(255, 252, 215, 184),
                          textcolor: Color(0xFFB94216),
                        ),
                        CustomCard(
                          imageUrl: 'images/s_house.png',
                          title: '130',
                          subtitle: 'Selected for Intervention',
                          bg: Color.fromARGB(255, 252, 215, 184),
                          textcolor: Color(0xFFB94216),
                        ),
                      ],
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: const Text(
                    'Interventions',
                    style: TextStyle(
                      fontSize: CustomFontTheme.headingSize,
                      fontWeight: CustomFontTheme.headingwt,
                    ),
                  ),
                ),
                FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomCard(
                          imageUrl: 'images/i_house.png',
                          subtitle: 'Household covered',
                          title: '30',
                          bg: Color.fromARGB(144, 161, 255, 211),
                          textcolor: Color(0xFF0C7243),
                        ),
                        CustomCard(
                          imageUrl: 'images/i_planned.png',
                          title: '100',
                          subtitle: 'Intervention planned',
                          bg: Color.fromARGB(144, 161, 255, 211),
                          textcolor: Color(0xFF0C7243),
                        ),
                        CustomCard(
                          imageUrl: 'images/icompleted.png',
                          title: '25',
                          bg: Color.fromARGB(144, 161, 255, 211),
                          subtitle: 'Interventions completed',
                          textcolor: Color(0xFF0C7243),
                        ),
                      ],
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: const Text(
                    'Follow up',
                    style: TextStyle(
                      fontSize: CustomFontTheme.headingSize,
                      fontWeight: CustomFontTheme.headingwt,
                    ),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    children: [
                      Container(
                        child: CustomCard(
                          imageUrl: 'images/overdue.png',
                          subtitle: 'Overdue',
                          title: '1',
                          bg: Color.fromARGB(223, 142, 188, 245),
                          textcolor: Color(0xFF064F96),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                      ),
                      SizedBox(
                        width: 120,
                      ),
                    ],
                  ),
                )
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
                          style: TextStyle(
                            fontSize: CustomFontTheme.headingSize,
                            fontWeight: CustomFontTheme.headingwt,
                          ),
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
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: 10,
                      runSpacing: 20, // Adjust this value as needed
                      children: [
                        CustomCard(
                          imageUrl: 'images/income.png',
                          subtitle: 'Less than 25k',
                          title: '70',
                          bg: Color.fromARGB(255, 174, 218, 240),
                          textcolor: Color(0xFF0374AD),
                        ),
                        CustomCard(
                          imageUrl: 'images/income.png',
                          title: '40',
                          subtitle: '25k to 50k',
                          bg: Color.fromARGB(255, 174, 218, 240),
                          textcolor: Color(0xFF0374AD),
                        ),
                        CustomCard(
                          imageUrl: 'images/income.png',
                          title: '10',
                          subtitle: '50k to 75k',
                          bg: Color.fromARGB(255, 174, 218, 240),
                          textcolor: Color(0xFF0374AD),
                        ),
                        CustomCard(
                          imageUrl: 'images/income.png',
                          title: '10',
                          subtitle: '50k to 75k',
                          bg: Color.fromARGB(255, 174, 218, 240),
                          textcolor: Color(0xFF0374AD),
                        ),
                        CustomCard(
                          imageUrl: 'images/income.png',
                          title: '10',
                          subtitle: 'More than 1L',
                          bg: Color.fromARGB(255, 174, 218, 240),
                          textcolor: Color(0xFF0374AD),
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
