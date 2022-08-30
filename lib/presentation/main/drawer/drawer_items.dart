import 'package:books/presentation/main/drawer/drawer_list.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({ Key? key }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return  ListView(
              padding: EdgeInsets.zero,
              children: [
                 DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        blurRadius: 10,
                        spreadRadius: 7,
                      )
                    ]
                  ),
                  child: Image.asset("assets/images/splash_logo.png",fit: BoxFit.cover,),
                ),
                SizedBox(height: 10,),
               DrawerList(icon: Icons.all_inbox_outlined,iconColor: ColorManager.primary, text: "All Items",tap: (){},),
              DrawerList(icon: Icons.favorite,text: "Favourites",iconColor: ColorManager.primary,),
               DrawerList(icon: Icons.help,text: "Help",iconColor: ColorManager.primary,tap: (){}),
               DrawerList(icon: Icons.support, text: "Support",iconColor: ColorManager.primary,),
               DrawerList(icon: Icons.system_security_update_good, text: "Terms and Condition",iconColor: ColorManager.primary,tap: (){},),
                GestureDetector(
                   onTap: (){
        
                },
                  child: DrawerList(icon: Icons.logout_sharp,text: "Logout",iconColor: ColorManager.primary,)),
              ],
            );
  }
}