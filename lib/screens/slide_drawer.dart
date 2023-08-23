import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomDrawerWidget extends StatefulWidget {
  const CustomDrawerWidget({super.key});

  @override
  CustomDrawerWidgetState createState() => CustomDrawerWidgetState();
}

class CustomDrawerWidgetState extends State<CustomDrawerWidget> {

  @override
  Widget build(BuildContext context) {


    return  Drawer(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            color: HexColor('#BA4949'),
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const CircleAvatar(
                  radius: 50,
                  child: Icon(
                    Icons.person,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Name",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
                  softWrap: true,
                ),
                Text(
                  "Email",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                  ),
                  softWrap: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(
              Icons.person_outline,
              color: Colors.white,
            ),
            title: const Text(
              "DrawerText.profile",
            ),
            onTap: () {
              // Navigator.pushNamed(
              //   context,
              //   RouteConstantName.profile,
              // );
            },
          ),
          // ListTile(
          //   leading:
          //   Icon(Icons.info_outline, color: ColorCode.navIconColor),
          //   title: const Text("pl"),
          //   onTap: () {
          //     List data = ["1.0.0", "1.0.0", "1.1.0"];
          //    // showSimpleModal(context, data);
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.star, color: ColorCode.navIconColor),
          //   title: const Text('Rating'),
          //   onTap: () {},
          // ),
          // ListTile(
          //   leading: Icon(Icons.delete, color: ColorCode.navIconColor),
          //   title: const Text('Delete Account'),
          //   onTap: () {
          //     Navigator.pushNamed(
          //       context,
          //       RouteConstantName.deleteAccount,
          //     );
          //   },
          // ),

          // const Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.white),
            title: const Text('Logout'),
            onTap: () {
              // SharedPrefs.clear();
              // Navigator.pushNamed(
              //   context,
              //   RouteConstantName.authScreen,
              // );
            },
          ),
        ],
      ),
    );
  }

  // void showSimpleModal(BuildContext context, data) {
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Center(child: Text(About.insightDBVersion,style: TextStyle(fontWeight: FontWeight.bold))),
  //         content: const Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Center(child: Text(About.coreService, style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18))),
  //             Center(child: Text(About.dashboardService,style: TextStyle(),textAlign: TextAlign.justify,)),
  //           ],
  //         ),
  //         actions: <Widget>[
  //
  //           TextButton(
  //             child: const Text('Update'),
  //             onPressed: () {
  //               Navigator.of(context).pop(); // Close the dialog
  //             },
  //           ),
  //           TextButton(
  //             child: const Text('Close'),
  //             onPressed: () {
  //               Navigator.of(context).pop(); // Close the dialog
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
