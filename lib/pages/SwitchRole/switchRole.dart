import 'package:dalmia/pages/Accounts/accounthome.dart';
import 'package:dalmia/pages/CDO/cdohome.dart';
import 'package:dalmia/pages/CEO/ceohome.dart';
import 'package:dalmia/pages/LL/ll_home_screen.dart';
import 'package:dalmia/pages/RH/rhhome.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';

import 'package:dalmia/pages/loginUtility/page/login.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import '../../Constants/constants.dart';
import '../../helper/sharedpref.dart';

class SwitchRole extends StatefulWidget {
  const SwitchRole({super.key});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<SwitchRole> {
  @override
  void initState() {
    super.initState();
    checkUserType();
    // Call getStore and update the state variable
  }

  void checkUserType() async {
    var userType;
    try {
      userType = await SharedPrefHelper.getSharedPref(
          USER_TYPES_SHAREDPREF_KEY, context, false);
    } catch (e) {
      return;
    }
    if (!userType.contains(',')) {
      switch (userType) {
        case VDF_USERTYPE:
          await SharedPrefHelper.storeSharedPref(
              USER_TYPE_SHAREDPREF_KEY, userType);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => VdfHome()));
          break;
        case CDO_USERTYPE:
          await SharedPrefHelper.storeSharedPref(
              USER_TYPE_SHAREDPREF_KEY, userType);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CDOHome()));
          break;
        case GPL_USERTYPE:
          await SharedPrefHelper.storeSharedPref(
              USER_TYPE_SHAREDPREF_KEY, userType);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GPLHomeScreen()));
          break;
        case LL_USERTYPE:
          await SharedPrefHelper.storeSharedPref(
              USER_TYPE_SHAREDPREF_KEY, userType);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LLHome()));
          break;
        case RH_USERTYPE:
          await SharedPrefHelper.storeSharedPref(
              USER_TYPE_SHAREDPREF_KEY, userType);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RHHome()));
          break;
        case CEO_USERTYPE:
          await SharedPrefHelper.storeSharedPref(
              USER_TYPE_SHAREDPREF_KEY, userType);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CEOHome()));
          break;
        case ACCOUNTS_USERTYPE:
          await SharedPrefHelper.storeSharedPref(
              USER_TYPE_SHAREDPREF_KEY, userType);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ACCOUNTSHome()));
          break;
        default:
          // For any other userType we have to show a prompt "You  can not use the Application" and redirect on Login page
          await SharedPrefHelper.clearSharedPrefAccess();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // MediaQueryData mediaQueryData = MediaQuery.of(context);
    // double screenWidth = mediaQueryData.size.width;
    return SafeArea(
      child: Scaffold(
        appBar: houseappbar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
          ),
        ),
      ),
    );
  }
}

AppBar houseappbar(BuildContext context) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    automaticallyImplyLeading: false,
    title: const Text(
      'Switch Role',
      style: TextStyle(
          color: Color(0xFF181818),
          fontSize: CustomFontTheme.headingSize,
          fontWeight: CustomFontTheme.headingwt),
    ),
    leading: GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: const Row(
        children: [
          Icon(
            Icons.keyboard_arrow_left_outlined,
            color: Color(0xFF181818),
          ),
          Text(
            'Back',
            style: TextStyle(
                color: Color(0xFF181818), fontWeight: FontWeight.w500),
          )
        ],
      ),
    ),
    backgroundColor: Colors.grey[50],
  );
}
