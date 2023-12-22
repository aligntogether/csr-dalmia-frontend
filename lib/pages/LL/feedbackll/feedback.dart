// import 'package:dalmia/common/app_style.dart';
// import 'package:dalmia/common/image_constant.dart';
// import 'package:flutter/material.dart';

// class LLFeedback extends StatefulWidget {
//   const LLFeedback({super.key});

//   @override
//   State<LLFeedback> createState() => _LLFeedbackState();
// }

// class _LLFeedbackState extends State<LLFeedback> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: Text(
//             'Feedback',
//             style: AppStyle.textStyleInterMed(
//                 fontSize: 16, fontWeight: FontWeight.w800),
//           ),
//           centerTitle: true,
//           actions: [
//             InkWell(
//                 onTap: () {
//                   // Get.back();
//                 },
//                 child: Icon(Icons.close)),
//             SizedBox(
//               height: 20,
//             ),
//           ],
//         ),
//         body: Column(
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 2,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       Divider(
//                         height: 1,
//                         color: Color(0xff181818).withOpacity(0.3),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 11, vertical: 13),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Image.asset(
//                               ImageConstant.feed,
//                               height: 24,
//                               width: 24,
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "CEO",
//                                   style:
//                                       AppStyle.textStyleBoldMed(fontSize: 14),
//                                 ),
//                                 SizedBox(
//                                   height: 2,
//                                 ),
//                                 Text("18 Oct | 10.30 am")
//                               ],
//                             ),
//                             Spacer(),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(right: 22, top: 10),
//                               child: Image.asset(
//                                 ImageConstant.arrowB,
//                                 height: 18,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             GestureDetector(
//                 onTap: () {
//                   // Get.to(FeedBackChatView());
//                 },
//                 child: commonButton(
//                   title: "Send New Feedback",
//                 )),
//             SizedBox(
//               height: 40,
//             ),
//           ],
//         ));
//   }
// }
