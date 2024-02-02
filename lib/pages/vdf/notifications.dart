import 'package:dalmia/apis/commonobject.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import '../../theme.dart';

//create a notfication page
class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(

        title: Text("Notifications" ,style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: MySize.screenHeight * (18/MySize.screenHeight),

        ),),
        centerTitle: true,
      ),
      body: Container(
        height: MySize.screenHeight/3,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            CircleAvatar(
              radius: MySize.screenHeight * (40/MySize.screenHeight),
              backgroundColor: CustomColorTheme.primaryColor,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Notifications(),
                    ),
                  );
                },
                icon: const Icon(
                  size: 60,
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text("You don't have any notifications",style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: MySize.screenHeight * (14/MySize.screenHeight),

              ),),
            ),

          ],
        )

      )
    );
  }
}