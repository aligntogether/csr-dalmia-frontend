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
                          imageUrl: 'images/t_house.svg',
                          subtitle: 'Total Household',
                          title: '150',
                          bg: Color(0xFFB94216).withOpacity(0.4),
                          // bg: const Color.fromARGB(255, 252, 215, 184),
                          // bg: Colors.white,
                          textcolor: const Color(0xFFB94216),
                        ),
                        CustomCard(
                          imageUrl: 'images/m_house.svg',
                          title: '150',
                          subtitle: 'Mapped Household',
                          bg: const Color.fromARGB(255, 252, 215, 184),
                          textcolor: const Color(0xFFB94216),
                        ),
                        CustomCard(
                          imageUrl: 'images/s_house.svg',
                          title: '130',
                          subtitle: 'Selected for Intervention',
                          bg: const Color.fromARGB(255, 252, 215, 184),
                          textcolor: const Color(0xFFB94216),
                        ),
                      ],
                    ))
              ],
            ),
            const SizedBox(
              height: 40,
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
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      children: [
                        CustomCard(
                          imageUrl: 'images/i_house.svg',
                          subtitle: 'Household covered',
                          title: '30',
                          bg: Color.fromARGB(204, 185, 255, 223),
                          textcolor: const Color(0xFF0C7243),
                        ),
                        CustomCard(
                          imageUrl: 'images/i_planned.svg',
                          title: '100',
                          subtitle: 'Intervention planned',
                          bg: const Color.fromARGB(204, 185, 255, 223),
                          textcolor: const Color(0xFF0C7243),
                        ),
                        CustomCard(
                          imageUrl: 'images/icompleted.svg',
                          title: '25',
                          bg: const Color.fromARGB(204, 185, 255, 223),
                          subtitle: 'Interventions completed',
                          textcolor: const Color(0xFF0C7243),
                        ),
                      ],
                    ))
              ],
            ),
            const SizedBox(
              height: 40,
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
                          imageUrl: 'images/overdue.svg',
                          subtitle: 'Overdue',
                          title: '1',
                          bg: Color.fromARGB(223, 169, 221, 249),
                          textcolor: const Color(0xFF064F96),
                        ),
                      ),
                      const SizedBox(
                        width: 120,
                      ),
                      const SizedBox(
                        width: 120,
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20, bottom: 0, top: 0),
                  child: RichText(
                    text: const TextSpan(
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
                  padding: const EdgeInsets.only(left: 10),
                  child: FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: 10,
                      runSpacing: 20, // Adjust this value as needed
                      children: [
                        CustomCard(
                          imageUrl: 'images/income.svg',
                          subtitle: 'Less than 25k',
                          title: '70',
                          bg: const Color.fromARGB(255, 174, 218, 240),
                          textcolor: const Color(0xFF0374AD),
                        ),
                        CustomCard(
                          imageUrl: 'images/income.svg',
                          title: '40',
                          subtitle: '25k to 50k',
                          bg: const Color.fromARGB(255, 174, 218, 240),
                          textcolor: const Color(0xFF0374AD),
                        ),
                        CustomCard(
                          imageUrl: 'images/income.svg',
                          title: '10',
                          subtitle: '50k to 75k',
                          bg: const Color.fromARGB(255, 174, 218, 240),
                          textcolor: const Color(0xFF0374AD),
                        ),
                        CustomCard(
                          imageUrl: 'images/income.svg',
                          title: '10',
                          subtitle: '50k to 75k',
                          bg: const Color.fromARGB(255, 174, 218, 240),
                          textcolor: const Color(0xFF0374AD),
                        ),
                        CustomCard(
                          imageUrl: 'images/income.svg',
                          title: '10',
                          subtitle: 'More than 1L',
                          bg: const Color.fromARGB(255, 174, 218, 240),
                          textcolor: const Color(0xFF0374AD),
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
