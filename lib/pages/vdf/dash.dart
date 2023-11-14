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
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          bg: Color(0xFFF2D4C9),

                          // bg: Colors.white,
                          textcolor: const Color(0xFFB94216),
                        ),
                        CustomCard(
                          imageUrl: 'images/m_house.svg',
                          title: '150',
                          subtitle: 'Mapped Household',
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          bg: Color(0xFFF2D4C9),
                          textcolor: const Color(0xFFB94216),
                        ),
                        CustomCard(
                          imageUrl: 'images/s_house.svg',
                          title: '130',
                          subtitle: 'Selected for Intervention',
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          bg: Color(0xFFF2D4C9),
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
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          title: '30',
                          bg: Color(0xFFC2D7CD),
                          textcolor: const Color(0xFF0C7243),
                        ),
                        CustomCard(
                          imageUrl: 'images/i_planned.svg',
                          title: '100',
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          subtitle: 'Intervention planned',
                          bg: Color(0xFFC2D7CD),
                          textcolor: const Color(0xFF0C7243),
                        ),
                        CustomCard(
                          imageUrl: 'images/icompleted.svg',
                          title: '25',
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          bg: Color(0xFFC2D7CD),
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
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          title: '1',
                          bg: Color(0xFFC2D3E3),
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
                  padding: const EdgeInsets.only(left: 00),
                  child: FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      // spacing: 10,
                      // runSpacing: 20, // Adjust this value as needed
                      children: [
                        CustomCard(
                          imageUrl: 'images/income.svg',
                          subtitle: 'Less than 25k',
                          title: '70',
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          bg: const Color(0xFFC2DEEC),
                          textcolor: const Color(0xFF0374AD),
                        ),
                        CustomCard(
                          imageUrl: 'images/income.svg',
                          title: '40',
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          subtitle: '25k to 50k',
                          bg: const Color(0xFFC2DEEC),
                          textcolor: const Color(0xFF0374AD),
                        ),
                        CustomCard(
                          imageUrl: 'images/income.svg',
                          title: '10',
                          subtitle: '50k to 75k',
                          bg: const Color(0xFFC2DEEC),
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          textcolor: const Color(0xFF0374AD),
                        ),
                        CustomCard(
                          imageUrl: 'images/income.svg',
                          title: '10',
                          subtitle: '50k to 75k',
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          bg: const Color(0xFFC2DEEC),
                          textcolor: const Color(0xFF0374AD),
                        ),
                        CustomCard(
                          imageUrl: 'images/income.svg',
                          title: '10',
                          subtitle: 'More than 1L',
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          bg: const Color(0xFFC2DEEC),
                          textcolor: const Color(0xFF0374AD),
                        ),
                        CustomCard(
                          imageUrl: 'images/income.svg',
                          title: '0',
                          subtitle: 'Zero Income',
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          bg: const Color(0xFFC2DEEC),
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
